module RegisterFile #
(
    parameter   FILE_WIDTH      =   32  ,
    parameter   FILE_DEPTH      =   100 ,
    parameter   REG_ADD_WIDTH   =   5
)
(
    input   wire    [REG_ADD_WIDTH-1:0]     A1      ,
    input   wire    [REG_ADD_WIDTH-1:0]     A2      ,
    input   wire    [REG_ADD_WIDTH-1:0]     A3      ,
    input   wire    [FILE_WIDTH-1:0]        WD3     ,
    input   wire                            WEN3    ,
    input   wire                            CLK     ,
    input   wire                            rst     ,

    output  wire    [FILE_WIDTH-1:0]        RD1     ,
    output  wire    [FILE_WIDTH-1:0]        RD2
);

    integer i ;
    reg     [FILE_WIDTH-1:0]    REG     [FILE_DEPTH-1:0]    ;

    assign  RD1 =   REG[A1] ;
    assign  RD2 =   REG[A2] ;

    always @(posedge CLK, negedge rst) 
        begin
            if (!rst)
                begin
                    for ( i = 0 ; i < FILE_DEPTH ; i = i+1 ) 
                        begin
                            REG[i]  <=   {(FILE_WIDTH){1'b0}}  ;        
                        end
                end
            else
                begin
                    if (WEN3)
                        begin
                            REG[A3]  <=  WD3 ;
                        end
                end
        end
    
endmodule