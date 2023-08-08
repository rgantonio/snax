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
addi x1, x0, 64 # addr A
addi x2, x0, 0
snwacc x3, x1, x2
addi x1, x0, 68 # addr B
addi x2, x0, 132
snwacc x3, x1, x2
addi x1, x0, 72 # addr C
addi x2, x0, 8
snwacc x3, x1, x2
addi x1, x0, 76 # addr D
addi x2, x0, 520
snwacc x3, x1, x2
addi x1, x0, 80 # number of iterations
addi x2, x0, 1
snwacc x3, x1, x2 
addi x1, x0, 84 # length of vector
addi x2, x0, 4
snwacc x3, x1, x2
addi x1, x0, 0 # enable control
addi x2, x0, 0
snwacc x3, x1, x2
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