`timescale 1ns/1ps
module testbench_encoder;
    reg [3:0] data;
    wire [6:0] encoder_data;

    hamming_encoder UUT(data,encoder_data);

    initial begin
        #2 data = 4'b1011;
        #2 $display("output-encoder_data=%b", encoder_data);
        #50 $stop; //output should be = 1010101
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,testbench_encoder);
    end
endmodule