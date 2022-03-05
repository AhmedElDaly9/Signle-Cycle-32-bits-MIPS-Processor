module ProgramCounter#
(
    parameter INSTR_WIDTH   =   32
)
(
    input   wire                        CLK     ,
    input   wire                        rst     ,
    input   wire   [INSTR_WIDTH-1:0]    PC_in   ,

    output  reg    [INSTR_WIDTH-1:0]    PC
);
    
    always @(posedge CLK , negedge rst)
        begin
            if (~rst)
                begin
                    PC <= {(INSTR_WIDTH){1'b0}} ;
                end
            else
                begin
                    PC <= PC_in ;
                end
        end

endmodule