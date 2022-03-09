/********************************************************************/
/* Module Name: InstructionMemory                                   */
/* Module Function:                                                 */
/*  Instruction memory is the ROM which contains the instructions   */
/*  to be fetched next using the program counter signal coming from */
/*  the Data path.                                                  */
/********************************************************************/
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
            $readmemh("Test cases/Program 4_Machine Code.txt",ROM) ;
        end

    assign  OutReadData = ROM [InstrAddress >> 2]   ;
        
endmodule