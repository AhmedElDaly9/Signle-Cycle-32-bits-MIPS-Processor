module Datapath #
(
    parameter   INSTR_WIDTH     =   32  ,
    parameter   ADDRESS_WIDTH   =   32  ,
    parameter   DATA_WIDTH      =   32
) 
(
    input   wire    [INSTR_WIDTH-1:0]   Instruction ,
    input   wire    [DATA_WIDTH-1:0]    ReadData    ,
    input   wire    [2:0]               ALUControl  ,
    input   wire                        PCSrc       ,
    input   wire                        Jmp         ,
    input   wire                        MemtoReg    ,
    input   wire                        ALUSrc      ,
    input   wire                        RegDst      ,
    input   wire                        RegWrite    ,
    input   wire                        CLK         ,
    input   wire                        rst         ,

    output  wire    [ADDRESS_WIDTH-1:0] PC          ,
    output  wire    [DATA_WIDTH-1:0]    ALUOut      ,
    output  wire    [DATA_WIDTH-1:0]    WriteData   ,
    output  wire                        Zero        
);

/***************************INTERNAL SIGNALS***************************/

    wire    [ADDRESS_WIDTH-1:0]     PC_in               ;
    wire    [ADDRESS_WIDTH-1:0]     PCPlus4             ;
    wire    [ADDRESS_WIDTH-1:0]     PCBranch            ;
    wire    [ADDRESS_WIDTH-1:0]     PlusOrBranchMUX_out ;
    wire    [ADDRESS_WIDTH-1:0]     SignImm             ;
    wire    [ADDRESS_WIDTH-1:0]     SignImmShiftOut     ;
    wire    [ADDRESS_WIDTH-5:0]     JmpInstShiftOut     ;

    wire    [DATA_WIDTH-1:0]        SrcA                ;
    wire    [DATA_WIDTH-1:0]        SrcB                ;
    wire    [DATA_WIDTH-1:0]        RegWD3Result        ;
    wire    [4:0]                   WriteReg            ;

/***************************REGISTER FILE***************************/
/*
    input   wire    [REG_ADD_WIDTH-1:0]     A1  ,
    input   wire    [REG_ADD_WIDTH-1:0]     A2  ,
    input   wire    [REG_ADD_WIDTH-1:0]     A3  ,
    input   wire    [FILE_WIDTH-1:0]        WD3 ,
    input   wire                            WEN3,
    input   wire                            CLK ,
    input   wire                            rst ,

    output  wire    [FILE_WIDTH-1:0]        RD1 ,
    output  wire    [FILE_WIDTH-1:0]        RD2
*/
    RegisterFile REG
    (
        .A1     (Instruction[25:21])   ,
        .A2     (Instruction[20:16])   ,
        .A3     (WriteReg)             ,
        .WD3    (RegWD3Result)         ,
        .WEN3   (RegWrite)             ,
        .CLK    (CLK)                  ,
        .rst    (rst)                  ,

        .RD1    (SrcA)                 ,
        .RD2    (WriteData)            
    );


/***************************MULTIPLEXERS***************************/
/*
    input   wire    [DATA_WIDTH-1:0]    IN_0    ,
    input   wire    [DATA_WIDTH-1:0]    IN_1    ,
    input   wire                        Sel     ,

    output  wire    [DATA_WIDTH-1:0]    OUT   
*/
    MUX_2x1 PlusOrBranchMUX
    (
        .IN_0   (PCPlus4)               ,
        .IN_1   (PCBranch)              ,
        .Sel    (PCSrc)                 ,

        .OUT    (PlusOrBranchMUX_out) 
    );

    MUX_2x1 JmpMUX
    (
        .IN_0   (PlusOrBranchMUX_out)               ,
        .IN_1   ({PCPlus4[31:28],JmpInstShiftOut})  ,
        .Sel    (Jmp)                               ,
        
        .OUT    (PC_in)                
    );

    MUX_2x1 #(.DATA_WIDTH(5)) WReg_MUX
    (
        .IN_0   (Instruction[20:16])   ,
        .IN_1   (Instruction[15:11])   ,
        .Sel    (RegDst)               ,

        .OUT    (WriteReg)             
    );
    
    MUX_2x1 WData_MUX
    (
        .IN_0   (WriteData)     ,
        .IN_1   (SignImm)       ,
        .Sel    (ALUSrc)        ,

        .OUT    (SrcB)          
    );

    MUX_2x1 WD3_MUX
    (
        .IN_0   (ALUOut)        ,
        .IN_1   (ReadData)      ,
        .Sel    (MemtoReg)      ,

        .OUT    (RegWD3Result)  
    );


/***************************ADDERS***************************/
/*    
    input   wire    [DATA_WIDTH-1:0]  In_A,
    input   wire    [DATA_WIDTH-1:0]  In_B,

    output  wire    [DATA_WIDTH-1:0]  Out
*/
    Adder PC_Plus
    (
        .In_A   (PC)                                    ,
        .In_B   ({{(ADDRESS_WIDTH-3){1'b0}},{3'b100}})  ,

        .Out    (PCPlus4)
    );

    Adder PC_Branch
    (
        .In_A   (SignImmShiftOut)   ,
        .In_B   (PCPlus4)           ,

        .Out    (PCBranch)         
    );
/***************************SHIFTERS***************************/
/*
    input   wire    [DATA_WIDTH-1:0]    IN  ,

    output  wire    [DATA_WIDTH-1:0]    OUT
*/
    ShiftLeftTwice #(.DATA_WIDTH(28)) JmpInstShifter
    (
        .IN     ({2'b00,Instruction[25:0]}) ,
        .OUT    (JmpInstShiftOut)
    );

    ShiftLeftTwice SignImmShifter
    (
        .IN     (SignImm)           ,
        .OUT    (SignImmShiftOut)
    );


/***************************SIGNEXTEND***************************/
/*
    input   wire    [IN_INSTR_WIDTH-1:0]    Inst    ,

    output  wire    [OUT_INSTR_WIDTH-1:0]   SignImm
*/
    SignExtend SignExtender
    (
        .Inst       (Instruction[15:0]) ,
        .SignImm    (SignImm)           
    );


/***************************ALU***************************/
/*
    input   wire    [DATA_WIDTH-1:0]    SrcA        ,
    input   wire    [DATA_WIDTH-1:0]    SrcB        ,
    input   wire    [2:0]               ALUControl  ,

    output  reg     [DATA_WIDTH-1:0]    ALUResult   ,   
    output  wire                        Zero
*/
    ALU ALU0
    (
        .SrcA       (SrcA)          ,
        .SrcB       (SrcB)          ,
        .ALUControl (ALUControl)    ,

        .ALUResult  (ALUOut)        ,
        .Zero       (Zero)          
    );


/***************************ProgramCounter***************************/
/*
    input   wire                        CLK     ,
    input   wire                        rst     ,
    input   wire                        PC_in   ,

    output  reg    [INSTR_WIDTH-1:0]    PC
*/
    ProgramCounter PC0
    (
        .CLK    (CLK)   ,
        .rst    (rst)   ,
        .PC_in  (PC_in) ,

        .PC     (PC)    
    );

endmodule