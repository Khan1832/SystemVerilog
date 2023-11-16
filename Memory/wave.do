onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/clk_i
add wave -noupdate /top/dut/reset_i
add wave -noupdate -group Memory_signals /top/dut/valid_i
add wave -noupdate -group Memory_signals /top/dut/ready_o
add wave -noupdate -group Memory_signals /top/dut/wr_rd_i
add wave -noupdate -group Memory_signals /top/dut/addr_i
add wave -noupdate -group Memory_signals /top/dut/wdata_i
add wave -noupdate -group Memory_signals /top/dut/rdata_o
add wave -noupdate -group Assertions /top/dut_assert/HANDSHAKE
add wave -noupdate -group Assertions /top/dut_assert/WR_RD
add wave -noupdate -group Assertions /top/dut_assert/WR_RD_ADDR_WDATA
add wave -noupdate -group Assertions /top/dut_assert/WR_RD_ADDR_RDATA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {404 ns}
