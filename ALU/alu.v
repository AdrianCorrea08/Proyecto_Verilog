/* Operaciones aritméticas y lógicas de ALU
----------------------------------------------------------------------
|opcode|   ALU Operation
----------------------------------------------------------------------
| 0000  |   ALUresult = A & B;
----------------------------------------------------------------------
| 0001  |   ALUresult = A | B;
----------------------------------------------------------------------
| 0010  |   ALUresult = A + B;
----------------------------------------------------------------------
| 0110  |   ALUresult = A - B;
----------------------------------------------------------------------
| 0111  |   ALUresult = slt;
----------------------------------------------------------------------
| 1100  |   ALUresult = nor;
---------------------------------------------------------------------*/

module ALU(A,B,ALUcontrol,ALUresult,Zero);

 input  [63:0] A;  
 input  [63:0] B; 
 input  [3:0] ALUcontrol; 
 
 output reg [63:0] ALUresult;
 output Zero;

// Cero es verdadero si ALUresult es 0; va A cualquier parte
assign Zero = (ALUresult == 0); 

// Reevaluar si estas cambian
always @(ALUcontrol,A,B)

  case(ALUcontrol)

    4'b0010:  ALUresult = A + B; //add  //ld sd
    4'b0110:  ALUresult = A - B; //sub  //beq
    4'b0000:  ALUresult = A & B; //and
    4'b0001:  ALUresult = A | B; //or
    default : ALUresult <= 0;// por defecto A= 0, no debería suceder;

  endcase

endmodule
