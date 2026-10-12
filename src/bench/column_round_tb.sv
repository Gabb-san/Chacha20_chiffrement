`timescale 1ns / 1ps

module column_round_tb 
	import chacha_pack::*;(); //Partie descriptive vide pour un tb

	//Signaux de test
	state_t s_i_s, s_o_s;
	logic resetb_s;
	logic clock_s;
	
	//Instance de la rotation sur colonnes pour le DUT
	column_round DUT(
		.resetb_i(resetb_s),
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
		s_i_s = {32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 
			 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000};
		resetb_s = 1;
		
		//Remise à 0
		#20
		resetb_s = 0;
		#10
		resetb_s = 1;
		
		//Affectation des valeurs de test
		#50
		s_i_s = {32'h61707865, 32'h3320646e, 32'h79622d32, 32'h6b206574, 
			 32'he921c73a, 32'h76a2b5ea, 32'h322fdc9a, 32'h27a09386, 
			 32'hd52a3eec, 32'hd3a53fef, 32'h860e69ae, 32'h4e7ced7e, 
			 32'h00000001, 32'h06e46ce3, 32'hcaccf259, 32'hd4ac91b9};
		
	end	

endmodule : column_round_tb

