`timescale 1ns / 1ps

module q_round_tb (); //Partie descriptive vide pour un tb

	//Signaux de test
	logic resetb_s;
	logic[31 : 0] a_i_s, b_i_s, c_i_s, d_i_s;
	logic[31 : 0] a_o_s, b_o_s, c_o_s, d_o_s;
	logic clock_s;
	
	//Instance de quart de ronde pour l'unité de test 
	q_round DUT(
		//Entrées
		.resetb_i(resetb_s),
		.a_i(a_i_s),
		.b_i(b_i_s),
		.c_i(c_i_s),
		.d_i(d_i_s),
		//Sorties
		.a_o(a_o_s),
		.b_o(b_o_s),
		.c_o(c_o_s),
		.d_o(d_o_s)
	); 

	//Horloge
	initial begin
		clock_s = 0;
		forever #5 clock_s = ~clock_s;	
	end
	
	//Affectations des valeurs de test
	initial begin
		//Initialisation
		a_i_s = 0;
		b_i_s = 0;
		c_i_s = 0;
		d_i_s = 0;
		resetb_s = 1;
		
		//Remise à 0
		#10
		resetb_s = 0;
		#20
		resetb_s = 1;
		
		//Affectaion des valeurs de test
		#20
		a_i_s = 32'h11111111;
		b_i_s = 32'h01020304;
		c_i_s = 32'h9b8d6f43;
		d_i_s = 32'h01234567;
	end 
		
endmodule : q_round_tb
