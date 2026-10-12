`timescale 1ns / 1ps

module round
	import chacha_pack::*;(
	//Entrée
	input logic resetb_i,
	input logic select_r_type_i,
	input state_t s_i,
	//Sortie 
	output state_t s_o
	);	
	
	//Etats intermédiaires 
	state_t input_s; //En sortie de l'instance du module input_round
	state_t output_s;//En entrée de l'instance du module output_round
	
	//Traitement de l'état en entrée
	input_round i_round(
		//Entrées
		.select_r_type_i(select_r_type_i),
		.s_i(s_i),
		//Sortie
		.s_o(input_s)
	);
	
	//Quarts de round
	 q_round qr_1(
			//Entrées
			.resetb_i(resetb_i),
			.a_i(input_s[0]),
			.b_i(input_s[1]),
			.c_i(input_s[2]),
			.d_i(input_s[3]),
			//Sorties
			.a_o(output_s[0]),
			.b_o(output_s[1]),
			.c_o(output_s[2]),
			.d_o(output_s[3])
	);
	
	q_round qr_2(
			//Entrées
			.resetb_i(resetb_i),
			.a_i(input_s[4]),
			.b_i(input_s[5]),
			.c_i(input_s[6]),
			.d_i(input_s[7]),
			//Sorties
			.a_o(output_s[4]),
			.b_o(output_s[5]),
			.c_o(output_s[6]),
			.d_o(output_s[7])
	);
	
	q_round qr_3(
			//Entrées
			.resetb_i(resetb_i),
			.a_i(input_s[8]),
			.b_i(input_s[9]),
			.c_i(input_s[10]),
			.d_i(input_s[11]),
			//Sorties
			.a_o(output_s[8]),
			.b_o(output_s[9]),
			.c_o(output_s[10]),
			.d_o(output_s[11])
	);
		
	q_round qr_4(
			//Entrées
			.resetb_i(resetb_i),
			.a_i(input_s[12]),
			.b_i(input_s[13]),
			.c_i(input_s[14]),
			.d_i(input_s[15]),
			//Sorties
			.a_o(output_s[12]),
			.b_o(output_s[13]),
			.c_o(output_s[14]),
			.d_o(output_s[15])
	);
		
	
	//Traitement de l'état en sortie
	output_round o_round(
		//Entrées
		.select_r_type_i(select_r_type_i),
		.s_i(output_s),
		//Sortie
		.s_o(s_o)
	);
	
endmodule : round	





