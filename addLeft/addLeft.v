module addLeft (clk,contProgramData,shiftLef,salidaAddLeft);
input clk;
input [7:0] contProgramData;
input [63:0] shiftLef;
output [71:0] salidaAddLeft;
reg  [71:0] salidaAddLeft;
parameter B= 1;

always @(posedge clk)
    salidaAddLeft = shiftLef << B  + contProgramData;
endmodule



//contProgramData

//salidaAddLeft