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