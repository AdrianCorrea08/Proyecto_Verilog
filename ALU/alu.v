module ALU(A,B,ALUcontrol,ALUresult,Zero);

 input  [63:0] A;  
 input  [63:0] B; 
 input  [3:0] ALUcontrol; 
 output reg [63:0] ALUresult;
 output Zero;
assign Zero = (ALUresult == 0); 
always @(ALUcontrol,A,B)

  case(ALUcontrol)
    4'b0010:  ALUresult = A + B; //add  //ld sd
    4'b0110:  ALUresult = A - B; //sub  //beq
    4'b0000:  ALUresult = A & B; //and
    4'b0001:  ALUresult = A | B; //or
    default : ALUresult <= 0;// por defecto A= 0, no debería suceder;

  endcase

endmodule
