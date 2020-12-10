`include "simple_processor32bits.v"
`timescale 1ns/1ns

module simple_proccessor32bits_tb;
reg clk = 0;
reg reset;

simple_processor simple_proccessor32bitstb(clk, reset);

initial begin

	$dumpfile("simple_proccessor32bits_tb.vcd");
	$dumpvars;
    reset = 0;
	#70
	reset = 1;
	#70
	reset = 0;
	#70
	reset = 1;
    #70
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
