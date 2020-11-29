`timescale 1ns/1ns
`include "InstructionMemory.v"

module InstructionMemory_tb;

reg clk;
reg  [7:0] address0;
reg  [7:1] address1;
reg  [7:2] address2;
reg  [7:3] address3;
reg  [7:4] address4;
reg  [7:5] address5;
reg  [7:6] address6;
reg  [7:7] address7;
wire [31:0]	 instruction;

InstructionMemory im(clk, address, instruction);

assign instruction = {address0,address1,address2,address3,address4,address5,address6,address7};

initial begin

	$dumpfile("InstructionMemory_tb.vcd");
	$dumpvars;
    

end
always begin

#10 clk = ~clk;

end
endmodule