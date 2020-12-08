//Codigo del libro Computer Organization and Design RISC-V Edition: The Hardware Software Interface

/*module ALUcontrol(ALUop,FuncCode,ALUcontrol);

input [1:0] ALUop;
input [5:0] FuncCode;
output reg[3:0] ALUcontrol;

always 
  case(FuncCode)
    32: ALUop <= 2; //add
    34: ALUop <= 6; //sub
    36: ALUop <= 0; //and
    37: ALUop <= 1; //or
    39: ALUop <= 12;//nor
    42: ALUop <= 7; //stl
    default : ALUop <= 15;
 endcase
endmodule*/


module ALUcontrol(ALUop,FuncCode,FuncCodeSeven,ALU_Cnt);

input [1:0] ALUop;
input [2:0] FuncCode; ///FUNCT3 3 BITS [14-12]
input FuncCodeSeven; //FUCT 7 POS 30
output reg[3:0] ALU_Cnt;
input wire [5:0] ALUControlIn;

assign ALUControlIn = {ALUop,FuncCode,FuncCodeSeven};
 always @(ALUControlIn)
    casex (ALUControlIn)
        6'b100000: ALU_Cnt=4'b0010;  //add
        6'b010000: ALU_Cnt=4'b0110;  //sub
        6'b101110: ALU_Cnt=4'b0000;  //and
        6'b101100: ALU_Cnt=4'b0001;  //or
        6'b00011x: ALU_Cnt=4'b0010;  //ld
        6'b10011x: ALU_Cnt=4'b0010;  //sd
        6'b01000x: ALU_Cnt=4'b0110;  //beq
        default: ALU_Cnt=4'b0000;
    endcase
endmodule