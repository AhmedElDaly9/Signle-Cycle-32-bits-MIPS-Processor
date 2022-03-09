/****************************************************************/
/* Module Name: DataMemory                                      */
/* Module Function:                                             */
/*  Data memory is the RAM which the CPU uses to store          */
/*  and read the needed data, it has one 32-bit asynchronous    */ 
/*  read port and another 32-bit synchronous write port.        */
/****************************************************************/
module DataMemory #
(
    parameter   MEM_WIDTH       =   32  ,
    parameter   MEM_DEPTH       =   100 ,
    parameter   ADDRESS_WIDTH   =   32
)
(
    input   wire    [ADDRESS_WIDTH-1:0]     DataAddress ,
    input   wire    [MEM_WIDTH-1:0]         WD          ,
    input   wire                            WEN         ,
    input   wire                            CLK         ,
    input   wire                            rst         ,

    output  wire    [MEM_WIDTH-1:0]         RD          ,
    output  wire    [(MEM_WIDTH/2)-1:0]     testValue
);

    integer i   ;
    reg     [MEM_WIDTH-1:0]     RAM     [MEM_DEPTH-1:0] ;

    assign  RD  =   RAM[DataAddress]    ;
    
    always @(posedge CLK,negedge rst) 
        begin
            if(!rst)
                begin
                    for (i = 0 ; i < MEM_DEPTH ; i = i+1 ) 
                        begin
                            RAM[i]  <=  {(MEM_WIDTH){1'b0}} ;        
                        end
                end
            else
                begin
                    if(WEN)
                        begin
                            RAM[DataAddress]  <=  WD  ;
                        end
                end
        end

    assign  testValue = RAM[{(ADDRESS_WIDTH){1'b0}}]    [15:0];

endmodule