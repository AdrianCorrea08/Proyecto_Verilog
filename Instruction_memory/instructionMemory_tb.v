`timescale 1ns/1ns
`include "InstructionMemory.v"

module InstructionMemory_tb;

reg clk;
reg  [3:0] address0;
reg  [3:1] address1;
reg  [3:2] address2;
reg  [3:3] address3;
wire [31:0]	 instruction;

InstructionMemory im(clk, address, instruction);

assign instruction = {address0,address1,address2,address3};

initial begin

	$dumpfile("InstructionMemory_tb.vcd");
	$dumpvars;
    
	

end
always begin

#10 clk = ~clk;

end
endmodule