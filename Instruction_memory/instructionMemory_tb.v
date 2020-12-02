`timescale 1ns/1ns
`include "instructionMemory.v"

module instructionMemory_tb;

reg clk = 0;
reg  [7:0]	address;
wire [31:0]	 instruction;

InstructionMemory im(clk, address, instruction);


initial begin

	$dumpfile("InstructionMemory_tb.vcd");
	$dumpvars;
<<<<<<< HEAD
  address = 'b0;
	$monitor ($realtime, " Instruction = %0b" , instruction);
  repeat(4)
	begin
    #50;
    address = address + 1'd1;
  end
  $finish;
=======
    
	

>>>>>>> 873f1dcec3edaca9448bb1a00ed7143c72046871
end

always begin
#10 clk = ~clk;
end

endmodule