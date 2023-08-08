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
add wave -noupdate -radix unsigned {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/snax_tcdm[0]/r_data}
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
add wave -noupdate -childformat {{/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params -radix unsigned -childformat {{{[47]} -radix unsigned} {{[46]} -radix unsigned} {{[45]} -radix unsigned} {{[44]} -radix unsigned} {{[43]} -radix unsigned} {{[42]} -radix unsigned} {{[41]} -radix unsigned} {{[40]} -radix unsigned} {{[39]} -radix unsigned} {{[38]} -radix unsigned} {{[37]} -radix unsigned} {{[36]} -radix unsigned} {{[35]} -radix unsigned} {{[34]} -radix unsigned} {{[33]} -radix unsigned} {{[32]} -radix unsigned} {{[31]} -radix unsigned} {{[30]} -radix unsigned} {{[29]} -radix unsigned} {{[28]} -radix unsigned} {{[27]} -radix unsigned} {{[26]} -radix unsigned} {{[25]} -radix unsigned} {{[24]} -radix unsigned} {{[23]} -radix unsigned} {{[22]} -radix unsigned} {{[21]} -radix unsigned} {{[20]} -radix unsigned} {{[19]} -radix unsigned} {{[18]} -radix unsigned} {{[17]} -radix unsigned} {{[16]} -radix unsigned} {{[15]} -radix unsigned} {{[14]} -radix unsigned} {{[13]} -radix unsigned} {{[12]} -radix unsigned} {{[11]} -radix unsigned} {{[10]} -radix unsigned} {{[9]} -radix unsigned} {{[8]} -radix unsigned} {{[7]} -radix unsigned} {{[6]} -radix unsigned} {{[5]} -radix unsigned} {{[4]} -radix unsigned} {{[3]} -radix unsigned} {{[2]} -radix unsigned} {{[1]} -radix unsigned} {{[0]} -radix unsigned}}}} -subitemconfig {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params {-height 16 -radix unsigned -childformat {{{[47]} -radix unsigned} {{[46]} -radix unsigned} {{[45]} -radix unsigned} {{[44]} -radix unsigned} {{[43]} -radix unsigned} {{[42]} -radix unsigned} {{[41]} -radix unsigned} {{[40]} -radix unsigned} {{[39]} -radix unsigned} {{[38]} -radix unsigned} {{[37]} -radix unsigned} {{[36]} -radix unsigned} {{[35]} -radix unsigned} {{[34]} -radix unsigned} {{[33]} -radix unsigned} {{[32]} -radix unsigned} {{[31]} -radix unsigned} {{[30]} -radix unsigned} {{[29]} -radix unsigned} {{[28]} -radix unsigned} {{[27]} -radix unsigned} {{[26]} -radix unsigned} {{[25]} -radix unsigned} {{[24]} -radix unsigned} {{[23]} -radix unsigned} {{[22]} -radix unsigned} {{[21]} -radix unsigned} {{[20]} -radix unsigned} {{[19]} -radix unsigned} {{[18]} -radix unsigned} {{[17]} -radix unsigned} {{[16]} -radix unsigned} {{[15]} -radix unsigned} {{[14]} -radix unsigned} {{[13]} -radix unsigned} {{[12]} -radix unsigned} {{[11]} -radix unsigned} {{[10]} -radix unsigned} {{[9]} -radix unsigned} {{[8]} -radix unsigned} {{[7]} -radix unsigned} {{[6]} -radix unsigned} {{[5]} -radix unsigned} {{[4]} -radix unsigned} {{[3]} -radix unsigned} {{[2]} -radix unsigned} {{[1]} -radix unsigned} {{[0]} -radix unsigned}} -expand} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[47]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[46]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[45]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[44]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[43]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[42]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[41]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[40]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[39]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[38]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[37]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[36]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[35]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[34]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[33]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[32]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[31]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[30]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[29]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[28]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[27]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[26]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[25]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[24]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[23]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[22]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[21]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[20]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[19]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[18]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[17]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[16]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[15]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[14]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[13]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[12]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[11]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[10]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[9]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[8]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[7]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[6]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[5]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[4]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[3]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[2]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[1]} {-radix unsigned} {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file.hwpe_params[0]} {-radix unsigned}} /tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/i_mac_top/i_ctrl/i_slave/reg_file
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[0]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[1]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[2]/r_valid}
add wave -noupdate -divider <NULL>
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/clk}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/req}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/gnt}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/add}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/wen}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/be}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/r_data}
add wave -noupdate {/tb_snax_wb/i_snax_shell/gen_hwpe_acc/gen_hwpe_mac/i_mac_top/tcdm[3]/r_valid}
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
WaveRestoreCursors {{Cursor 1} {452941 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 711
configure wave -valuecolwidth 134
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
WaveRestoreZoom {0 ps} {2100 ns}
