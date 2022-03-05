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

    assign  OUT =  (Sel)?   IN_0    :   IN_1    ; 
    
endmodule