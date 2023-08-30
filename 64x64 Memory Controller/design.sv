`timescale 1ns/10ps
module memroy(DataBus,MemWrite, MemRead, Addr);
    inout [63:0] DataBus;
    input MemWrite, MemRead;
    input [5:0] Addr;
    reg [63:0] datareg;
    reg [63:0] Mem [0:63]; //declaring a 64x64 memory array (64 locations, 64 bits per)

    //write process
    initial begin
        $readmemh("input.txt", Mem);
        $display($time,"ns data writing process complete");
    end

    //read process
    always @(MemWrite or MemRead or Addr or datareg) begin
        if(MemWrite==1'b1 && MemRead==1'b0) begin
            Mem[Addr] = DataBus;
            datareg = 64'hzzzzzzzzzzzzzzz;
        end
        else if (MemRead==1'b1) begin
            datareg = Mem[Addr]; //read in memory to the data register
            $display($time,"ns data read Address- %h is %h\n", Addr,datareg); //access
            $display($time,"ns data bus data is %h\n", DataBus); 
        end
        else
            datareg=64'hzzzzzzzzzzzzzzz;
    end
    assign DataBus = datareg;
endmodule