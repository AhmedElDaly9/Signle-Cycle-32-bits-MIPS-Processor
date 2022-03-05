module MIPS #
(
    parameter   ADDRESS_WIDTH   =   32  ,
    parameter   DATA_WIDTH      =   32  
) 
(
    input   wire                            CLK         ,
    input   wire                            rst         ,

    output  wire    [(DATA_WIDTH/2)-1:0]    testValue
);

/***************************INTERNAL SIGNALS***************************/

    wire    [ADDRESS_WIDTH-1:0]   Instr     ;
    wire    [ADDRESS_WIDTH-1:0]   PC        ;

    wire    [DATA_WIDTH-1:0]      ALUOut    ;
    wire    [DATA_WIDTH-1:0]      WriteData ;
    wire    [DATA_WIDTH-1:0]      ReadData  ;

    wire    [2:0]               ALUControl  ;
    wire                        Jmp         ;
    wire                        Zero        ;
    wire                        PCSrc       ;
    wire                        MemtoReg    ;
    wire                        ALUSrc      ;
    wire                        RegDst      ;
    wire                        RegWrite    ;
    wire                        MemWrite    ;

/***************************CONTROL UNIT***************************/
/*
    input   wire    [INSTR_WIDTH:0]     Instruction ,
    input   wire                        Zero        ,

    output  reg                         Jmp         ,
    output  reg                         MemtoReg    ,
    output  reg                         MemWrite    ,
    output  reg                         ALUSrc      ,
    output  reg                         RegDst      ,
    output  reg                         RegWrite    ,
    output  reg     [2:0]               ALUControl  ,
    output  wire                        PCSrc
*/
    ControlUnit CTRLUNIT0
    (
        .Instruction    (Instr)     ,
        .Zero           (Zero)      ,

        .Jmp            (Jmp)       ,
        .MemtoReg       (MemtoReg)  ,
        .MemWrite       (MemWrite)  ,
        .ALUSrc         (ALUSrc)    ,
        .RegDst         (RegDst)    ,
        .RegWrite       (RegWrite)  ,
        .ALUControl     (ALUControl),
        .PCSrc          (PCSrc)
    );


/***************************DATA PATH***************************/
/*
    input   wire    [INSTR_WIDTH-1:0]   Instruction ,
    input   wire    [DATA_WIDTH-1:0]    Data        ,
    input   wire    [2:0]               ALUControl  ,
    input   wire                        PCSrc       ,
    input   wire                        Jmp         ,
    input   wire                        MemtoReg    ,
    input   wire                        ALUSrc      ,
    input   wire                        RegDst      ,
    input   wire                        RegWrite    ,
    input   wire                        CLK         ,
    input   wire                        rst         ,

    output  wire                        Zero        ,
    output  wire                        ALUOut      ,
    output  wire                        WriteData   
*/
    Datapath Datapath0
    (
        .Instruction    (Instr)     ,
        .Data           (ReadData)  ,
        .ALUControl     (ALUControl),
        .PCSrc          (PCSrc)     ,
        .Jmp            (Jmp)       ,
        .MemtoReg       (MemtoReg)  ,
        .ALUSrc         (ALUSrc)    ,
        .RegDst         (RegDst)    ,
        .RegWrite       (RegWrite)  ,
        .CLK            (CLK)       ,
        .rst            (rst)       ,

        .Zero           (Zero)      ,
        .ALUOut         (ALUOut)    ,
        .WriteData      (WriteData) 
    );


/***************************INSTRUCTION MEMORY**************************/
/*
    input   wire    [ADDRESS_WIDTH-1:0]     InstrAddress    ,

    output  wire    [INSTR_WIDTH-1:0]       OutReadData
*/
    InstructionMemory InstrMem0
    (
        .InstrAddress   (PC)    ,
        
        .OutReadData    (Instr)
    );


/***************************DATA MEMORY**************************/
/*
    input   wire    [ADDRESS_WIDTH-1:0]     DataAddress ,
    input   wire    [MEM_WIDTH-1:0]         WD          ,
    input   wire                            WEN         ,
    input   wire                            CLK         ,
    input   wire                            rst         ,

    output  wire    [MEM_WIDTH-1:0]         RD          ,
    output  wire    [(MEM_WIDTH/2)-1:0]     testValue
*/
    DataMemory DataMem0
    (
        .DataAddress    (ALUOut)    ,
        .WD             (WriteData) ,
        .WEN            (MemWrite)  ,
        .CLK            (CLK)       ,
        .rst            (rst)       ,

        .RD              (ReadData) ,
        .testValue       (testValue)
    );

endmodule