`timescale 1ns / 1ps 

module round_cpt
	import chacha_pack::*;(
	//Entrées
	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	input logic init_cpt_i,
	//Sortie
	output logic[5 : 0] count_o
	);

	always_ff @(posedge clock_i, negedge resetb_i) begin : counter_seq
		if (resetb_i == 1'b0) begin
			count_o <= 0;
		end			
		else begin
			if (enable_i == 1'b1) begin
				if (init_cpt_i == 1'b1) count_o <= 0;
				else count_o <= count_o + 1;
			end
		end
	end : counter_seq 
endmodule : round_cpt
