`timescale 1ns / 1ps

module arx #(parameter decal = 0)( //Parametre générique - décalage dans la rotation
	//Entrées
	input logic resetb_i,
	input logic[31:0] augend_i,
	input logic[31:0] addend_i,
	input logic[31:0] xor_i,
	//Sorties
	//output logic[31:0] res_xor_o, //sortie supplémentaire pour debugger l'arx
	output logic[31:0] sum_o,
	output logic[31:0] rot_o
	);
	
	//Connection entre le xor et la rotation
	logic[31:0] res_xor_s;
	
	//addition conditionnée sur le reset 
	assign sum_o = (resetb_i == 0) ? 32'h00000000 : augend_i + addend_i;
	//xor
	assign res_xor_s = xor_i ^ sum_o;
	//rotation conditionnée sur le reset
	assign rot_o = (resetb_i == 0) ? 32'h00000000 : {res_xor_s[31-decal:0], res_xor_s[31:31-decal+1]};

endmodule : arx
	
	 
