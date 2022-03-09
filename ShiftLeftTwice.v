/********************************************************/
/* Module Name: ShiftLeftTwice                          */
/* Module Function:                                     */
/*  This is a simple shifting module to be used in      */
/*  program counter manipulating for dealing with the   */
/*  jump and offset immediate values instructions.      */
/********************************************************/
module ShiftLeftTwice #
(
    parameter   DATA_WIDTH  =   32
) 
(
    input   wire    [DATA_WIDTH-1:0]    IN  ,

    output  wire    [DATA_WIDTH-1:0]    OUT
);

    assign  OUT = IN << 2   ;
    
endmodule