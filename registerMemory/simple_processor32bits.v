`timescale 1ns/1ns

//Instruction memory
module InstructionMemory (clk, address, instruction);
input		clk;
input	[63:0]	address;
output	[31:0]	instruction;
reg	[31:0]	instruction;
reg	[7:0]	memAddr;
reg	[31:0]	Imem[0:1];
initial	
	$readmemb ("Instruction.txt", Imem);
always @(posedge clk) begin
	memAddr = address;
	instruction = Imem[memAddr];
end
endmodule

//PROGRAM COUNTER
module Programcounter (clk, reset, cont,add);

input		clk;//Señales de reloj
input		reset;//reset de reloj
input [63:0] add;
output	[63:0]	cont;//contador

// Las salidas se definen como registros también                                              
reg	[63:0]	cont;
always @ (posedge clk)
begin
  if (reset)
    cont <= 16'h0;
  else if (add)
    cont <= cont + add; 
  else 
    cont <= cont + 1'b1;
end
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
reg [63:0] RF [63:0];

assign Data1 = {59'b0000000000000000000000000000000000000000000000000000000000,rs1};                         //64'b0000000000000000000000000000000000000000000000000000000000000010;//RF[rs1];
assign Data2 = 64'b0000000000000000000000000000000000000000000000000000000000000011;//RF[rs2];
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

//ADD + FOUR
module addFour(cont,salidaAddFour);
input clk;
input [63:0] cont;
output reg [63:0]salidaAddFour;

always @(posedge clk)
        salidaAddFour = salidaAddFour  + 4;
endmodule

//ADD <<
module addLeft (clk,contProgramData,shiftLef,salidaAddLeft);
input clk;
input [63:0] contProgramData;
input [63:0] shiftLef;
output [63:0] salidaAddLeft;
reg  [63:0] salidaAddLeft;
parameter B= 1;

always @(posedge clk)
    salidaAddLeft = shiftLef << B  + contProgramData;
endmodule

//IMMGEN
module  Imm_Gen(instruction_imm, clk,wireConection);
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

//DATA MEMORY
module data_memory (
input wire [63:0] Adress,          // Memory Address
input wire [63:0] WriteData,    // Memory Address Contents
input wire MemWrite, MemRead,
input wire clk,                  // All synchronous elements, including memories, should have a clock signal
output reg [63:0] ReadData      // Output of Memory Address Contents
);

reg [63:0] MEMO[0:1024];  // 256 words of 32-bit memory

time i;

initial begin
  ReadData <= 0;
  for (i = 0; i < 1023; i = i + 1) begin
    MEMO[i] = i;
  end
end

// Using @(Adress) will lead to unexpected behavior as memories are synchronous elements like registers
always @(posedge clk) begin
  if (MemWrite == 1'b1) begin
    MEMO[Adress] <= WriteData;
  end
  // Use MemRead to indicate a valid address is on the line and read the memory into a register at that address when MemRead is asserted
  if (MemRead == 1'b1) begin
    ReadData <= MEMO[Adress];
  end
end
endmodule

//MULTIPLEXOR DATAMEMORY
module multiplexorDataMemory(i3,i4,selectMemory,outMulti);
  input [63:0] i3;
  input [63:0] i4;
  input selectMemory;
  output [63:0] outMulti;
  reg outMulti;
  
  always @ (i3 or i4)
    case (selectMemory)
      1'b0: outMulti = i3;
      1'b1: outMulti = i4;
    endcase
endmodule




//SIMPLE PROCCESOR OF 32 BITS
module simple_processor ( 
    input clk,reset
    );
    // output salidaAddFour
    
wire [63:0] conexion1; //PROGRAM COUNTER TO INSTRUCTIONMEMORY,ADDFOUR,ADDLEFT
wire [31:0] conexion2; //INSTRUCTION MEMORY TO REGISTERMEMORY(RS1,RS2,RD),ALUCONTROL(funcode,funcondeseven)
wire [63:0] conexion3; //REGISTER MEMORY TO MULTIPLEXOR
wire [63:0] conexion4; //REGISTER MEMORU TO ALU A
wire [63:0] conexion5; // MULTIPLEXOR TO ALU B
wire conexion6;         // REGISTER MEMORY TO CONTROL UNIT WITH (REGWRITE)
wire [1:0] conexion7; // CONTROL UNIT WITH ALUOP TO ALUCONTROL
wire [3:0] conexion8; // ALU CONTROL to ALU
wire conexion9; //ALUSRC to  MULTIPLEXOR
wire conexion10; //branch to AND
wire conexion11; //zero to AND
wire [63:0] conexion12; //ADDFOUR TO MULTIPLEXOR
wire conexion13; //AND to multiplexor
wire [63:0] conexion14; //OUTPUT IMM TO MULTIPLEXOR AND ADDSHIFTLEFT
wire [63:0] conexion15; //ADDSUMLEFT TO MULTIPLEXOR 01
wire [63:0] conexion16; //ALU RESULT TO ADDRES OR MULTIPLEXOR DATAMEMORY
wire conexion17; // CONTROL MEMWRITE TO DATA MEMORY MEMWRITE
wire conexion18; // CONTROL MEMREAD TO DATA MEMORY MEMREAD
wire conexion19; //CONTROL MEMTOREG TO MULTIPLEXORDATAMEMORY
wire [63:0] conexion20; //DATA MEMORY READ DATA TO MULTIDATAMEMORY
wire [63:0] conexion21; //MULTIPLEXOR DATA MEMORY TO REGISTER MEMORY WRITEDATA
wire [63:0] conexion22; //MULTIPLEXOR SHIFTLEFT TO PC

//Union Modulos//
InstructionMemory im_instance(
    .clk(clk), 
    .address(conexion1),
    .instruction(conexion2)
    );

Programcounter pc_instance(
    .clk(clk), 
    .reset(reset), 
    .cont(conexion1),
    .add(conexion22)
    );

RegisterMemory RegisterMemory_instance(
    .rs1(conexion2[19:15]),
    .rs2(conexion2[24:20]),
    .rd(conexion2[11:7]),
    .WriteData(conexion21),
    .RegWrite(conexion6),
    .Data1(conexion4),
    .Data2(conexion3),
    .clk(clk));

multiplexor_bh multiplexor_bh_intance(
    .i0(conexion3),
    .i1(conexion14), 
    .select(conexion9),
    .y(conexion5));

ALU alu_instance(
    .A(conexion4),
    .B(conexion5),
    .ALUcontrol(conexion8),
    .ALUresult(conexion16),
    .Zero(conexion11));

control_unit control_unit_instance(
    .opcode(conexion2[6:0]),
    .alu_op(conexion7),
    .branch(conexion10),
    .memRead(conexion18),
    .memToReg(conexion19),
    .memWrite(conexion17),
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
    .i0(conexion12),
    .i1(conexion15), 
    .select(conexion13),
    .y(conexion22)
    );   

addFour addFour_instance(
    .cont(conexion1),
    .salidaAddFour(conexion12)
    );

addLeft addLeft_instance(
    .clk(clk),
    .contProgramData(conexion1),
    .shiftLef(conexion14), 
    .salidaAddLeft(conexion15)
    );


Imm_Gen Imm_Gen_instance(
    .instruction_imm(conexion2), 
    .wireConection(conexion14), 
    .clk(clk)
    );

data_memory data_memory_instance(
    .Adress(conexion16),         
    .WriteData(conexion3),    
    .MemWrite(conexion17), 
    .MemRead(conexion18),
    .clk(clk),                  
    .ReadData(conexion20)      
);

multiplexorDataMemory multiplexorDataMemory_instance(
    .i3(conexion16),//0 
    .i4(conexion20),  //1
    .selectMemory(conexion19),
    .outMulti(conexion21)
    );
endmodule









