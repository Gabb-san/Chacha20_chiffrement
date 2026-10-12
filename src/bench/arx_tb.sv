`timescale 1ns / 1ps

module arx_tb(); //Partie déclarative du module - vide pour un test bench

	//Connections 
	logic resetb_s;
	logic clock_s;
	logic[31:0] augend_s;
	logic[31:0] addend_s;
	logic[31:0] xor_s;
	//logic[31:0] res_xor_s; pour le debug (voir le module arx)
	logic[31:0] sum_s;
	logic[31:0] rot_s;
	
	//Instance d'arx pour l'unité de test
	arx #(.decal(7))DUT (
		.resetb_i(resetb_s),
		.augend_i(augend_s),
		.addend_i(addend_s),
		.xor_i(xor_s),
		//.res_xor_o(res_xor_s), pour le debug
		.sum_o(sum_s),
		.rot_o(rot_s)
	);
	
	//Horloge
	initial begin
		clock_s = 0;
		forever #5 clock_s = ~clock_s;	
	end
	
	//Valeurs de test - changent sur une période pultiple de 10 pour être sur un front descendant 
	initial begin
		//Initialisation des valeurs 
		resetb_s = 1'b1;
		augend_s = 32'h00000000;
		addend_s = 32'h00000000;
		xor_s = 32'h00000000;
		
		//Remise à zéro
		#10
		resetb_s = 1'b0;
		#10
		resetb_s = 1'b1;
		
		//Tests
		#20
		augend_s = 32'h01234567;
		addend_s = 32'h77777777;
		xor_s = 32'h01020304;
		
		#20
		augend_s = 32'hf2e1a126;
		addend_s = 32'h2b3e4456;
		xor_s = 32'h12b7f568;	
		
		//Remise à zéro
		#10
		resetb_s = 1'b0;
		#10
		resetb_s = 1'b1;
	end
	
endmodule : arx_tb
		
		
		
		
		
	
		 
