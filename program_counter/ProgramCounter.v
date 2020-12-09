`timescale 1ns/1ns

module Programcounter (clk, reset, cont,add);

input		clk;//Señales de reloj
input		reset;//reset de reloj
input [7:0] add;
output	[7:0]	cont;//contador

// Las salidas se definen como registros también                                              
reg	[7:0]	cont;


always @(posedge clk)
	if (!reset)
		cont = cont + 1;
	else
		cont = 0;
endmodule
