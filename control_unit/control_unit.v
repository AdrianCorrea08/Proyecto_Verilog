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