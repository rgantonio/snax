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

`timescale 1ns/1ps

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

module tb_snax_wb;

    //---------------------------------------------
    // Prototype parameters
    // Note: These were originally based on the Snitch cluster
    //---------------------------------------------

    parameter int unsigned PhysicalAddrWidth        = 48;
    parameter int unsigned NarrowDataWidth          = 32;
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

    parameter int unsigned SnaxLocalMemPorts        = 4;

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
    localparam int unsigned TCDMAddrWidth           = $clog2(TCDMSize); //Default was $clog2(TCDMSize) but we can change to 10 bits for now

    localparam int unsigned NrWideMasters  = 1;
    localparam int unsigned WideIdWidthOut =  WideIdWidthIn;


    //---------------------------------------------
    // For generated modules, a 1'b1 means they exist
    //---------------------------------------------
    parameter bit RVE         = 1'b0;
    parameter bit RVF         = 1'b0;
    parameter bit RVD         = 1'b0;
    parameter bit XDivSqrt    = 1'b0;
    parameter bit XF16        = 1'b0;
    parameter bit XF16ALT     = 1'b0;
    parameter bit XF8         = 1'b0;
    parameter bit XF8ALT      = 1'b0;
    parameter bit XFVEC       = 1'b0;
    parameter bit XFDOTP      = 1'b0;
    parameter bit Xdma        = 1'b0;
    parameter bit IsoCrossing = 1'b0;
    parameter bit Xfrep       = 1'b0;
    parameter bit Xssr        = 1'b0;
    parameter bit Xipu        = 1'b0;
    parameter bit VMSupport   = 1'b0;
    parameter bit SNAX        = 1'b1;

    //---------------------------------------------
    // Necessary type definitions
    //---------------------------------------------

    typedef logic [PhysicalAddrWidth-1:0] addr_t;
    typedef logic [  NarrowDataWidth-1:0] data_t;
    typedef logic [NarrowDataWidth/8-1:0] strb_t;
    typedef logic [    47:0] tcdm_addr_t; //Watch out for me
    typedef logic [    WideIdWidthIn-1:0] id_dma_mst_t;
    typedef logic [   WideIdWidthOut-1:0] id_dma_slv_t;
    typedef logic [    WideDataWidth-1:0] data_dma_t;
    typedef logic [  WideDataWidth/8-1:0] strb_dma_t;
    typedef logic [    WideUserWidth-1:0] user_dma_t;

    typedef struct packed {
        logic [4:0] core_id;
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
    `TCDM_TYPEDEF_ALL(tcdm_dma, tcdm_addr_t, data_dma_t, strb_dma_t, logic)

    //---------------------------------------------
    // This generates the following:
    // axi_mst_dma_req_t
    // axi_mst_dma_resp_t - note that it really is resp_t based on definition
    //---------------------------------------------

    `AXI_TYPEDEF_ALL(axi_mst_dma, addr_t, id_dma_mst_t, data_dma_t, strb_dma_t, user_dma_t)
    `AXI_TYPEDEF_ALL(axi_slv_dma, addr_t, id_dma_slv_t, data_dma_t, strb_dma_t, user_dma_t)

    //---------------------------------------------
    // This generates the following:
    // mem_dma_req_t
    // mem_dma_rsp_t
    //---------------------------------------------
    `MEM_TYPEDEF_ALL(mem_dma, tcdm_addr_t, data_dma_t, strb_dma_t, logic)


    //---------------------------------------------
    // Wiring and stimuli declaration
    //---------------------------------------------
    hive_req_t          hive_req_o;
    hive_rsp_t          hive_rsp_i;

    interrupts_t        irq_i; // You can find interrupts_t from the snitch_pkg

    reqrsp_req_t        data_req_o;
    reqrsp_rsp_t        data_rsp_i;

    tcdm_req_t [NumSsrs-1:0] tcdm_req_o;
    tcdm_rsp_t [NumSsrs-1:0] tcdm_rsp_i;

    tcdm_req_t [SnaxLocalMemPorts-1:0] hwpe_tcdm_req_o;
    tcdm_rsp_t [SnaxLocalMemPorts-1:0] hwpe_tcdm_rsp_i;

    axi_mst_dma_req_t   axi_dma_req_o;
    axi_mst_dma_resp_t  axi_dma_res_i;

		//---------------------------------------------
    // SNAX wiring
    //---------------------------------------------
		acc_req_t 	snax_req;
		logic 			snax_qvalid;
		logic 			snax_qready;
		acc_rsp_t 	snax_resp;
		logic 			snax_pvalid;
		logic 			snax_pready;
		tcdm_req_t 	[SnaxLocalMemPorts-1:0 ] snax_tcdm_req;
		tcdm_rsp_t 	[SnaxLocalMemPorts-1:0 ] snax_tcdm_rsp;


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

		initial begin $readmemh("./mem/inst/mac_test.txt", inst_mem); end

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

    // Seperate start memory for now
    always_ff @ (posedge clk_i or negedge rst_ni) begin
        if(!rst_ni) begin
            start_mem <= 1'b0;
        end else begin
            if(!start_mem) begin
                start_mem <= 1'b1;
            end else begin
                start_mem <= start_mem;
            end
        end
    end

    // Main memory control incorporated in the fake startup
    always_ff @ (posedge clk_i or negedge rst_ni) begin
        if(!rst_ni) begin
            data_rsp_i.p_valid <= 1'b0;
            data_rsp_i.p.data  <= 64'd0;
            data_rsp_i.p.error <= 0;
        end else begin
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

    assign data_rsp_i.q_ready = (start_mem) ? 1'b1 : 1'b0;


    //---------------------------------------------
    // DMA Control Simulation
    //---------------------------------------------
    tcdm_dma_req_t ext_dma_req;
    tcdm_dma_rsp_t ext_dma_rsp;

    addr_t ext_dma_req_q_addr_nontrunc;

    axi_to_mem_interleaved #(
        .axi_req_t    ( axi_slv_dma_req_t           ),
        .axi_resp_t   ( axi_slv_dma_resp_t          ),
        .AddrWidth    ( PhysicalAddrWidth           ),
        .DataWidth    ( WideDataWidth               ),
        .IdWidth      ( WideIdWidthOut              ),
        .NumBanks     ( 1                           ),
        .BufDepth     ( 1                           )  // Leave at one for now
    ) i_axi_to_mem_dma (
        .clk_i        ( clk_i                       ),
        .rst_ni       ( rst_ni                      ),
        .busy_o       (                             ),
        .axi_req_i    ( axi_dma_req_o               ),
        .axi_resp_o   ( axi_dma_res_i               ),
        .mem_req_o    ( ext_dma_req.q_valid         ),
        .mem_gnt_i    ( ext_dma_rsp.q_ready         ),
        .mem_addr_o   ( ext_dma_req_q_addr_nontrunc ),
        .mem_wdata_o  ( ext_dma_req.q.data          ),
        .mem_strb_o   ( ext_dma_req.q.strb          ),
        .mem_atop_o   ( /* The DMA does not support atomics */),
        .mem_we_o     ( ext_dma_req.q.write         ),
        .mem_rvalid_i ( ext_dma_rsp.p_valid         ),
        .mem_rdata_i  ( ext_dma_rsp.p.data          )
    );

    assign ext_dma_req.q.addr = tcdm_addr_t'(ext_dma_req_q_addr_nontrunc - 4096);
    assign ext_dma_req.q.amo  = reqrsp_pkg::AMONone;
    assign ext_dma_req.q.user = '0;

    mem_dma_req_t sb_dma_req;
    mem_dma_rsp_t sb_dma_rsp;

    snitch_tcdm_interconnect #(
        .NumInp                 ( 1                  ),
        .NumOut                 ( 1                  ),
        .tcdm_req_t             ( tcdm_dma_req_t     ),
        .tcdm_rsp_t             ( tcdm_dma_rsp_t     ),
        .mem_req_t              ( mem_dma_req_t      ),
        .mem_rsp_t              ( mem_dma_rsp_t      ),
        .user_t                 ( logic              ),
        .MemAddrWidth           ( 10                 ),
        .DataWidth              ( WideDataWidth      ),
        .MemoryResponseLatency  ( 1                  )
    ) i_dma_interconnect (
        .clk_i                  ( clk_i              ),
        .rst_ni                 ( rst_ni             ),
        .req_i                  ( ext_dma_req        ),
        .rsp_o                  ( ext_dma_rsp        ),
        .mem_req_o              ( sb_dma_req         ),
        .mem_rsp_i              ( sb_dma_rsp         )
    );
    

    parameter int unsigned LocalMemSize       = 1024;
    parameter int unsigned LocalMemAddrWidth  = $clog2(LocalMemSize);

    typedef logic [LocalMemAddrWidth-1:0] mem_addr_t;
    typedef logic                  [31:0] mem_data_t;
    typedef logic                  [ 3:0] mem_strb_t;

    `MEM_TYPEDEF_ALL(mem, mem_addr_t, mem_data_t, mem_strb_t, tcdm_user_t)

    mem_req_t [15:0] dma_mem_req;
    mem_rsp_t [15:0] dma_mem_rsp;

    mem_wide_narrow_mux #(
      .NarrowDataWidth  ( 32                ), // TODO: Fix me later
      .WideDataWidth    ( WideDataWidth     ),
      .mem_narrow_req_t ( mem_req_t         ),
      .mem_narrow_rsp_t ( mem_rsp_t         ),
      .mem_wide_req_t   ( mem_dma_req_t     ),
      .mem_wide_rsp_t   ( mem_dma_rsp_t     )
    ) i_mem_wide_narrow_mux (
      .clk_i,
      .rst_ni,
      .in_narrow_req_i  ( '0 ),
      .in_narrow_rsp_o  (  ),
      .in_wide_req_i    ( sb_dma_req         ),
      .in_wide_rsp_o    ( sb_dma_rsp         ), // TODO: Add me later
      .out_req_o        ( dma_mem_req        ),
      .out_rsp_i        ( dma_mem_rsp        ),
      .sel_wide_i       ( sb_dma_req.q_valid )  // TODO: Add me later
    );

    snax_local_mem_mux #(
      .LocalMemAddrWidth  ( LocalMemAddrWidth    ),
      .NarrowDataWidth    ( 32                   ),
      .WideDataWidth      ( WideDataWidth        ),
      .LocalMemSize       ( LocalMemSize         ),
      .NumBanks           ( 16                   ), // Need to maximize banks depending on WideDataWidth
      .ReadMem            ( 1'b1                 ),
      .ReadMemFile        ( "./mem/data/data_mem.txt"),
      .SimInit            ( "random"             ),
      .addr_t             ( mem_addr_t           ),
      .data_t             ( mem_data_t           ),
      .strb_t             ( mem_strb_t           ),
      .mem_req_t          ( mem_req_t            ), // Memory request payload type, usually write enable, write data, etc.
      .mem_rsp_t          ( mem_rsp_t            )  // Memory response payload type, usually read data
    ) i_snax_local_mem_mux (
      .clk_i              ( clk_i                ), // Clock
      .rst_ni             ( rst_ni               ), // Asynchronous reset, active low
      .dma_access_i       ( sb_dma_req.q_valid   ),
      .mem_req_i          ( dma_mem_req          ), // Memory valid-ready format
      .mem_rsp_o          ( dma_mem_rsp          )  // Memory valid-ready format local_mem_narrow_rsp
    );

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
      .SNAX                   ( SNAX                    ),
      .NumIntOutstandingLoads ( NumIntOutstandingLoads  ),
      .NumIntOutstandingMem   ( NumIntOutstandingMem    ),
      .NumFPOutstandingLoads  ( NumFPOutstandingLoads   ),
      .NumFPOutstandingMem    ( NumFPOutstandingMem     ),
      //.FPUImplementation      ( FPUImplementation     ), //TODO: Find out about this
      .NumDTLBEntries         ( NumDTLBEntries          ),
      .NumITLBEntries         ( NumITLBEntries          ),
      .NumSequencerInstr      ( NumSequencerInstr       ),
      .NumSsrs                ( NumSsrs                 ),
      .SnaxLocalMemPorts      ( SnaxLocalMemPorts       ),
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
    ) i_snax_shell (
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
			.snax_req_o         		( snax_req        			  ),
			.snax_qvalid_o      		( snax_qvalid     			  ),
			.snax_qready_i      		( snax_qready     			  ),
			.snax_resp_i        		( snax_resp       			  ),
			.snax_pvalid_i      		( snax_pvalid     			  ),
			.snax_pready_o      		( snax_pready     			  ),
			.snax_tcdm_req_i    		( snax_tcdm_req   			  ),
			.snax_tcdm_rsp_o    		( snax_tcdm_rsp   			  ),
      .tcdm_addr_base_i       ( 48'h0000_0000_1000      ), // TODO: Fix me later. Assume starting is at 0 first
      .localmem_addr_base_i   ( 48'h0000_0000_1000      )
    );


		snax_mac # (
			.DataWidth          ( 32         				),
			.SnaxLocalMemPorts  ( SnaxLocalMemPorts	),
			.acc_req_t          ( acc_req_t       	),
			.acc_rsp_t         	( acc_rsp_t      		),
			.tcdm_req_t         ( tcdm_req_t      	),
			.tcdm_rsp_t         ( tcdm_rsp_t      	)
		) i_snax_mac (
			.clk_i              ( clk_i           	),
			.rst_ni             ( rst_ni          	),
			.snax_req_i         ( snax_req        	),
			.snax_qvalid_i      ( snax_qvalid     	),
			.snax_qready_o      ( snax_qready     	),
			.snax_resp_o        ( snax_resp       	),
			.snax_pvalid_o      ( snax_pvalid     	),
			.snax_pready_i      ( snax_pready     	),
			.snax_tcdm_req_o    ( snax_tcdm_req   	),
			.snax_tcdm_rsp_i    ( snax_tcdm_rsp   	)
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

        

        @(posedge clk_i);
        @(posedge clk_i);

        rst_ni <= 1;

        @(posedge clk_i);
        @(posedge clk_i);

        #5000;
        $stop();

    end

// verilog_lint: waive-stop line-length
// verilog_lint: waive-stop no-trailing-spaces

endmodule
