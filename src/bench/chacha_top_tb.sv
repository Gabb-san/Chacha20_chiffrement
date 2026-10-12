`timescale 1ns / 1ps

module chacha_top_tb 
	import chacha_pack::*;();

    // Testbench signals
    logic clock_s;
    logic resetb_s;
    logic start_s;
    logic data_valid_s;
    logic [127:0] P_s;
    logic [255:0] key_s;
    logic [95:0] nonce_s;
    logic [127:0] C_s;
    logic cipher_valid_s;
    logic end_s;
    logic [367:0] full_cipher_s; // To store the full 46 bytes of cipher output

    // Instantiate the DUT
    chacha_top dut (
    	//In
        .clock_i(clock_s),
        .resetb_i(resetb_s),
        .start_i(start_s),
        .P_i(P_s),
        .data_valid_i(data_valid_s),
        .key_i(key_s),
        .nonce_i(nonce_s),
        //Out
        .C_o(C_s),
        .cipher_valid_o(cipher_valid_s),
        .end_o(end_s)
    );

    // Clock generation
    initial begin
        clock_s = 0;
        forever #5 clock_s = ~clock_s; // 100 MHz clock
    end

    // Test sequence
    initial begin

        // Format time displays
        $timeformat(-9, 3, " ns", 7);

        // Initialize signals
        resetb_s = 0;
        start_s = 0;
        key_s = 256'h4e7ced7e860e69aed3a53fefd52a3eec27a09386322fdc9a76a2b5eae921c73a;
        nonce_s = 96'hd4ac91b9caccf25906e46ce3;
        P_s = 128'h0;
        data_valid_s = 0;

        repeat (5) @(negedge clock_s); // Wait for a few clock cycles
        resetb_s = 1; // Release reset
        @(negedge clock_s);

        start_s = 1; // Start the encryption process
        @(negedge clock_s);
        
        start_s = 0; // Deassert start after one clock cycle
        
        wait (end_s == 1); // Wait for the end signal from the DUT

        @(negedge clock_s);

        // Send first plaintext word
        P_s = 128'h65704f20656966696e67697320657551;
        @(negedge clock_s);
        data_valid_s = 1; // Indicate that data is valid

        @(negedge clock_s);

        // Wait for cipher output to be valid
        wait (cipher_valid_s == 1);
        @(negedge clock_s);      
        $display("Ciphertext word #1 @%t: %h", $time, C_s); // Display the cipher output for the first word
        full_cipher_s[127:0] = C_s
        ; // Store the first 128 bits of cipher output
       
        data_valid_s = 0; // Deassert data valid after one clock cycle
        @(negedge clock_s);

        // Send second plaintext word
        P_s = 128'h65766e49206561727574614e20617472;
        @(negedge clock_s); 
        data_valid_s = 1; // Indicate that data is valid

        // Wait for cipher output to be valid
        wait (cipher_valid_s == 1);
        @(negedge clock_s);
        $display("Ciphertext word #2 @%t: %h", $time, C_s); // Display the cipher output for the second word
        full_cipher_s[255:128] = C_s; // Store the second 128 bits of cipher output
       
        data_valid_s = 0; // Deassert data valid after one clock cycle
         @(negedge clock_s);
        
        // Last plaintext word with 2 bytes of padding
        P_s = 128'h00003f206172656e754d20746e75696e;
        @(negedge clock_s);
        data_valid_s = 1; // Indicate that data is valid

        // Wait for cipher output to be valid
        wait (cipher_valid_s == 1);
        @(negedge clock_s);
        $display("Ciphertext word #3 @%t: %h", $time, C_s); // Display the cipher output for the third word
        full_cipher_s[367:256] = C_s[111:0]; // Store the last 112 bits of cipher output

        data_valid_s = 0; // Deassert data valid after one clock cycle

        #10;

        $display("Computed Ciphertext: %h", full_cipher_s); // Display the full 46 bytes of cipher output
        $display("Expected Ciphertext: fab0b90f73406abbf0408580ba3ee46c5ee17a42f515954acdecd4eeef62322523b73ceabe5e8e05fc68143022e0");
        $display("Computed ^ Expected: %h", full_cipher_s ^ 368'hfab0b90f73406abbf0408580ba3ee46c5ee17a42f515954acdecd4eeef62322523b73ceabe5e8e05fc68143022e0);

        if (|(full_cipher_s ^ 368'hfab0b90f73406abbf0408580ba3ee46c5ee17a42f515954acdecd4eeef62322523b73ceabe5e8e05fc68143022e0) == 0) begin
            $display("Test PASSED: Computed ciphertext matches expected value.");
        end else begin
            $display("Test FAILED: Computed ciphertext does NOT match expected value.");
        end

        //$finish; // End the simulation

    end
endmodule : chacha_top_tb
