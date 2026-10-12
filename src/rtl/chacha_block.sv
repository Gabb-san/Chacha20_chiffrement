`timescale 1ns / 1ps

module chacha_block 
	import chacha_pack::*;(
	//Entrées
	input logic clock_i,
	input logic resetb_i,
	input logic select_r_type_i,
	input logic init_chacha_i,
	input logic enable_i,
	input logic[255 : 0] key_i,
	input logic[95 : 0] nonce_i,
	//Sortie
	output state_t kstream_o
	); 
	
	//Définition des signaux intermédiaires
	state_t s_init_s;			//Etat initial
	state_t s_s; 				//Etat courant 
	state_t round_out_s; 			//Sortie de la ronde courante 
	state_t dff_out_s; 			//Sortie du registre
	logic[127 : 0] cst_s;
	logic[31 : 0] block_init_s;
	
	//Initialisation des signaux internes 
	assign cst_s = 128'h6b20657479622d323320646e61707865;
	assign block_init_s = 32'h00000001;
	//Etat initial
	assign s_init_s[0] = cst_s[31 : 0];
	assign s_init_s[1] = cst_s[63 : 32];
	assign s_init_s[2] = cst_s[95 : 64];
	assign s_init_s[3] = cst_s[127 : 96];
	assign s_init_s[4] = key_i[31 : 0];
	assign s_init_s[5] = key_i[63 : 32];
	assign s_init_s[6] = key_i[95 : 64];
	assign s_init_s[7] = key_i[127 : 96];
	assign s_init_s[8] = key_i[159 : 128];
	assign s_init_s[9] = key_i[191 : 160];
	assign s_init_s[10] = key_i[223 : 192];
	assign s_init_s[11] = key_i[255 : 224];
	assign s_init_s[12] = block_init_s;
	assign s_init_s[13] = nonce_i[31 : 0];
	assign s_init_s[14] = nonce_i[63 : 32];
	assign s_init_s[15] = nonce_i[95 : 64];
	
	//MUX
	assign s_s = (init_chacha_i == 1)? s_init_s : dff_out_s;

	//Rondes
	round rondes(
		//Entrées
		.resetb_i(resetb_i),
		.select_r_type_i(select_r_type_i),
		.s_i(s_s),
		//Sorties
		.s_o(round_out_s)
	);
	
	//Registre d'enregistrement de la sortie de ronde
	dff_state dff(
		//Entrées
		.d_i(round_out_s),
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.enable_i(enable_i),
		//Sorties
		.q_o(dff_out_s)
	);
	
	//Additionneur du Keystream
	generate
		genvar i;
		for(i = 0; i < 16; i++) begin : keystream_label
			assign kstream_o[i] = (resetb_i == 0)? 32'h0 : dff_out_s[i] + s_init_s[i];
		end : keystream_label
	endgenerate
	
	
	//Padding plain text et XOR de chiffrement dans le top
	
endmodule : chacha_block
