`timescale 1ns/1ps
module hamming_decoder(data,encoder_data,pos_error,error);
    input [6:0] encoder_data;
    output [3:0] data;
    output [2:0] error_position;
    output error;

    assign data[0] = encoder_data[2];
    assign data[1] = encoder_data[4];
    assign data[2] = encoder_data[5];
    assign data[3] = encoder_data[6];

    assign c1 = encoder_data[0] ^ encoder_data[2] ^ encoder_data[4] ^ encoder_data[6];
    assign c2 = encoder_data[1] ^ encoder_data[2] ^ encoder_data[5] ^ encoder_data[6];
    assign c3 = encoder_data[3] ^ encoder_data[4] ^ encoder_data[5] ^ encoder_data[6];
    
    //if this is 0 then there is no error
    assign error_position = {c3,c2,c1};
    //any '1' will make error true
    assign error = c3 | c2 | c1;
endmodule