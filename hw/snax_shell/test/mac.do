onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {clk and instr}
add wave -noupdate /tb_snax_wb/i_snax_shell/clk_i
add wave -noupdate /tb_snax_wb/i_snax_shell/rst_ni
add wave -noupdate /tb_snax_wb/i_snax_shell/i_snitch/inst_data_i
add wave -noupdate -divider {relevant snitch reg}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[6]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[5]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[4]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[3]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[2]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[1]}
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/i_snitch/i_snitch_regfile/mem[0]}
add wave -noupdate -divider {stream A}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/req}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/add}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/be}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[0]/r_valid}
add wave -noupdate -divider {stream B}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/req}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/add}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/be}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[1]/r_valid}
add wave -noupdate -divider {stream C}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/req}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/add}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/be}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[2]/r_valid}
add wave -noupdate -divider {stream D}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/req}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/add}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/be}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_mac/snax_tcdm[3]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_mac/clk_i
add wave -noupdate /tb_snax_wb/i_snax_mac/rst_ni
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_qvalid_i
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_qready_o
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_req_i
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_resp_o
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_pvalid_o
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_pready_i
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_tcdm_req_o
add wave -noupdate -expand /tb_snax_wb/i_snax_mac/snax_tcdm_rsp_i
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_mem
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/clk_i
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/rst_ni
add wave -noupdate -childformat {{/tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_op -radix unsigned} {/tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_arga -radix unsigned} {/tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_argb -radix unsigned} {/tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_argc -radix unsigned}} -expand -subitemconfig {/tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_op {-height 16 -radix unsigned} /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_arga {-height 16 -radix unsigned} /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_argb {-height 16 -radix unsigned} /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i.data_argc {-height 16 -radix unsigned}} /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_i
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_valid_i
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/req_ready_o
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/resp_o
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/resp_valid_o
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/resp_ready_i
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/clk
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/req
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/gnt
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/add
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/wen
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/be
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/data
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/id
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/r_data
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/r_valid
add wave -noupdate /tb_snax_wb/i_snax_mac/snax_periph/r_id
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/unpacked_data
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/FillBits
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/fifo_sn_hwpe_in
add wave -noupdate /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/fifo_sn_hwpe_out
add wave -noupdate -expand /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/fifo_hwpe_sn_in
add wave -noupdate -expand /tb_snax_wb/i_snax_mac/i_snax_hwpe_ctrl/fifo_hwpe_sn_out
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -subitemconfig {/tb_snax_wb/i_snax_mac/i_mac_top/i_mac_top/i_ctrl/reg_file.hwpe_params -expand /tb_snax_wb/i_snax_mac/i_mac_top/i_mac_top/i_ctrl/reg_file.generic_params -expand} /tb_snax_wb/i_snax_mac/i_mac_top/i_mac_top/i_ctrl/reg_file
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {727963 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 396
configure wave -valuecolwidth 79
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {654118 ps} {987513 ps}
