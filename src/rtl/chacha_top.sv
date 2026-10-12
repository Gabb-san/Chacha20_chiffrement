`timescale 1ns / 1ps 

module chacha_top
	import chacha_pack::*;(
	//Entrées
	input logic clock_i,
	input logic resetb_i,
	input logic start_i,
	input logic data_valid_i,
	input logic[255 : 0] key_i,
	input logic[95 : 0] nonce_i,
	input logic[127 : 0] P_i,
	//Sorties
	output logic end_o,
	output logic cipher_valid_o,
	output logic[127 : 0] C_o
	);
	
	
	//Signaux internes
	logic enable_s, enable_cpt_s, init_cpt_s, init_chacha_s, select_r_type_s, end_s, cipher_valid_s; 
	logic resetb_count_s; //Pour pouvoir reset le compteur sans reset tout le système
	logic[4 : 0] count_s;
	logic[127 : 0] kstream_xor_P_s;
	state_t kstream_s;
	
	//Compteur de rondes
	round_cpt compteur (
		//Entrées
		.clock_i(clock_i),
		.resetb_i(resetb_count_s),
		.enable_i(enable_cpt_s),
		.init_cpt_i(init_cpt_s),
		//Sortie
		.count_o(count_s)
	);
	
	//Machine d'états 
	fsm_moore fsm (
		//Entrées
		.start_i(start_i),
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.round_i(count_s),
		.data_valid_i(data_valid_i),
		//Sorties
		.enable_o(enable_s),
		.enable_cpt_o(enable_cpt_s),
		.init_cpt_o(init_cpt_s),
		.select_r_type_o(select_r_type_s),
		.init_chacha_o(init_chacha_s),
		.end_o(end_s),
		.cipher_valid_o(cipher_valid_s)
	);
	
	//Rondes et création du keystream
	chacha_block data_block (
		//Entrées
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.select_r_type_i(select_r_type_s),
		.init_chacha_i(init_chacha_s),
		.key_i(key_i),
		.nonce_i(nonce_i),
		.enable_i(enable_s),
		//Sortie
		.kstream_o(kstream_s)
	);
	
	//Sorties de fin de création du keystrealm et des ciphers
	assign end_o = end_s;
	assign cipher_valid_o = cipher_valid_s;	
	
	//Valeur de cipher avant le stockage dans le registre
	always_comb begin : comb_xor_plain
		//On a comme un MUX ayant en sortie le reset de kstream_xor_P_s, dont le select est end_s
		if(end_s == 1'b1 || resetb_i == 1'b0)
			resetb_count_s = 0;
		else begin
			resetb_count_s = 1'b1;
			case(count_s)
				5'h0 :
					kstream_xor_P_s = P_i ^ {kstream_s[3], kstream_s[2], kstream_s[1], kstream_s[0]};
				5'h1 :
					kstream_xor_P_s = P_i ^ {kstream_s[7], kstream_s[6], kstream_s[5], kstream_s[4]};
				5'h2 :
					kstream_xor_P_s = P_i ^ {kstream_s[11], kstream_s[10], kstream_s[9], kstream_s[8]};
				default :
					kstream_xor_P_s = 128'h0;
			endcase
		end
	end : comb_xor_plain
	
	//Registre de stockage du cipher
	always_ff @(posedge clock_i or negedge resetb_i)
	begin : seq_reg_cipher
			if(resetb_i == 1'b0) begin
				C_o = 128'h0;
			end
			else 
			if(data_valid_i == 1) begin //Registre dont l'écriture est permise par data_valid_i
				C_o <= kstream_xor_P_s;
			end
	end : seq_reg_cipher
	
endmodule : chacha_top
