# AES-128 HW/SW Co-Design on SoC FPGA

## Project Overview
This project implements a complete Hardware/Software Co-Design system for **AES-128 Encryption** using an SoC FPGA (System on Chip). The design leverages the **ARM Cortex-A9 HPS (Hard Processor System)** for control and validation, while offloading the computationally intensive encryption task to the **FPGA fabric** to achieve high performance and flexibility.

Developed at the **University of Texas at Dallas** for the course *Design and Analysis of Reconfigurable Systems (EEDG/CE 6370)*.

**Project Date:** Fall 2025  
**Supervisor:** Prof. Dr. Benjamin Carrion Schaefer  
**Authors:**
* Aryan Verma

## System Architecture
The system architecture consists of three main components:
1.  **HPS (Processor):** * Handles user input via terminal (up to 16 ASCII characters).
    * Generates the 128-bit Encryption Key.
    * Performs software-based decryption for validation (Golden Reference).
2.  **FPGA Fabric:** * Hosts the custom AES-128 Encryption Accelerator.
    * Implements the logic using RTL (Verilog).
3.  **AXI Interface:** * Communication between HPS and FPGA is achieved using a **Memory-Mapped AXI interface** (Lightweight HPS-to-FPGA bridge).
    * Control signals ensure synchronization.

## Resource Utilization
The FPGA implementation yielded the following resource usage:
* **Logic Utilization (ALMs):** 15,701 (49%)
* **Registers:** 8,400
* **Fmax:** 24.64 MHz

## Directory Structure
* `sw/`: Contains the C source code running on the ARM HPS (Linux).
* `hw/`: Contains the Verilog RTL for the AES accelerator and Qsys wrappers.
* `docs/`: Project documentation and presentation slides.

## How to Run
1.  **FPGA Configuration:**
    * Compile the hardware design in **Intel Quartus Prime**.
    * Program the FPGA with the generated `.sof` file.
2.  **Software Execution:**
    * Boot Linux on the SoC FPGA.
    * Compile the software: `gcc main.c -o aes_demo`
    * Run the executable: `./aes_demo`
3.  **Operation:**
    * Enter plaintext when prompted.
    * The system will display the Key, Original Plaintext, Hardware Ciphertext, and Validation results.

## References
* Course Materials: EEDG/CE 6370, UTD.
* Intel SoC FPGA Embedded Design Suite (EDS) User Guide.
