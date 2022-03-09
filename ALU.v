/************************************************************/
/* Module Name: ALU                                         */
/* Module Function:                                         */
/*  ALU is responsible of performing the AND, OR, Add,      */
/*  Subtract, Multiply and Set less than, through the 3-bit */
/*  ALU control signal coming from the control unit.        */
/************************************************************/
module ALU#
(
    parameter   DATA_WIDTH      =   32
)
(
    input   wire    [DATA_WIDTH-1:0]    SrcA        ,
    input   wire    [DATA_WIDTH-1:0]    SrcB        ,
    input   wire    [2:0]               ALUControl  ,

    output  reg     [DATA_WIDTH-1:0]    ALUResult   ,   
    output  wire                        Zero
);

localparam AND  = 3'b000    ;
localparam OR   = 3'b001    ;
localparam PLS  = 3'b010    ;
localparam MIN  = 3'b100    ;
localparam MUL  = 3'b101    ;
localparam SLT  = 3'b110    ;

    always @ (*)
        begin
            case (ALUControl)
                AND :   ALUResult = SrcA & SrcB     ;
                OR  :   ALUResult = SrcA | SrcB     ;
                PLS :   ALUResult = SrcA + SrcB     ;
                MIN :   ALUResult = SrcA - SrcB     ;
                MUL :   ALUResult = SrcA * SrcB     ;
                SLT :   ALUResult = (SrcA < SrcB)   ;

                default :   ALUResult = {(DATA_WIDTH){1'b0}}    ;
            endcase
        end

    assign  Zero  = ~(|ALUResult)   ;

endmodule