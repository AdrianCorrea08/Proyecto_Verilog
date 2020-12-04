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