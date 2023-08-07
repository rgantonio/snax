onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/clk_i
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/rst_ni
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/test_mode_i
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/evt_o
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_req
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_gnt
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_add
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_wen
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_be
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_data
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_r_data
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm_r_valid
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_req
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_gnt
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_add
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_wen
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_be
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_data
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_id
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_r_data
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_r_valid
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/periph_r_id
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[1]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[3]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/clk_i
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/rst_ni
add wave -noupdate -expand -subitemconfig {{/tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/req_i[3]} -expand {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/req_i[1]} -expand {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/req_i[0]} -expand} /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/req_i
add wave -noupdate -expand -subitemconfig {{/tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/rsp_o[0]} -expand} /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/rsp_o
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/mem_req_o
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/mem_rsp_i
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/bank_select
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_snax_wb/i_snax_shell/gen_hwpe_acc/i_tcdm_interconnect/Topology
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {710000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 583
configure wave -valuecolwidth 246
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
WaveRestoreZoom {0 ps} {1186500 ps}
