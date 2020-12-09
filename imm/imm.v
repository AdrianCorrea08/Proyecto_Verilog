module  Imm_Gen(instruction_imm, clk);
  input [31:0] instruction_imm;
  input clk; 
  wire [11:0] Data_1;
  wire Data_2;
  output reg [63:0] wireConection;
  reg One = 52'b1111111111111111111111111111111111111111111111111111;
  reg Cero = 52'b0000000000000000000000000000000000000000000000000000;
  assign Data_1 = instruction_imm[31:20];
  assign Data_2 = instruction_imm[31:31];

always @ (posedge clk) 
   if(Data_2 == 1)
    wireConection = {One, Data_1};
   else 
    wireConection = {Cero, Data_2};
  
endmodule