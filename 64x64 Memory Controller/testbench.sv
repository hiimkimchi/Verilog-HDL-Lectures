module testbench;
    reg MemWrite, MemRead;
    reg [5:0] Addr;
    wire [63:0] DataBus;
    reg [63:0] Mem [0:63];

    memory UUT(
        .DataBus(DataBus),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Addr(Addr)
    );

    //read in values at the 6 different memory addresses
    initial begin
        MemWrite = 0;
        MemRead = 0;
        Addr = 0;
        #20;
        MemRead = 1;
        MemWrite = 0;
        Addr = 6'h00;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
        Addr = 6'h01;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
        Addr = 6'h02;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
        Addr = 6'h03;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
        Addr = 6'h04;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
        Addr = 6'h05;
        #10 $display("Memory read from Address %h----%h\n", Addr,DataBus);
        #20;
    end

    //generate waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule