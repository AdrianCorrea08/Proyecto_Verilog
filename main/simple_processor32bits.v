`timescale 1ns/1ns

//Instruction memory
module InstructionMemory (clk, address, instruction);
input		clk;
input	[7:0]	address;
output	[31:0]	instruction;
reg	[31:0]	instruction;
reg	[7:0]	memAddr;
reg	[31:0]	Imem[0:4];
initial	
	$readmemb ("Instruction.txt", Imem);
always @(posedge clk) begin
	memAddr = address;
	instruction = Imem[memAddr];
end

endmodule

//PROGRAM COUNTER
module Programcounter (clk, reset, cont);
input		clk;
input		reset;
output	[7:0]	cont;
reg	[7:0]	cont;

always @(posedge clk)
	if (!reset)
		cont = cont + 1;
	else
		cont = 0;
endmodule
//REGISTER MEMORY
`timescale 1ns / 1ps
module RegisterMemory(rs1,rs2,rd,WriteData,RegWrite,Data1,Data2,clk);
input    clk;      
input    RegWrite; 
input  [4:0] rs1;        
input  [4:0] rs2;        
input  [4:0] rd;     
input  [63:0] WriteData; 
output  [63:0] Data1;    
output  [63:0] Data2;    
reg [63:0] RF [31:0];

assign Data1 = RF[rs1];
assign Data2 = RF[rs2];
always @ (posedge clk ) begin
  if(RegWrite) begin
    RF[rd] <= WriteData;
  end
end
endmodule

//MULTIPLEXOR REGISTER
module multiplexor_bh (i0,i1,select,y);
  input [63:0] i0;
  input [63:0] i1;
  input select;
  output [63:0]y;
  reg y;
  
  always @ (i0 or i1)
    case (select)
      1'b0: y = i0;
      1'b1: y = i1;
    endcase
endmodule

//ALU
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
//CONTROL UNIT
module control_unit(
                    input [6:0] opcode,
                    output reg[1:0] alu_op,
                    output reg branch,memRead,memToReg,memWrite,aluSrc,regWrite
    );
    always @(*)
    begin
        case(opcode)
        7'b0110011: //ADD
        begin 
            alu_op =   2'b10;
            branch =   1'b0;
            memRead =  1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            aluSrc =   1'b0;
            regWrite = 1'b1;
        end
        7'b0110011: //SUBSTRACT
        begin
            alu_op =   2'b01;
            branch =   1'b0;
            memRead =  1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            aluSrc =   1'b0;
            regWrite = 1'b1;
        end
        7'b0110011: //AND
        begin
        alu_op =   2'b10;
        branch =   1'b0;
        memRead =  1'b0;
        memToReg = 1'b0;
        memWrite = 1'b0;
        aluSrc =   1'b0;
        regWrite = 1'b1;

        end
        7'b0110011: //OR
        begin
        alu_op =   2'b10;
        branch =   1'b0;
        memRead =  1'b0;
        memToReg = 1'b0;
        memWrite = 1'b0;
        aluSrc =   1'b0;
        regWrite = 1'b1;
        end
        //////////////////////
        7'b0000011: //LD
        begin
        alu_op =   2'b00;
        branch =   1'b0;
        memRead =  1'b1;
        memToReg = 1'b1;
        memWrite = 1'b0;
        aluSrc =   1'b1;
        regWrite = 1'b1;
        end
        7'b0100011: //SD
        begin
        alu_op =   2'b10;
        branch =   1'b0;
        memRead =  1'b0;
        memWrite = 1'b1;
        aluSrc =   1'b1;
        regWrite = 1'b0;


        end
        7'b1100011: //BEQ
        begin
        alu_op =   2'b01;
        branch =   1'b1;
        memRead =  1'b0;
        memWrite = 1'b0;
        aluSrc =   1'b0;
        regWrite = 1'b0;
        end
   endcase 
   end
endmodule

//ALU CONTROL
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

//AND Gate
module andGate(
    input D,
    input E,
    output out);

assign out= D & E;
endmodule

//MULTIPLEXOR SHIFT LEFT
module multiplexorShiftLeft(i0,i1,select,y);
  input [7:0] i0;
  input [63:0] i1;
  input select;
  output [63:0]y;
  reg y;
  
  always @ (i0 or i1)
    case (select)
      1'b0: y = i0;
      1'b1: y = i1;
    endcase
endmodule

//ADD + FOUR
module addFour(cont,salidaAddFour);
input clk;
input [7:0] cont;
output [4:0]salidaAddFour;

always @(posedge clk)
        salidaAddFour = salidaAddFour  + 4;
endmodule

//ADD <<
module addLeft (clk,contProgramData,shiftLef,salidaAddLeft);
input clk;
input contProgramData;
input shiftLef;
output salidaAddLeft;
reg shiftLef;
reg salidaAddLeft;

always @(posedge clk)
    shiftLef = shiftLef << 1;
    salidaAddLeft = shiftLef  + contProgramData;
endmodule




//SIMPLE PROCCESOR OF 32 BITS
module simple_processor ( 
    input clk,reset,rs1,rs2,rd,WriteData,RegWrite,i0,i1,select,A,B,ALUcontrol,ALUresult,Zero,ALUop,FuncCode,FuncCodeSeven,ALU_Cnt,D,E,
    output [7:0] cont,
    output Data1,Data2,y,branch,memRead,memToReg,memWrite,aluSrc,regWrite,out,
    input [6:0] opcode,
    output reg[1:0] alu_op);
    // output salidaAddFour
    
wire [7:0] conexion1;
wire [31:0] conexion2;
wire [63:0] conexion3;
wire [63:0] conexion4;
wire [63:0] conexion5;
wire conexion6;
wire [1:0] conexion7; // 
wire [3:0] conexion8; // ALU CONTROL to ALU
wire conexion9; //ALUSRC to  MULTIPLEXOR
wire conexion10; //branch to AND
wire conexion11; //zero to AND
wire [7:0] conexion12;
wire conexion13; //AND to multiplexor

//Union Modulos//
InstructionMemory im_instance(
    .clk(clk), 
    .address(conexion1),
    .instruction(conexion2)
    );

Programcounter pc_instance(
    .clk(clk), 
    .reset(reset), 
    .cont(conexion1)
    );

RegisterMemory RegisterMemory_instance(
    .rs1(conexion2[19:15]),
    .rs2(conexion2[24:20]),
    .rd(conexion2[11:7]),
    // .WriteData,
    .RegWrite(conexion6),
    // .Data1,
    // .Data2,
    .clk(clk));

multiplexor_bh multiplexor_bh_intance(
    .i0(conexion3),
    .i1(conexion3), //ESTE NO ES VIENE ES DEL INMEDIATO
    .select(conexion9),
    .y(conexion5));

ALU alu_instance(
    .A(conexion4),
    .B(conexion5),
    .ALUcontrol(conexion8),
    .ALUresult(conexion5[63:0]), //cambiar 
    .Zero(conexion11));

control_unit control_unit_instance(
    .opcode(conexion2[6:0]),
    .alu_op(conexion7[1:0]),
    .branch(conexion10),
    .memRead,
    .memToReg,
    .memWrite,
    .aluSrc(conexion9),
    .regWrite(conexion6)
    );

ALUcontrol ALUcontrol_instance(
    .ALUop(conexion7),
    .FuncCode(conexion2[14:12]),
    .FuncCodeSeven(conexion2[30:30]),
    .ALU_Cnt(conexion8)
    );

andGate andGate_instance(
    .D(conexion10),
    .E(conexion11),
    .out(conexion13)); 

multiplexorShiftLeft multiplexorShiftLeft_instance(
    i0(conexion12),
    i1(conexion13),
    select(conexion13),
    y);   //FALTA MULTIPLEXOR TO PC

addFour addFour_instance(
    .cont(conexion1),
    .salidaAddFour(conexion12)
    );

addLeft addLeft_instance(
    .clk(clk)
    .contProgramData(conexion1),
    .shiftLef(),  //CONEXIONAR CON IMM CAMBIAR
    .salidaAddLeft(conexion13));//conexionar con 64 bits CAMBIAR
endmodule









