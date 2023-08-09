//---------------------------------------------
// Copyright 2023 Katolieke Universiteit Leuven (KUL)
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
// Author: Ryan Antonio (ryan.antonio@kuleuven.be)
//---------------------------------------------
// Description:
// This test bench was used to test out and build the snax shell prototype.
// It should give the users an idea on how it was built.
//---------------------------------------------

// verilog_lint: waive-start line-length
// verilog_lint: waive-start no-trailing-spaces

//---------------------------------------------
// Type definitions to include
//---------------------------------------------
`include "axi/assign.svh"
`include "axi/typedef.svh"
`include "common_cells/assertions.svh"
`include "common_cells/registers.svh"

`include "mem_interface/typedef.svh"
`include "register_interface/typedef.svh"
`include "reqrsp_interface/typedef.svh"
`include "tcdm_interface/typedef.svh"

`include "snitch_vm/typedef.svh"

//---------------------------------------------
// Packages to include
//---------------------------------------------
import snax_snitch_pkg::*;
import snitch_ssr_pkg::*;
import snitch_pma_pkg::*;
import fpnew_pkg::*;
import reqrsp_pkg::*;

module tb_snax_shell_wb;

    //---------------------------------------------
    // Prototype parameters
    // Note: These were originally based on the Snitch cluster
    //---------------------------------------------

    parameter int unsigned PhysicalAddrWidth        = 48;
    parameter int unsigned NarrowDataWidth          = 64;
    parameter int unsigned WideDataWidth            = 512;
    parameter int unsigned WideIdWidthIn            = 1;
    parameter int unsigned WideUserWidth            = 1;
    parameter int unsigned DMAAxiReqFifoDepth       = 3;
    parameter int unsigned DMAReqFifoDepth          = 3;
    parameter int unsigned BootAddr                 = 32'h0000_1000;

    parameter int unsigned NumIntOutstandingLoads   = 4; // This controls how many load transactions can be buffered in the Snitch's LSU
    parameter int unsigned NumIntOutstandingMem     = 4;
    parameter int unsigned NumFPOutstandingLoads    = 4;
    parameter int unsigned NumFPOutstandingMem      = 4;

    parameter int unsigned NumDTLBEntries           = 1;
    parameter int unsigned NumITLBEntries           = 1;
    parameter int unsigned NumSequencerInstr        = 16;
    parameter int unsigned NumSsrs                  = 3;
    parameter int unsigned SsrMuxRespDepth          = 4;

    parameter int unsigned RegisterOffloadReq       = 0;
    parameter int unsigned RegisterOffloadRsp       = 0;
    parameter int unsigned RegisterCoreReq          = 0;
    parameter int unsigned RegisterCoreRsp          = 0;
    parameter int unsigned RegisterFPUReq           = 0;
    parameter int unsigned RegisterSequencer        = 0;
    parameter int unsigned RegisterFPUIn            = 0;
    parameter int unsigned RegisterFPUOut           = 0;

    localparam int unsigned NrBanks                 = 8;    // Default was 32 - but kept small for TCDM port testing purposes
    localparam int unsigned TCDMDepth               = 64;   // Default was 512 - but kept small for TCDM port testing purposes
    localparam int unsigned TCDMSize                = NrBanks * TCDMDepth * (NarrowDataWidth/8);
    localparam int unsigned TCDMAddrWidth           = $clog2(TCDMSize);


    //---------------------------------------------
    // For generated modules, a 1'b1 means they exist
    //---------------------------------------------
    parameter int unsigned RVE         = 1'b0;
    parameter int unsigned RVF         = 1'b0;
    parameter int unsigned RVD         = 1'b0;
    parameter int unsigned XDivSqrt    = 1'b0;
    parameter int unsigned XF16        = 1'b0;
    parameter int unsigned XF16ALT     = 1'b0;
    parameter int unsigned XF8         = 1'b0;
    parameter int unsigned XF8ALT      = 1'b0;
    parameter int unsigned XFVEC       = 1'b0;
    parameter int unsigned XFDOTP      = 1'b0;
    parameter int unsigned Xdma        = 1'b1;
    parameter int unsigned IsoCrossing = 1'b0;
    parameter int unsigned Xfrep       = 1'b0;
    parameter int unsigned Xssr        = 1'b0;
    parameter int unsigned Xipu        = 1'b0;
    parameter int unsigned VMSupport   = 1'b0;

    //---------------------------------------------
    // Necessary type definitions
    //---------------------------------------------

    typedef logic [PhysicalAddrWidth-1:0] addr_t;
    typedef logic [  NarrowDataWidth-1:0] data_t;
    typedef logic [NarrowDataWidth/8-1:0] strb_t;
    typedef logic [    TCDMAddrWidth-1:0] tcdm_addr_t;
    typedef logic [    WideIdWidthIn-1:0] id_dma_mst_t;
    typedef logic [    WideDataWidth-1:0] data_dma_t;
    typedef logic [  WideDataWidth/8-1:0] strb_dma_t;
    typedef logic [    WideUserWidth-1:0] user_dma_t;

    typedef struct packed {
        logic core_id;
        bit   is_core;
    } tcdm_user_t;

    typedef struct packed {
        acc_addr_e   addr;
        logic [4:0]  id;
        logic [31:0] data_op;
        data_t       data_arga;
        data_t       data_argb;
        addr_t       data_argc;
    } acc_req_t;

    typedef struct packed {
        logic [4:0] id;
        logic       error;
        data_t      data;
    } acc_rsp_t;

    // Can be found in snitch_vm/typedef.svh
    // for pa_t
    `SNITCH_VM_TYPEDEF(PhysicalAddrWidth)

    typedef struct packed {
        // Slow domain.
        logic          flush_i_valid;
        addr_t         inst_addr;
        logic          inst_cacheable;
        logic          inst_valid;
        // Fast domain.
        acc_req_t      acc_req;
        logic          acc_qvalid;
        logic          acc_pready;
        // Slow domain.
        logic [1:0]    ptw_valid;
        va_t  [1:0]    ptw_va;      // Found in snitch_pkg
        pa_t  [1:0]    ptw_ppn;     // Found in snitch_vm.svh
    } hive_req_t;

    typedef struct packed {
        // Slow domain.
        logic          flush_i_ready;
        logic [31:0]   inst_data;
        logic          inst_ready;
        logic          inst_error;
        // Fast domain.
        logic          acc_qready;
        acc_rsp_t      acc_resp;
        logic          acc_pvalid;
        // Slow domain.
        logic [1:0]    ptw_ready;
        l0_pte_t [1:0] ptw_pte;
        logic [1:0]    ptw_is_4mega;
    } hive_rsp_t;

    typedef struct packed {
        logic aw_stall, ar_stall, r_stall, w_stall,
                    buf_w_stall, buf_r_stall;
        logic aw_valid, aw_ready, aw_done, aw_bw;
        logic ar_valid, ar_ready, ar_done, ar_bw;
        logic r_valid,  r_ready,  r_done, r_bw;
        logic w_valid,  w_ready,  w_done, w_bw;
        logic b_valid,  b_ready,  b_done;
        logic dma_busy;
        axi_pkg::len_t aw_len, ar_len;
        axi_pkg::size_t aw_size, ar_size;
        logic [$clog2(WideDataWidth/8):0] num_bytes_written;
    } dma_events_t;


    //---------------------------------------------
    // SSR Configurations
    // They come from the snitch_ssr_pkg!
    //---------------------------------------------
    localparam ssr_cfg_t [3-1:0] SsrCfgs [1] = '{
        '{
            '{0, 0, 0, 0, 1, 1, 4, 14, 17, 3, 4, 3, 8, 4, 3},
            '{0, 0, 0, 0, 1, 1, 4, 14, 17, 3, 4, 3, 8, 4, 3},
            '{0, 0, 0, 0, 1, 1, 4, 14, 17, 3, 4, 3, 8, 4, 3}
        }
    };

    localparam logic [3-1:0][4:0] SsrRegs [1] = '{
        '{2, 1, 0}
    };

    //---------------------------------------------
    // VM stuff of snitch
    //---------------------------------------------
    snitch_pma_t SnitchPMACfg;

    //---------------------------------------------
    // Keep 0 for now
    //---------------------------------------------
    fpu_implementation_t FPUImplementation;

    //---------------------------------------------
    // Type definitions. Need to checkout the following from 
    // their respective declarations. They all come from the `include above this file
    //
    // AXI_TYPEDEF_ALL     - can be found in axi/typedef.svh
    // REQRSP_TYPEDEF_ALL  - can be found in reqrsp_interface/typedef.svh
    // MEM_TYPEDEF_ALL     - can be found in mem_interface/typedef.svh
    // TCDM_TYPEDEF_ALL    - can be found in tcdm_interface/typedef.svh
    // REG_BUS_TYPEDEF_REQ - can be found in register_interface/typedef.svh
    //---------------------------------------------

    //---------------------------------------------
    // This generates the following:
    // reqrsp_req_t
    // reqrsp_rsp_t
    //---------------------------------------------

    `REQRSP_TYPEDEF_ALL(reqrsp, addr_t, data_t, strb_t)

    //---------------------------------------------
    // This generates the following:
    // tcdm_req_t
    // tcdm_rsp_t
    //---------------------------------------------

    `TCDM_TYPEDEF_ALL(tcdm, tcdm_addr_t, data_t, strb_t, tcdm_user_t)

    //---------------------------------------------
    // This generates the following:
    // axi_mst_dma_req_t
    // axi_mst_dma_resp_t - note that it really is resp_t based on definition
    //---------------------------------------------

    `AXI_TYPEDEF_ALL(axi_mst_dma, addr_t, id_dma_mst_t, data_dma_t, strb_dma_t, user_dma_t)


    //---------------------------------------------
    // Wiring and stimuli declaration
    //---------------------------------------------
    hive_req_t          hive_req_o;
    hive_rsp_t          hive_rsp_i;

    interrupts_t        irq_i; // You can find interrupts_t from the snitch_pkg

    reqrsp_req_t        data_req_o;
    reqrsp_rsp_t        data_rsp_i;

    tcdm_req_t          tcdm_req_o;
    tcdm_rsp_t          tcdm_rsp_i;

    axi_mst_dma_req_t   axi_dma_req_o;
    axi_mst_dma_resp_t  axi_dma_res_i;

    //---------------------------------------------
    // Clock and reset
    //---------------------------------------------
    logic clk_i;
    logic rst_ni;


    //---------------------------------------------
    // Instruction memory
    //---------------------------------------------
    logic [PhysicalAddrWidth-1:0] inst_mem [0:1024];
    logic [PhysicalAddrWidth-1:0] instruction_addr_offset;

	initial begin $readmemh("./mem/inst/comb_mem_lw.txt", inst_mem); end

	// Dirty fix to offset the instruction memory since boot starts at 4096
	always_comb begin
		instruction_addr_offset = hive_req_o.inst_addr - 48'd4096;
	end

    assign hive_rsp_i.inst_data  = inst_mem[(instruction_addr_offset >> 2)];
    assign hive_rsp_i.inst_ready = 1;

    //---------------------------------------------
    // Data memory
    //---------------------------------------------
    logic [NarrowDataWidth-1:0] data_mem [0:255];

	initial begin $readmemh("./mem/data/rand_data_1.txt", data_mem); end

    // This signal is to fake a start-up because starting immediately on a load
    // Messes up the simulation so we need to have a "fake" start-up
    logic start_mem;
    logic [NarrowDataWidth-1:0] data_addr_offset;
    logic [NarrowDataWidth-1:0] next_data_mem;

    assign data_addr_offset = data_req_o.q.addr >> 3;
    assign next_data_mem = data_mem[data_addr_offset];

    // Main memory control incorporated in the fake startup
    always_ff @ (posedge clk_i or negedge rst_ni) begin

        if(!rst_ni) begin

            start_mem <= 1'b0;
            data_rsp_i.p_valid <= 1'b0;
            data_rsp_i.p.data  <= 64'd0;
            data_rsp_i.p.error <= 0;

        end else begin

            if(!start_mem) begin
                start_mem <= 1'b1;
            end else begin
                start_mem <= start_mem;
            end
            
            data_rsp_i.p_valid <= (start_mem) ? data_rsp_i.q_ready & data_req_o.q_valid: 1'b0;
            data_rsp_i.p.data  <= (start_mem) ?  next_data_mem : '0;
            data_rsp_i.p.error <= 0;

        end
        
    end

    // Synchronized writing of data since this messes up the simulation
    // Need to accommodate memory multiplexing for this part
    // Let's assume first that no arbitration is set
    always @ (posedge clk_i) begin

        if((data_req_o.q.write  & data_req_o.q_valid) & data_rsp_i.q_ready) begin
            data_mem[data_addr_offset] <= data_req_o.q.data;
        end

    end

    //assign data_rsp_i.p.data  = data_mem[data_rsp_i.q.addr >> 2];
    assign data_rsp_i.q_ready = (start_mem) ? 1'b1 : 1'b0;

    //---------------------------------------------
    // TCDM Data memory
    //---------------------------------------------
    logic [NarrowDataWidth-1:0] tcdm_data_mem [0:255];

	initial begin $readmemh("./mem/data/rand_data_2.txt", tcdm_data_mem); end

    // This signal is to fake a start-up because starting immediately on a load
    // Messes up the simulation so we need to have a "fake" start-up
    logic [NarrowDataWidth-1:0] tcdm_data_addr_offset;
    logic [NarrowDataWidth-1:0] tcdm_next_data_mem;

    assign tcdm_data_addr_offset = tcdm_req_o.q.addr >> 3;
    assign tcdm_next_data_mem    = tcdm_data_mem[tcdm_data_addr_offset];

    // Main memory control incorporated in the fake startup
    always_ff @ (posedge clk_i or negedge rst_ni) begin

        if(!rst_ni) begin

            tcdm_rsp_i.p.data  <= 64'd0;
            tcdm_rsp_i.p_valid <= 1'b0;
            
        end else begin
            
            tcdm_rsp_i.p.data  <= (start_mem) ? tcdm_next_data_mem : '0;
            tcdm_rsp_i.p_valid <= (start_mem) ? tcdm_rsp_i.q_ready & tcdm_req_o.q_valid: 1'b0;
            
        end
        
    end

    // Synchronized writing of data since this messes up the simulation
    // Need to accommodate memory multiplexing for this part
    // Let's assume first that no arbitration is set
    always @ (posedge clk_i) begin

        if((tcdm_req_o.q.write  & tcdm_req_o.q_valid) & tcdm_rsp_i.q_ready) begin
            tcdm_data_mem[tcdm_data_addr_offset] <= tcdm_req_o.q.data;
        end

    end

    //assign data_rsp_i.p.data  = data_mem[data_rsp_i.q.addr >> 2];
    assign tcdm_rsp_i.q_ready = (start_mem) ? 1'b1 : 1'b0;


    //---------------------------------------------
    // Main snax shell module
    //---------------------------------------------

    snax_shell #(
      .AddrWidth              ( PhysicalAddrWidth       ), 
      .DataWidth              ( NarrowDataWidth         ),
      .DMADataWidth           ( WideDataWidth           ),
      .DMAIdWidth             ( WideIdWidthIn           ),
      //.SnitchPMACfg           ( SnitchPMACfg          ), // TODO: Find me later
      .DMAAxiReqFifoDepth     ( DMAAxiReqFifoDepth      ),
      .DMAReqFifoDepth        ( DMAReqFifoDepth         ),
      .dreq_t                 ( reqrsp_req_t            ),
      .drsp_t                 ( reqrsp_rsp_t            ),
      .tcdm_req_t             ( tcdm_req_t              ),
      .tcdm_rsp_t             ( tcdm_rsp_t              ),
      .tcdm_user_t            ( tcdm_user_t             ),
      .axi_req_t              ( axi_mst_dma_req_t       ),
      .axi_rsp_t              ( axi_mst_dma_resp_t      ),
      .hive_req_t             ( hive_req_t              ),
      .hive_rsp_t             ( hive_rsp_t              ),
      .acc_req_t              ( acc_req_t               ),
      .acc_resp_t             ( acc_rsp_t               ),
      .dma_events_t           ( dma_events_t            ),
      .BootAddr               ( BootAddr                ),
      .RVE                    ( RVE                     ),
      .RVF                    ( RVF                     ),
      .RVD                    ( RVD                     ),
      .XDivSqrt               ( XDivSqrt                ),
      .XF16                   ( XF16                    ),
      .XF16ALT                ( XF16ALT                 ),
      .XF8                    ( XF8                     ),
      .XF8ALT                 ( XF8ALT                  ),
      .XFVEC                  ( XFVEC                   ),
      .XFDOTP                 ( XFDOTP                  ),
      .Xdma                   ( Xdma                    ),
      .IsoCrossing            ( IsoCrossing             ),
      .Xfrep                  ( Xfrep                   ),
      .Xssr                   ( Xssr                    ),
      .Xipu                   ( Xipu                    ),
      .VMSupport              ( VMSupport               ),
      .NumIntOutstandingLoads ( NumIntOutstandingLoads  ),
      .NumIntOutstandingMem   ( NumIntOutstandingMem    ),
      .NumFPOutstandingLoads  ( NumFPOutstandingLoads   ),
      .NumFPOutstandingMem    ( NumFPOutstandingMem     ),
      //.FPUImplementation      ( FPUImplementation     ), //TODO: Find out about this
      .NumDTLBEntries         ( NumDTLBEntries          ),
      .NumITLBEntries         ( NumITLBEntries          ),
      .NumSequencerInstr      ( NumSequencerInstr       ),
      .NumSsrs                ( NumSsrs                 ),
      .SsrMuxRespDepth        ( SsrMuxRespDepth         ),
      .SsrCfgs                ( '0                      ), //TODO: Fix me later
      .SsrRegs                ( '0                      ), //TODO: Fix me later
      .RegisterOffloadReq     ( RegisterOffloadReq      ),
      .RegisterOffloadRsp     ( RegisterOffloadRsp      ),
      .RegisterCoreReq        ( RegisterCoreReq         ),
      .RegisterCoreRsp        ( RegisterCoreRsp         ),
      .RegisterFPUReq         ( RegisterFPUReq          ),
      .RegisterSequencer      ( RegisterSequencer       ),
      .RegisterFPUIn          ( RegisterFPUIn           ),
      .RegisterFPUOut         ( RegisterFPUOut          ),
      .TCDMAddrWidth          ( TCDMAddrWidth           )
    ) i_snitch_cc (
      .clk_i                  ( clk_i                   ),
      .clk_d2_i               ( clk_i                   ), // Note: Use same clock
      .rst_ni                 ( rst_ni                  ),
      .rst_int_ss_ni          ( 1'b1                    ), // Always available
      .rst_fp_ss_ni           ( 1'b1                    ), // Always available
      .hart_id_i              ( '0                      ), // 9-bits hardwired naming
      .hive_req_o             ( hive_req_o              ),
      .hive_rsp_i             ( hive_rsp_i              ),
      .irq_i                  ( irq_i                   ),
      .data_req_o             ( data_req_o              ),
      .data_rsp_i             ( data_rsp_i              ),
      .tcdm_req_o             ( tcdm_req_o              ),
      .tcdm_rsp_i             ( tcdm_rsp_i              ),
      .axi_dma_req_o          ( axi_dma_req_o           ),
      .axi_dma_res_i          ( axi_dma_res_i           ),
      .axi_dma_busy_o         (                         ), // Leave this unused first
      .axi_dma_perf_o         (                         ), // Leave this unused first
      .axi_dma_events_o       (                         ), // Leave this unused first
      .core_events_o          (                         ), // Leave this unused first
      .tcdm_addr_base_i       ( 48'h0000_0000_1000      )  // TODO: Fix me later. Assume starting is at 0 first
    );


    //---------------------------------------------
    // Always on clock
    //---------------------------------------------
    always begin #10; clk_i <= !clk_i; end

    //---------------------------------------------
    // Stimuli
    //---------------------------------------------
    initial begin

        clk_i  <= 0;
        rst_ni <= 0;

        //---------------------------------------------
        // Initialize stimuli for guidance
        //---------------------------------------------

        hive_rsp_i.flush_i_ready <= 0;
        hive_rsp_i.inst_error    <= 0;

        hive_rsp_i.acc_qready    <= 0;
        hive_rsp_i.acc_resp      <= 0;
        hive_rsp_i.acc_pvalid    <= 0;

        hive_rsp_i.ptw_ready     <= 0;
        hive_rsp_i.ptw_pte       <= 0;
        hive_rsp_i.ptw_is_4mega  <= 0;

        irq_i.debug <= 0;
        irq_i.meip  <= 0;
        irq_i.mtip  <= 0;
        irq_i.msip  <= 0;
        irq_i.mcip  <= 0;

        axi_dma_res_i.aw_ready <= 0;
        axi_dma_res_i.ar_ready <= 0;
        axi_dma_res_i.w_ready  <= 0;
        axi_dma_res_i.b_valid  <= 0;
        axi_dma_res_i.b.id     <= 0;
        axi_dma_res_i.b.resp   <= 0;
        axi_dma_res_i.b.user   <= 0;
        axi_dma_res_i.r_valid  <= 0;
        axi_dma_res_i.r.id     <= 0;
        axi_dma_res_i.r.data   <= 0;
        axi_dma_res_i.r.resp   <= 0;
        axi_dma_res_i.r.last   <= 0;
        axi_dma_res_i.r.user   <= 0;

        @(posedge clk_i);
        @(posedge clk_i);

        rst_ni <= 1;

        @(posedge clk_i);
        @(posedge clk_i);

        #2000;
        $stop();

    end

// verilog_lint: waive-stop line-length
// verilog_lint: waive-stop no-trailing-spaces

endmodule