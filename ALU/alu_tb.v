// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for ALU
// by FPGA4STUDENT
 `timescale 1ns/1ns 
`include "alu.v"

module tb_alu;
//Inputs
 reg[7:0] a,b;
 reg[3:0] opcode;

//Outputs
 wire[7:0] resultado;
 wire zero;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            a,b,  // ALU 8-bit Inputs                 
            opcode,// ALU Selection
            resultado, // ALU 8-bit Output
            zero // Carry Out Flag
     );
    initial begin
    $dumpfile("alu_tb.vcd");
	$dumpvars;
    
    // hold reset state for 100 ns.
      a = 8'h0A;
      b = 8'h02;
      opcode = 4'h0;
      
      for (i=0;i<=15;i=i+1)
      begin
       opcode = opcode + 8'h01;
       #10;
      end;
      
      //a = 8'hF6;
      //b = 8'h0A;

    end
endmodule