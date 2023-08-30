`timescale 1ns/1ps
module testbench;
    reg clk,reset;
    reg write_enable,read_enable;
    reg [7:0] din;
    wire [7:0] dout;
    wire full,empty;

    //instantiate
    fifo UUT(clk,reset,write_enable,read_enable,din,dout,full,empty);
    
    //initialize clock
    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    //resets the FIFO
    task reset;
        begin
            reset = 1;
            #20 reset = 0;
        end
    endtask

    //initializes writing and reading processes
    task write_read_initialize;
        begin
            write_enable = 0;
            read_enable = 0;
            din = 0;
        end
    endtask

    //write process
    task write;
        input [7:0] write_data;
        begin
            write_enable = 1;
            din = write_data;
        end
    endtask

    //writes 16 times
    task write16;
        begin
            write(8'hff);
            write(8'hfe);
            write(8'hfd);
            write(8'hfc);
            write(8'hfb);
            write(8'hfa);
            write(8'hf9);
            write(8'hf8);
            write(8'hf7);
            write(8'hf6);
            write(8'hf5);
            write(8'hf4);
            write(8'hf3);
            write(8'hf2);
            write(8'hf1);
            write(8'hf0);
        end
    endtask

    //ends writing process
    task endwrite;
        write_enable = 0;
    endtask

    //read process
    task read;
        begin
            @(posedge clk)
                read_enable = 1;
        end
    endtask

    //reads 16 times
    task read16;
        begin
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
            read;
        end
    endtask

    //ends the reading
    task endread;
        begin
            @(posedge clk)
                read_enable = 0;
        end
    endtask

    //call all the tasks
    initial begin 
        reset;
        write16;
        endwrite;
        #2
        read16;
        #10
        endread;
        #10 $stop
    end

    //waveform generation
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,testbench);
    end
endmodule