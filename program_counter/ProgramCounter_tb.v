`timescale 1ns/1ns
`include "ProgramCounter.v"

module ProgramCounter_tb;

reg clk = 0;
reg reset;
wire [7:0]	 cont;

Programcounter pc(clk, reset, cont);

initial begin

	$dumpfile("ProgramCounter_tb.vcd");
	$dumpvars;
    reset = 0;
	#70
	reset = 1;
	#70
	reset = 0;
	#70
	reset = 1;
	$finish(500);
	
end

always begin

#10 clk = ~clk;

end

endmodule
