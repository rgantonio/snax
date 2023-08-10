# ---------------------------------------------
# Copyright 2023 Katolieke Universiteit Leuven (KUL)
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
# Author: Ryan Antonio (ryan.antonio@kuleuven.be)
# ---------------------------------------------
addi x1, x0, 0   #src addr
addi x2, x0, 512 #dst addr
addi x2, x2, 512 #dst addr
addi x2, x2, 512 #dst addr
addi x2, x2, 512 #dst addr
addi x2, x2, 512 #dst addr
addi x3, x0, 64  #consec bytes to transfer
addi x4, x0, 10  #repeat
addi x5, x0, 2   #config
addi x6, x0, 512 #stride size
addi x8, x0, 512
dmsrc x1, x0
dmdst x2, x0
dmrep x4
dmstr x6, x8
dmcpy x7, x3, x5
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
