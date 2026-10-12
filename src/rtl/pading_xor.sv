`timescale 1ns / 1ps 

module padding_xor
	import chacha_pack::*;(
	//Entrées
	input state_t kstream_i,
	input logic end_i,
	input logic cipher_valid_i,
	input logic[367 : 0] plain_i,
	//Sorties
	output logic[383 : 0] cipher_o
);

	logic[127 : 0] P1_s, P2_s, P3_s;
	logic[127 : 0] C1_s, C2_s, C3_s;
	logic[1 : 0] compteur_s;
	
	assign compteur_s = 2'h0; 
	assign P1_s = plain_i[127 : 0]; 
	assign P2_s = plain_i[127 : 0]; 
	assign P3_s = {16'h0000, plain_i[112 : 0]}; 
	
	assign compteur_s = (cipher_valid_i == 1'b1) ? compteur_s + 1 : compteur_s; 
	
	always_comb begin
		case(compteur_s)
		
		2'h1 :
			C1_s = P1_s ^ {kstream_i[0], kstream_i[1], kstream_i[2], kstream_i[3]};
		
		2'h2 :
			C2_s = P2_s ^ {kstream_i[4], kstream_i[5], kstream_i[6], kstream_i[7]};
		
		2'h3 :
			C3_s = P3_s ^ {kstream_i[8], kstream_i[9], kstream_i[10], kstream_i[11]};
		
		default : 
			begin
			C1_s = 128'h00000000000000000000000000000000;
			C2_s = 128'h00000000000000000000000000000000;
			C3_s = 128'h00000000000000000000000000000000;
			end
		endcase 
	end
	
	assign cipher_o = {C1_s, C2_s, C3_s};
	
endmodule : padding_xor
	
	
	
	
	
	
	
	
	
	

	









