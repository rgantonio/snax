# ---------------------------------------------
# Copyright 2023 Katolieke Universiteit Leuven (KUL)
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
# Author: Ryan Antonio (ryan.antonio@kuleuven.be)
# ---------------------------------------------
nop
nop
nop
nop
nop
addi x1, x0, 0
csrrw x0, 976, x1 # offset = 960, addr = 16 for REG_ADDR_A = 0
addi x1, x0, 132  
csrrw x0, 977, x1 # offset = 960, addr = 17 for REG_ADDR_B = 132
addi x1, x0, 8  
csrrw x0, 978, x1 # offset = 960, addr = 18 for REG_ADDR_C = 8
addi x1, x0, 520  
csrrw x0, 979, x1 # offset = 960, addr = 19 for REG_ADDR_D = 520
addi x1, x0, 1  
csrrw x0, 980, x1 # offset = 960, addr = 20 for REG_NB_ITER = 1
addi x1, x0, 9  
csrrw x0, 981, x1 # offset = 960, addr = 21 for REG_LEN_ITER = 9 + 1 (the + 1 is always there)
csrrw x0, 960, x0 # offset = 960, addr = 0 for MANDATORY TRIGGER
addi x4, x0, 0
addi x5, x0, 2
add x6, x4, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
add x6, x6, x5
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop