`timescale 1ns / 1ps

module round_tb 
	import chacha_pack::*;(); //Partie descriptive vide pour un tb

	//Signaux de test
	state_t s_i_s; 
	state_t s_o_s;
	logic select_r_type_s;
	logic resetb_s;
	logic clock_s;
	
	//Instance de la rotation pour le DUT
	round DUT(
		//Entrées
		.resetb_i(resetb_s),
		.select_r_type_i(select_r_type_s),
		.s_i(s_i_s),
		//Sortie
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
		resetb_s = 1;
		select_r_type_s = 0;
		s_i_s = {32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000};
		
		//Remise à 0
		#10
		resetb_s = 0;
		#10
		resetb_s = 1;
		
		//Affectation des valeurs de test pour la ronde en colonnes
		#20
		s_i_s = {32'h61707865, 32'h3320646e, 32'h79622d32, 32'h6b206574,
			 32'he921c73a, 32'h76a2b5ea, 32'h322fdc9a, 32'h27a09386,
			 32'hd52a3eec, 32'hd3a53fef, 32'h860e69ae, 32'h4e7ced7e,
			 32'h00000001, 32'h06e46ce3, 32'hcaccf259, 32'hd4ac91b9};
			 
		//Affectation des valeurs de test pour la ronde en diagonales
		#27
		select_r_type_s = 1;
		#3
		s_i_s = {32'hdf768f7d, 32'hcf72de24, 32'h6d0b7504, 32'h9cc7c200,
			 32'hb51b4034, 32'h3f18819b, 32'h60a74d6f, 32'h2134ec9b,
			 32'hfd8e795e, 32'h13d1f2cf, 32'h1fb825a2, 32'h3c44a0df,
			 32'he8c5efe0, 32'hc97103b9, 32'h9e145a96, 32'h84846cf5};
	end	

endmodule : round_tb 
