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


module ALUcontrol(ALUop,FuncCode,ALUcontrol);

input [1:0] ALUop;
input [5:0] FuncCode;
output reg[3:0] ALUcontrol;

wire [7:0] ALUControlIn;

assign ALUControlIn = {ALUop,FuncCode};
 always @(ALUControlIn)
    case (ALUControlIn)
        32: ALUcontrol <= 2;    //add
        34: ALUcontrol <= 6;    //sub
        36: ALUcontrol <= 0;    //and
        37: ALUcontrol <= 1;    //or
        39: ALUcontrol <= 12;   //nor
        42: ALUcontrol <= 7;    //stl
        default: ALUcontrol <= 15;
    endcase
endmodule