//---------------------------------------------
// Copyright 2023 Katolieke Universiteit Leuven (KUL)
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
// Author: Ryan Antonio (ryan.antonio@kuleuven.be)
//---------------------------------------------

module snax_local_mem_mux #(
  parameter int unsigned AddrWidth        = 48,
  parameter int unsigned NarrowDataWidth  = 32,
  parameter int unsigned WideDataWidth    = 512,
  parameter int unsigned LocalMemSize     = 1024,
  parameter int unsigned CoreIDWidth      = 5,
  parameter int unsigned NumBanks         = WideDataWidth/NarrowDataWidth,   // Need to maximize banks depending on WideDataWidth
  parameter type         addr_t           = logic,
  parameter type         data_t           = logic,
  parameter type         strb_t           = logic,
  parameter type         mem_req_t        = logic,                    // Memory request payload type, usually write enable, write data, etc.
  parameter type         mem_rsp_t        = logic                     // Memory response payload type, usually read data
)(
  input  logic                     clk_i,         // Clock
  input  logic                     rst_ni,        // Asynchronous reset, active low
  input  logic                     dma_access_i,  // For indicating if it's a dma access
  input  mem_req_t [NumBanks-1:0]  mem_req_i,     // Memory valid-ready format
  output mem_rsp_t [NumBanks-1:0]  mem_rsp_o      // Memory valid-ready format
);

  

  // generate banks of the superbank
  for (genvar i = 0; i < NumBanks; i++) begin : gen_local_mem_banks

    logic  mem_cs;
    logic  mem_wen;
    addr_t mem_add;
    strb_t mem_be;
    data_t mem_rdata;
    data_t mem_wdata;

    // This is the actual SRAM model
    // You can find this in tech cells repository: .bender/git/tech_cells_*/src/rtl
    tc_sram_impl #(
      .NumWords  ( LocalMemSize     ),
      .DataWidth ( NarrowDataWidth  ),
      .ByteWidth ( 8                ),
      .NumPorts  ( 1                ),
      .Latency   ( 1                )
      // .impl_in_t (               )  // TODO: Use me later when we do implementation later
    ) i_data_mem (
      .clk_i     ( clk_i            ),
      .rst_ni    ( rst_ni           ),
      .impl_i    ( '0               ), // TODO: Use me later when we do implementation later
      .impl_o    (                  ),
      .req_i     ( mem_cs           ),
      .we_i      ( mem_wen          ),
      .addr_i    ( mem_add          ),
      .wdata_i   ( mem_wdata        ),
      .be_i      ( mem_be           ),
      .rdata_o   ( mem_rdata        )
    );

    data_t amo_rdata_local;

    // TODO(zarubaf): Share atomic units between mutltiple cuts
    snitch_amo_shim #(
      .AddrMemWidth   ( AddrWidth                   ),
      .DataWidth      ( NarrowDataWidth             ),
      .CoreIDWidth    ( CoreIDWidth                 )
    ) i_amo_shim (
      .clk_i          ( clk_i                       ),
      .rst_ni         ( rst_ni                      ),
      .valid_i        ( mem_req_i[i].q_valid        ),
      .ready_o        ( mem_rsp_o[i].q_ready        ),
      .addr_i         ( mem_req_i[i].q.addr         ),
      .write_i        ( mem_req_i[i].q.write        ),
      .wdata_i        ( mem_req_i[i].q.data         ),
      .wstrb_i        ( mem_req_i[i].q.strb         ),
      .core_id_i      ( mem_req_i[i].q.user.core_id ),
      .is_core_i      ( mem_req_i[i].q.user.is_core ),
      .rdata_o        ( amo_rdata_local             ),
      .amo_i          ( mem_req_i[i].q.amo          ),
      .mem_req_o      ( mem_cs                      ),
      .mem_add_o      ( mem_add                     ),
      .mem_wen_o      ( mem_wen                     ),
      .mem_wdata_o    ( mem_wdata                   ),
      .mem_be_o       ( mem_be                      ),
      .mem_rdata_i    ( mem_rdata                   ),
      .dma_access_i   ( dma_access_i                ),
      // TODO(zarubaf): Signal AMO conflict somewhere. Socregs?
      .amo_conflict_o (                             )
    );

    // Insert a pipeline register at the output of each SRAM.
    shift_reg #( 
      .dtype  ( data_t              ),
      .Depth  ( 1                   )
    ) i_sram_pipe (
      .clk_i  ( clk_i               ), 
      .rst_ni ( rst_ni              ),
      .d_i    ( amo_rdata_local     ),
      .d_o    ( mem_rsp_o[i].p.data )
    );

  end


endmodule

/* ------------------ Module usage ------------------

snax_local_mem_mux #(
  .AddrWidth        ( AddrWidth       ),
  .NarrowDataWidth  ( NarrowDataWidth ),
  .WideDataWidth    ( WideDataWidth   ),
  .LocalMemSize     ( LocalMemSize    ),
  .NumBanks         ( NumBanks        ),  // Need to maximize banks depending on WideDataWidth
  .addr_t           ( addr_t          ),
  .data_t           ( data_t          ),
  .strb_t           ( strb_t          ),
  .mem_req_t        ( mem_req_t       ),  // Memory request payload type, usually write enable, write data, etc.
  .mem_rsp_t        ( mem_rsp_t       )   // Memory response payload type, usually read data
) i_snax_local_mem_mux (
  .clk_i            ( clk_i           ),  // Clock
  .rst_ni           ( rst_ni          ),  // Asynchronous reset, active low
  .mem_req_i        ( mem_req_i       ),  // Memory valid-ready format
  .mem_rsp_o        ( mem_rsp_o       ),  // Memory valid-ready format
);

----------------------------------------------------- */