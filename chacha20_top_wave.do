onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /chacha_top_tb/dut/start_i
add wave -noupdate /chacha_top_tb/dut/select_r_type_s
add wave -noupdate /chacha_top_tb/dut/resetb_i
add wave -noupdate /chacha_top_tb/dut/P_i
add wave -noupdate /chacha_top_tb/dut/nounce_i
add wave -noupdate /chacha_top_tb/dut/kstream_xor_P_s
add wave -noupdate /chacha_top_tb/dut/kstream_s
add wave -noupdate /chacha_top_tb/dut/key_i
add wave -noupdate /chacha_top_tb/dut/init_cpt_s
add wave -noupdate /chacha_top_tb/dut/init_chacha_s
add wave -noupdate /chacha_top_tb/dut/end_o
add wave -noupdate /chacha_top_tb/dut/enable_s
add wave -noupdate /chacha_top_tb/dut/data_valid_i
add wave -noupdate /chacha_top_tb/dut/count_s
add wave -noupdate /chacha_top_tb/dut/clock_i
add wave -noupdate /chacha_top_tb/dut/cipher_valid_o
add wave -noupdate /chacha_top_tb/dut/C_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 233
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {12507 ps}
radix -h
run 500
