# -----------------------------//
# Copyright 2023 Katolieke Universiteit Leuven (KUL)
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51
# Author: Ryan Antonio (ryan.antonio@kuleuven.be)
# Description: Just a memory generation for contiuous elements
# -----------------------------

TOTAL_ELEM = 1024

elem_list = []
for i in range(TOTAL_ELEM):
    hex_code = '00000000' + hex(i)[2:]
    hex_code = hex_code[-8:]
    elem_list.append(hex_code)

row_list = []
k = 0

with open('data/data_mem.txt','w') as data_mem:
    for elem in elem_list:
        data_mem.write(elem + '\n')