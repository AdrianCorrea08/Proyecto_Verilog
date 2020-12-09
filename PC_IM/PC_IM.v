module pc_im(clk,reset,cont,add,instruction,cont);
    
input		clk;//Señales de reloj
input		reset;//reset de reloj
input [31:0] add;

output	reg [31:0]	cont;//contador
output reg [31:0] instruction;


Programcounter pc(
    .clk(clk),
    .reset(reset),
    .add(add),
    .cont(cont)
);

InstructionMemory im(
    .clk(clk),
    .address(cont),
    .instruction(instruction)
);

endmodule


