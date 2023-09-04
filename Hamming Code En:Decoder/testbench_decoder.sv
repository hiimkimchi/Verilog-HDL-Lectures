`timescale 1ns/1ps
module testbench_decoder;
    reg [6:0] encoder_data;
    wire [2:0] error_position;
    wire error;
    wire [3:0] data;

    hamming_decoder UUT(data,encoder_data,error_position,error);

    initial begin
        #2 encoder_data = 7'b1010101;
        #2 $display("output:  data=%b,  error_position=%d,   error=%b",data,error_position,error);
        #50 $stop;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,testbench_decoder);
    end
endmodule