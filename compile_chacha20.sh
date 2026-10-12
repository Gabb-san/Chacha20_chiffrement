#!/bin/bash

export PROJECTNAME="."


echo "the project location is : $PROJECTNAME"
echo "removing libs"
vdel -lib $PROJECTNAME/lib/lib_rtl -all
vdel -lib $PROJECTNAME/lib/lib_bench -all

echo "creating library "

vlib $PROJECTNAME/lib/lib_rtl
vmap lib_rtl $PROJECTNAME/lib/lib_rtl
vlib $PROJECTNAME/lib/lib_bench
vmap lib_bench $PROJECTNAME/lib/lib_bench


#compilation du package
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_pack.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_pack.sv | grep Error

# compilation des fichiers sources
echo "compile systemverilog sources"
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/arx.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/arx.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/q_round.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/q_round.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/input_round.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/input_round.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/output_round.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/output_round.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/round.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/round.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/dff_state.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/dff_state.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_block.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_block.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/round_cpt.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/round_cpt.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/fsm_moore.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/fsm_moore.sv | grep Error
echo "vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_top.sv" 
vlog -sv +acc -svinputport=net -work lib_rtl $PROJECTNAME/src/rtl/chacha_top.sv | grep Error

# Compilation des fichiers TB
echo "compile systemverilog test bench"
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/arx_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/arx_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/q_round_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/q_round_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/column_round_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/input_round_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/output_round_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/output_round_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/round_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/round_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/chacha_block_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/chacha_block_tb.sv | grep Error
echo "vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/chacha_top_tb.sv"
vlog -sv +acc -svinputport=net -L lib_rtl -work lib_bench $PROJECTNAME/src/bench/chacha_top_tb.sv | grep Error


# lancement du simulateur
echo "compilation finished"
echo "start simulation..."

# ATTENTION un seul VSIM decommenté à la fois! (facultatif)
#vsim -L lib_rtl lib_bench.arx_tb
#vsim -L lib_rtl lib_bench.q_round_tb
#vsim -L lib_rtl lib_bench.input_round_tb
#vsim -L lib_rtl lib_bench.output_round_tb
#vsim -L lib_rtl lib_bench.round_tb
#vsim -L lib_rtl lib_bench.chacha_block_tb
#vsim -L lib_rtl lib_bench.chacha_top_tb -do chacha20_top_wave.do



