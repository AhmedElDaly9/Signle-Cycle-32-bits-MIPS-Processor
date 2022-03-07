module InstructionMemory #
(
    parameter   INSTR_WIDTH     =   32  ,
    parameter   ADDRESS_WIDTH   =   32  ,
    parameter   MEM_DEPTH       =   100
) 
(
    input   wire    [ADDRESS_WIDTH-1:0]     InstrAddress    ,

    output  wire    [INSTR_WIDTH-1:0]       OutReadData
);
    
    reg     [INSTR_WIDTH-1:0]   ROM     [MEM_DEPTH-1:0]     ;

    initial
        begin
            $readmemh("Program 2_Machine Code.txt",ROM) ;
        end

    assign  OutReadData = ROM [InstrAddress >> 2]   ;
        
endmodule