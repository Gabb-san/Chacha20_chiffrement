`timescale 1ns / 1ps

module output_round 
	import chacha_pack::*;(
	//entrées
	input state_t s_i,
	input logic select_r_type_i, //selecteur du type de ronde (diagonale ou colonne)
	//sorties
	output state_t s_o	
);
	always_comb begin : output_seq
		if(select_r_type_i == 1) begin //Remise en place des diagonales
			s_o[0] = s_i[0];
			s_o[5] = s_i[1];
			s_o[10] = s_i[2];
			s_o[15] = s_i[3];
			s_o[1] = s_i[4];
			s_o[6] = s_i[5];
			s_o[11] = s_i[6];
			s_o[12] = s_i[7];
			s_o[2] = s_i[8];
			s_o[7] = s_i[9];
			s_o[8] = s_i[10];
			s_o[13] = s_i[11];
			s_o[3] = s_i[12];
			s_o[4] = s_i[13];
			s_o[9] = s_i[14];
			s_o[14] = s_i[15];
		end 
		else begin //Remise en place des colonnes
			s_o[0] = s_i[0];
			s_o[4] = s_i[1];
			s_o[8] = s_i[2];
			s_o[12] = s_i[3];
			s_o[1] = s_i[4];
			s_o[5] = s_i[5];
			s_o[9] = s_i[6];
			s_o[13] = s_i[7];
			s_o[2] = s_i[8];
			s_o[6] = s_i[9];
			s_o[10] = s_i[10];
			s_o[14] = s_i[11];
			s_o[3] = s_i[12];
			s_o[7] = s_i[13];
			s_o[11] = s_i[14];
			s_o[15] = s_i[15];
		end
	end : output_seq
endmodule : output_round
	

