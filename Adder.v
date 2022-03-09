/********************************************************/
/* Module Name: Adder                                   */
/* Module Function:                                     */
/*  This is a simple adder module to be used in Program */
/*  Counter incrementing and branching.                 */
/********************************************************/
module Adder #
(
    parameter   DATA_WIDTH  =   32
)
(
    input   wire    [DATA_WIDTH-1:0]  In_A  ,
    input   wire    [DATA_WIDTH-1:0]  In_B  ,

    output  wire    [DATA_WIDTH-1:0]  Out
);

assign  Out = In_A + In_B   ;

endmodule