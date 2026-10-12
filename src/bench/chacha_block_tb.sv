`timescale 1ns / 1ps

module chacha_block_tb 
	import chacha_pack::*;(); //Partie descriptive vide pour un tb

	//Signaux de test
	//Entrées
	logic resetb_s, select_r_type_s, init_chacha_s, clock_s;
	logic[255 : 0] key_s;
	logic[95 : 0] nounce_s;
	logic enable_s;
	//Sortie
	state_t kstream_s;

	//Instance du block pour le DUT
	chacha_block DUT(
		//Entrées
		.clock_i(clock_s),
		.resetb_i(resetb_s),
		.select_r_type_i(select_r_type_s),
		.init_chacha_i(init_chacha_s),
		.enable_i(enable_s),
		.key_i(key_s),
		.nounce_i(nounce_s),
		//Sortie
		.kstream_o(kstream_s)
	);
	
	//Horloge
	initial begin
		clock_s = 0;
		forever #5 clock_s = ~clock_s;	
	end
	
	//Changement de select du type de ronde sur tous les front descendants de l'horloge
	initial begin
		select_r_type_s = 0;
		forever #10 select_r_type_s = ~select_r_type_s;	
	end
	
	//Affectation des valeurs de test
	initial begin 
		//Initialisation
		resetb_s = 1;
		init_chacha_s = 1; 			//Départ avec le MUX prenant l'état initial en entrée
		enable_s = 1;
		key_s = 256'h4e7ced7e860e69aed3a53fefd52a3eec27a09386322fdc9a76a2b5eae921c73a;
		nounce_s = 96'hd4ac91b9caccf25906e46ce3;
		
		#10
		init_chacha_s = 0; //MUX prenant la sortie du dff en entrée après un cycle 	
				 
		
	end	

endmodule : chacha_block_tb 
