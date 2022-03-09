/************************************************************/
/* Module Name: ProgramCounter                              */
/* Module Function:                                         */
/*  The program counter module is responsible of updating   */
/*  the program counter value on the positive edge CLK      */
/*  and reseting the program conunter on the negative edge  */
/*  reset.                                                  */
/************************************************************/
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