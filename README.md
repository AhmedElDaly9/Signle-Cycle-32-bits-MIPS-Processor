# Single-Cycle-32-bit-MIPS-Processor
## Introduction:
The project aims to implement a 32-bit single-cycle MIPS RISC (Reduced Instruction Set Computer) processor based on Harvard architecture using verilog HDL.

![MIPS Architecture](https://user-images.githubusercontent.com/76248514/157418934-4f0b8410-d47a-46b3-9e9e-1b9cb26d3596.png)

## Project parts:
This processer is implemented using four different parts: Datapath, Control unit, Data memory and Instruction memory.
### Top Module:
![MIPS Modules](https://user-images.githubusercontent.com/76248514/157419464-bfe28036-8732-4061-bfd6-741ea0b64957.png)

![MIPS](https://user-images.githubusercontent.com/76248514/157419332-c1170176-9e24-4a7e-b055-22ae56702a3b.png)

#### Datapath block module:
![Data path](https://user-images.githubusercontent.com/76248514/157421381-3bbfd3bb-811a-419a-8f20-5e4e93b10bb2.png)

The processor is simulated on ***ModelSim*** tool, and Synthesis is made using ***Intel® Quartus® Prime*** and also implemented on ***Cyclone® IV FPGA***.

## Reference:
David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture
