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