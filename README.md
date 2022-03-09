# Single-Cycle-32-bit-MIPS-Processor
## Introduction:
The project aims to implement a 32-bit single-cycle MIPS RISC (Reduced Instruction Set Computer) processor based on Harvard architecture using verilog HDL.
The processor is simulated on ***ModelSim*** tool, and Synthesis is made using ***Intel® Quartus® Prime*** and also implemented on ***Cyclone® IV FPGA***.

![MIPS Architecture](https://user-images.githubusercontent.com/76248514/157418934-4f0b8410-d47a-46b3-9e9e-1b9cb26d3596.png)

## Project parts:
This processer is implemented using four different parts: Datapath, Control unit, Data memory and Instruction memory.
### Top Module:
![MIPS Modules](https://user-images.githubusercontent.com/76248514/157419464-bfe28036-8732-4061-bfd6-741ea0b64957.png)

![MIPS](https://user-images.githubusercontent.com/76248514/157419332-c1170176-9e24-4a7e-b055-22ae56702a3b.png)

#### Datapath block module:
![Data path](https://user-images.githubusercontent.com/76248514/157421381-3bbfd3bb-811a-419a-8f20-5e4e93b10bb2.png)


## Simulation results:
The project was tested on four different machine code programs:
#### Program 1: Calculate GCD of 180 and 120
![Program1_test](https://user-images.githubusercontent.com/76248514/157422376-af22d686-11de-4a42-ae33-664ac198d9f0.png)

#### Program 2: Calculate factorial of number 7
![Program2_test](https://user-images.githubusercontent.com/76248514/157422450-85101c51-262b-44d0-99d4-eafa9b11434b.png)

#### Program 3: The program will write the value 7 to address 84 if it runs correctly, and is unlikely to do so if the hardware is buggy (From Reference).
![Program3_test](https://user-images.githubusercontent.com/76248514/157422885-b2a035a4-570b-4b16-bfb6-b9587fde9157.png)

#### Program 4: Outputs the Fibonacci series numbers sequentially
![Program4_test](https://user-images.githubusercontent.com/76248514/157423027-ca7804b6-bf8d-4f77-8f60-b99af8eeef2d.png)


## Reference:
David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture
