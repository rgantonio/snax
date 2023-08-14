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
addi x1, x0, 64     # hwpe register address for base address of stream A
addi x2, x0, 0      # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 68     # hwpe register address for base address of stream B
addi x2, x0, 132    # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 72     # hwpe register address for base address of stream C
addi x2, x0, 8      # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 76     # hwpe register address for base address of stream D
addi x2, x0, 520    # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 80     # hwpe register address for number of iterations
addi x2, x0, 1      # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 84     # hwpe register address for vector length (or number of elements)
addi x2, x0, 9      # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
addi x1, x0, 0      # hwpe register address to trigger HWPE
addi x2, x0, 0      # value to put
snwacc x3, x1, x2   # write csr at address x1 with value x2. return response on x3
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