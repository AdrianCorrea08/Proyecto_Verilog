// clk: el reloj (entrada) 
// reset: pone a cero el contador sincrónicamente (entrada) 
// cnt: la salida del contador (salida) 

`timescale 1ns/1ns

module Programcounter (clk, reset, cont);

input		clk;//Señales de reloj
input		reset;//reset de reloj
output	[7:0]	cont;//contador

// Las salidas se definen como registros también 
reg	[7:0]	cont;

always @(posedge clk)

	if (!reset)
		cont = cont + 1;
	else
		cont = 0;

endmodule