/************************************************************/
/* Module Name: MUX_2x1                                     */
/* Module Function:                                         */
/*  This is a simple 2x1 Multiplexer module to be used      */
/*  in the Data path to determine the appropriate           */
/*  program counter and data values based on the control    */
/*  signals coming from the control unit.                   */
/************************************************************/
module MUX_2x1 #
(
    parameter   DATA_WIDTH  =   32
)
(
    input   wire    [DATA_WIDTH-1:0]    IN_0    ,
    input   wire    [DATA_WIDTH-1:0]    IN_1    ,
    input   wire                        Sel     ,

    output  wire    [DATA_WIDTH-1:0]    OUT   
);

    assign  OUT =  (Sel)?   IN_1    :   IN_0    ; 
    
endmodule