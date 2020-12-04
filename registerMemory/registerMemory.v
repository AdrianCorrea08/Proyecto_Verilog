<<<<<<< HEAD
`timescale 1ns / 1ps

module RegisterMemory(rs1,rs2,rd,WriteData,RegWrite,Data1,Data2,clk);

input    clk;      //La clk para activar la escritura
input    RegWrite; //el control de escritura

// los números de registro para leer o escribir
input  [5:0] rs1;        
input  [5:0] rs2;        
input  [5:0] rd; 

//datos para escribir
input  [63:0] WriteData; 

//los valores de registro leídos
output  [63:0] Data1;    
output  [63:0] Data2;    

//32 registros cada uno de 32 bits de longitud
reg [63:0] RF [31:0];

assign Data1 = RF[rs1];
assign Data2 = RF[rs2];
//integer i;

/*initial begin
 for(i=0;i<8;i=i+1)
   RF[i] <= 64'd0;
 end*/

 //escribir el registro con un nuevo valor si RegWrite es alto
always @ (posedge clk ) begin
  if(RegWrite) begin
    RF[rd] <= WriteData;
  end
end

endmodule
=======
`timescale 1ns/ 1ns
module registerMemory(clk,rs1 ,rs2, writeRegister,writeData,control,data1,data2);

input clk;
input [19:15] rs1; 
input [24:20] rs2; 
input [11:7] writeRegister; //rd
input [] writeData;
output [31:0] data1;
output [31:0] data2;


endmodule

module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET) ;
 //Initalizing inputs
 input [2:0] INADDRESS;
 input [2:0] OUT1ADDRESS;
 input [2:0] OUT2ADDRESS;
 input WRITE;
 input CLK;
 input RESET;
 input [7:0] IN;
 //initializing outputs
 output [7:0] OUT1;
 output [7:0] OUT2;
 //initializing register variables
integer i; 
 //creating the register array
 reg [7:0] regFile [0:7]; 
 //resetting the registers if the reset is 1 as a level triggered input
 always@(*)
 if (RESET == 1) begin 
 #2
 for (i = 0; i < 8; i = i + 1) 
 begin
 regFile [i] = 8'b00000000 ; 
 end 
 
 end 
 //this always block runs of the positive edge of the clock and write to the register if write is ennable
 always@(posedge CLK)
 begin 
 if(WRITE == 1'b1 && RESET == 1'b0) begin
 #2 regFile [INADDRESS] = IN; //this includes the write reg delay
 //$monitor($time,” %b”,regFile [INADDRESS]);
 end 
 end
 
 //this is for reading the inputs from the registers
 //this part was modified after the lab 5 part 3 submission
 assign #2 OUT1 = regFile[OUT1ADDRESS];
 assign #2 OUT2 = regFile[OUT2ADDRESS];
endmodule
>>>>>>> 3294f9e5d3c467e46dfd0ca964d063eb1f41de5f
