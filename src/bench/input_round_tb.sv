`timescale 1ns / 1ps

module input_round_tb 
	import chacha_pack::*;(); //Partie descriptive vide pour un tb

	//Signaux de test
	state_t s_i_s, s_o_s;
	logic select_r_type_s;
	logic clock_s;
	
	//Instance de la rotation sur colonnes pour le DUT
	input_round DUT(
		.select_r_type_i(select_r_type_s),
		.s_i(s_i_s),
		.s_o(s_o_s)
	);
	
	//Horloge
	initial begin
		clock_s = 0;
		forever #5 clock_s = ~clock_s;	
	end
	
	//Affectation des valeurs de test
	initial begin 
		//Initialisation
		select_r_type_s = 0;
		s_i_s = {32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000};
		
		//Affectation des valeurs de test
		#50
		s_i_s = {32'h00000000, 32'h00000001, 32'h00000002, 32'h00000003, 
			 32'h00000004, 32'h00000005, 32'h00000006, 32'h00000007, 
			 32'h00000008, 32'h00000009, 32'h0000000a, 32'h0000000b, 
			 32'h0000000c, 32'h0000000d, 32'h0000000e, 32'h0000000f};
			 
		//Changement du signal de commande
		#50
		select_r_type_s = 1;
		
	end	

endmodule : input_round_tb 
