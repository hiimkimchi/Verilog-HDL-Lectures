`timescale 1ns/1ps
module fifo(clk,reset,write_enable,read_enable,din,dout,full,empty);
    input clk,reset;
    input write_enable,read_enable;
    input [7:0] din;
    output [7:0] dout;
    output full,empty;

    wire clk,reset;
    wire write_enable,read_enable;
    wire [7:0] din;
    reg [7:0] dout;
    wire full,empty; //since we use 'assign', we must declare these as wires
    reg [3:0] addr; //4 bit address
    reg [7:0] mem [0:15]; //16 x 8 declaration of ram

    assign full = (addr == 4'b1111) ? 1'b1 : 1'b0; //ternary operator saying if it is full, true, if not false
    assign empty = (addr == 4'b0000) ? 1'b1 : 1'b0; //same thing here but for the empty

    always@(posedge clk)
        begin
            if(reset) //reset fifo
                begin
                    addr = 0;
                    for(i = 0;i < 15; i++)
                        mem[i] = 8'b0;
                end
            else if(write_enable | read_enable) //read or write
                begin
                    if(write_enable && (!full)) //write in datain and increment address
                        begin
                            mem[addr] = din;
                            addr++;
                        end
                    else
                        if(read_enable && (!empty)) //send out dataout and shift the memory addresses accordingly
                            begin
                                dout = mem[0];
                                for(i = 0;i < 14; i++) 
                                    mem[i] = mem[i + 1];
                                mem[15] = 8'b0;
                                addr--;
                            end
                end
        end 
endmodule
