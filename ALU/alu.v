/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|opcode|   ALU Operation
----------------------------------------------------------------------
| 0000  |   resultado = a + b;
----------------------------------------------------------------------
| 0001  |   resultado = a - b;
----------------------------------------------------------------------
| 0010  |   resultado = a * b;
----------------------------------------------------------------------
| 0011  |   resultado = a / b;
----------------------------------------------------------------------
| 0100  |   resultado = a << 1;
----------------------------------------------------------------------
| 0101  |   resultado = a >> 1;
----------------------------------------------------------------------
| 0110  |   resultado = a rotated left by 1;
----------------------------------------------------------------------
| 0111  |   resultado = a rotated right by 1;
----------------------------------------------------------------------
| 1000  |   resultado = a and b;
----------------------------------------------------------------------
| 1001  |   resultado = a or b;
----------------------------------------------------------------------
| 1010  |   resultado = a xor b;
----------------------------------------------------------------------
| 1011  |   resultado = a nor b;
----------------------------------------------------------------------
| 1100  |   resultado = a nand b;
----------------------------------------------------------------------
| 1101  |   resultado = a xnor b;
----------------------------------------------------------------------
| 1110  |   resultado = 1 if a>b else 0;
----------------------------------------------------------------------
| 1111  |   resultado = 1 if a=b else 0;
----------------------------------------------------------------------*/

module alu(
           input [7:0] a,b,  // ALU 8-bit Inputs                 
           input [3:0] opcode,// ALU Selection
           output [7:0] resultado, // ALU 8-bit Output
           output zero // Carry Out Flag
    );
    reg [7:0] ALU_Result;
    wire [8:0] tmp;
    assign resultado = ALU_Result; // ALU out
    assign tmp = {1'b0,a} + {1'b0,b};
    assign zero = tmp[8]; // Carryout flag
    always @(*)
    begin
        case(opcode)
        4'b0000: // Addition
           ALU_Result = a + b ; 
        4'b0001: // Subtraction
           ALU_Result = a - b ;
        4'b0010: // Multiplication
           ALU_Result = a * b;
        4'b0011: // Division
           ALU_Result = a/b;
        4'b0100: // Logical shift left
           ALU_Result = a<<1;
         4'b0101: // Logical shift right
           ALU_Result = a>>1;
         4'b0110: // Rotate left
           ALU_Result = {a[6:0],a[7]};
         4'b0111: // Rotate right
           ALU_Result = {a[0],a[7:1]};
          4'b1000: //  Logical and 
           ALU_Result = a & b;
          4'b1001: //  Logical or
           ALU_Result = a | b;
          4'b1010: //  Logical xor 
           ALU_Result = a ^ b;
          4'b1011: //  Logical nor
           ALU_Result = ~(a | b);
          4'b1100: // Logical nand 
           ALU_Result = ~(a & b);
          4'b1101: // Logical xnor
           ALU_Result = ~(a ^ b);
          4'b1110: // Greater comparison
           ALU_Result = (a>b)?8'd1:8'd0 ;
          4'b1111: // Equal comparison   
            ALU_Result = (a==b)?8'd1:8'd0 ;
          default: ALU_Result = a + b ; 
        endcase
    end

endmodule