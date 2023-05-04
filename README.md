This is a project for the course **Computer Architecture**. The goal was to run a **Sorting Algorithm** on a **RISC-V Pipelined Processor**. The following bullet points elucidate each task:
- Choose a suitable sorting algorithm. Convert its pseudocode to assembly using RISC-V
instruction set and test its working on the assembly code simulator. Now, modify the existing lab 11
single-cycle processor architecture to run the sorting algorithm code on it. Test and verify that it is doing
the sorting correctly.
- Modify this processor to make it a pipelined one (5 stages). Test and run each instruction
separately to verify that the pipelined processor version can at least execute one instruction correctly in
isolation. Test different types of instructions. Test cases matter!
- Introduce circuitry to detect hazards (data, control, and structural if needed) and try to handle
them in hardware i.e., by forwarding, stalling and flushing the pipeline. If this is done correctly, then
your array sorting code should be able to function in its entirety
- Compare the performance of running the array sorting program on Single Cycle Processor with RISC-V Pipelined Processor in terms of execution time.
