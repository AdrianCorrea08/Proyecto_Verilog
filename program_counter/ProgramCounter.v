`timescale 1ns/1ns

module Programcounter (clk, reset, cont,add);

input		clk;//Señales de reloj
input		reset;//reset de reloj
input [63:0] add;
output	[63:0]	cont;//contador

// Las salidas se definen como registros también                                              
reg	[63:0]	cont;
always @ (posedge clk)
begin
  if (reset)
    cont <= 16'h0;
  else if (add)
    cont <= cont + add; 
  else 
    cont <= cont + 1'b1;
end
endmodule









// always @(posedge clk)
// 	if (!reset)
// 		cont = 16'h0000000000000000 + cont + 1;
// 	else
// 		cont = 0;
