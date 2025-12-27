# AES-128-HW-SW-Co-Design-on-SoC-FPGA
A Hardware/Software Co-Design implementation of AES-128 encryption on a Cyclone V SoC FPGA. The system offloads computationally intensive encryption to the FPGA fabric via an AXI Memory-Mapped interface, while the ARM Cortex-A9 HPS handles key generation, user I/O, and validation. 
