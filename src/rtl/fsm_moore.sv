`timescale 1ns / 1ps 

module fsm_moore(
	//Entrées
	input logic start_i,
	input logic clock_i,
	input logic resetb_i,
	input logic[4 : 0] round_i,
	input logic data_valid_i,
	//Sorties
	output logic enable_o,
	output logic enable_cpt_o,
	output logic init_cpt_o,
	output logic select_r_type_o,
	output logic init_chacha_o,
	output logic end_o,
	output logic cipher_valid_o
);

	//Définition des états
	typedef enum {idle, init, round_column, round_diag, keystream, cipher_create, cipher_store} m_state_t;
	
	
	//Etat suivant et état courant
	m_state_t current_state, next_state;
	
	
	//Registre de sauvegarde des états - processus séquentiel
	always_ff @(posedge clock_i or negedge resetb_i)
	begin : seq0
		if(resetb_i == 1'b0)
			current_state <= idle;		//Réinitialisation
		else
			current_state <= next_state;	//Affectation à l'état suivant
	end : seq0
	
	
	//Détermination de l'état suivant - processus combinatoire
	always_comb begin : comb0
		case(current_state)
			idle : 
				if(start_i == 1'b1) next_state = init;
				else next_state = idle;
			
			init :
				next_state = round_column;
			
			round_column :
				if(round_i >= 5'h12) next_state = keystream;
				else next_state = round_diag;
				
			round_diag :
				if(round_i >= 5'h12) next_state = keystream;
				else next_state = round_column;
				
			keystream :
				if(data_valid_i == 1'b1) next_state = cipher_create;
				else next_state = keystream;	
				
			cipher_create :
				next_state = cipher_store;
				
			cipher_store :
				if(data_valid_i == 1'b1) next_state = cipher_create;
				else next_state = cipher_store;			
			
			default : next_state = idle;
		endcase
	end : comb0
	
	
	//Détermination des sorties - processus combinatoire
	always_comb begin : comb1
		case(current_state)
			idle :
			begin 					
				enable_o = 1'b0;
				enable_cpt_o = 1'b0;
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
			
			init :	
			begin				
				enable_o = 1'b1;
				enable_cpt_o = 1'b1;
				init_cpt_o = 1'b1;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b1;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
			
			round_column :	
			begin			
				enable_o = 1'b1;
				enable_cpt_o = 1'b1;
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b1;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
			
			round_diag :
			begin
				enable_o = 1'b1;
				enable_cpt_o = 1'b1;
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
			
			keystream :
			begin
				enable_o = 1'b0;
				enable_cpt_o = 1'b0;
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b1;
				cipher_valid_o = 1'b0;
			end
			
			cipher_create :
			begin
				enable_o = 1'b0;
				enable_cpt_o = 1'b1;
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
			
			cipher_store :
			begin
				enable_o = 1'b0;
				enable_cpt_o = 1'b0; //On desactive le compteur lors du stockage du cipher, sinon le compteur compte deux fois trop.
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b1;
			end
			
			default :
			begin
				enable_o = 1'b0;
				enable_cpt_o = 1'b0; 
				init_cpt_o = 1'b0;
				select_r_type_o = 1'b0;
				init_chacha_o = 1'b0;
				end_o = 1'b0;
				cipher_valid_o = 1'b0;
			end
		endcase
	end : comb1
	
endmodule : fsm_moore
