`timescale 1ns/1ps
module hamming_encoder(data, encoder_data);
    input wire [3:0] data;
    output wire [6:0] encoder_data;

    assign encoder_data[0] = data[0] ^ data[1] ^ data[3];
    assign encoder_data[1] = data[0] ^ data[2] ^ data[3];
    assign encoder_data[2] = data[0];
    assign encoder_data[3] = data[1] ^ data[2] ^ data[3];
    assign encoder_data[4] = data[1];
    assign encoder_data[5] = data[2];
    assign encoder_data[6] = data[3];
endmodule