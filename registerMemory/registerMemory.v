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

