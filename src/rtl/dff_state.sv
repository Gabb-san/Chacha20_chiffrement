`timescale 1ns / 1ps 

module dff_state
	import chacha_pack::*;(
	//Entrées
	input state_t d_i,
	input logic clock_i,
	input logic resetb_i,
	input logic enable_i,
	//Sortie 
	output state_t q_o
);
	
	always_ff @(posedge clock_i or negedge resetb_i)
	begin : seq_0
		if(resetb_i == 1'b0) begin
			q_o[0] <= 32'h00000000;
			q_o[1] <= 32'h00000000;
			q_o[2] <= 32'h00000000;
			q_o[3] <= 32'h00000000;
			q_o[4] <= 32'h00000000;
			q_o[5] <= 32'h00000000;
			q_o[6] <= 32'h00000000;
			q_o[7] <= 32'h00000000;
			q_o[8] <= 32'h00000000;
			q_o[9] <= 32'h00000000;
			q_o[10] <= 32'h00000000;
			q_o[11] <= 32'h00000000;
			q_o[12] <= 32'h00000000;
			q_o[13] <= 32'h00000000;
			q_o[14] <= 32'h00000000;
			q_o[15] <= 32'h00000000;
		end
		else begin
			if(enable_i == 1) begin
				q_o <= d_i;
			end
		end
	end : seq_0
endmodule : dff_state 
	
