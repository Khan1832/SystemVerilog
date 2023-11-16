#code coverage
#compilation
vlog list.svh

#optimisation
vopt work.top +cover=fcbest -o test_wr_rd_1tx

#ellaboration

vsim -coverage test_wr_rd_1tx 

# save coverage

coverage save -onexit test_wr_rd_1tx.ucdb

# adding wave
#add wave -position insertpoint sim:/top/dut/*
do wave.do

do exclusion.do

#run the simulation
run -all

