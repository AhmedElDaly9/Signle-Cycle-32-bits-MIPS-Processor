/********************************************************/
/* Module Name: SignExtend                              */
/* Module Function:                                     */
/*  This is a simple parmaterized sign extend module    */
/*  responsible of replicating the most significant bit */
/*  to manipulate the needed offset immediate values.   */
/********************************************************/
module SignExtend #
(
    parameter   IN_INSTR_WIDTH  =   16  ,
    parameter   OUT_INSTR_WIDTH =   32
)
(
    input   wire    [IN_INSTR_WIDTH-1:0]    Inst    ,

    output  wire    [OUT_INSTR_WIDTH-1:0]   SignImm
);

    assign  SignImm = {{    (IN_INSTR_WIDTH)  {Inst[IN_INSTR_WIDTH-1]}}, Inst };

endmodule