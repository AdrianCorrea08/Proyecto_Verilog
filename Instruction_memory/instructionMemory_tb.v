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
  address = 'b0;
	$monitor ($realtime, " Instruction = %0b" , instruction);
  repeat(4)
	begin
    #50;
    address = address + 1'd1;
  end
  $finish;
    
	

end

always begin
#10 clk = ~clk;
end

endmodule