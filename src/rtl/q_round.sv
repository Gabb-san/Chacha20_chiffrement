`timescale 1ns / 1ps

module q_round (
	//Entrées
	input logic resetb_i,
	input logic[31 : 0] a_i,
	input logic[31 : 0] b_i,
	input logic[31 : 0] c_i,
	input logic[31 : 0] d_i,
	//Sorties
	output logic[31 : 0] a_o,
	output logic[31 : 0] b_o,
	output logic[31 : 0] c_o,
	output logic[31 : 0] d_o
	
);
	//Connexions intermédiaires
	logic[31 : 0] rot1_s, rot2_s, rot3_s;
	logic[31 : 0] sum1_s, sum2_s, sum3_s;
	
	//Instances de l'ARX
	arx #(.decal(16)) arx1(
		.resetb_i(resetb_i),
		.augend_i(a_i),
		.addend_i(b_i),
		.xor_i(d_i),
		.sum_o(sum1_s),
		.rot_o(rot1_s)
	);
	
	arx #(.decal(12)) arx2(
		.resetb_i(resetb_i),
		.augend_i(c_i),
		.addend_i(rot1_s),
		.xor_i(b_i),
		.sum_o(sum2_s),
		.rot_o(rot2_s)
	);
	
	arx #(.decal(8)) arx3(
		.resetb_i(resetb_i),
		.augend_i(sum1_s),
		.addend_i(rot2_s),
		.xor_i(rot1_s),
		.sum_o(sum3_s),
		.rot_o(rot3_s)
	);
	
	arx #(.decal(7)) arx4(
		.resetb_i(resetb_i),
		.augend_i(sum2_s),
		.addend_i(rot3_s),
		.xor_i(rot2_s),
		.sum_o(c_o),
		.rot_o(b_o)
	);
	
	//Assignation des sorties manquantes
	assign a_o = sum3_s;
	assign d_o = rot3_s;

endmodule : q_round
