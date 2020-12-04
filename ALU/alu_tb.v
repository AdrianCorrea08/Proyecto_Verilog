`timescale 1ns/1ns 
`include "alu.v"

module tb_alu;

 reg[7:0] a,b;
 reg[3:0] opcode;
 wire[7:0] resultado;
 wire zero;
 
 integer i;

 alu test_unit(a,b,opcode,resultado,zero );

initial begin
    $dumpfile("alu_tb.vcd");
	$dumpvars;
    
    a = 8'h0A;
    b = 8'h02;
    opcode = 4'h0;
      
    for (i=0;i<=15;i=i+1)
    begin
    opcode = opcode + 8'h01;
     #10;
    end;
      
    a = 8'hF6;
    b = 8'h0A;
      
    end
endmodule