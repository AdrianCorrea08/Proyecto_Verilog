module InstructionMemory (clk, address, instruction);

input		clk;
input	[31:0]	address;
output	[31:0]	instruction;

reg	[31:0]	instruction;

reg	[7:0]	memAddr;// memAddr es un registro de direcciones en el lado de la memoria.
reg	[31:0]	Imem[0:4];


// Definición de la latencia para bloquear la dirección y
// lee la memoria. 
// La I-Memory se carga inicialmente 
initial
	
	$readmemb ("Instruction.txt", Imem);
	
	// I-mem se lee en cada ciclo. 
	// Se puede agregar una señal de lectura si es necesario. 
always @(posedge clk) begin
	memAddr = address;
	instruction = Imem[memAddr];
end

endmodule
