# Xilinx-7-Series-FPGAs-Device-DNA
Two VHDL codes, including one for extracting the so called unique Device DNA of Xilinx 7-Series FPGA, and another for utilizing this extracted DNA in order to prevent the project to be cloned and programmed on other FPGA devices.

## Introduction
The 7 series FPGA contains an embedded, device identifier (device DNA). The identifier is nonvolatile, permanently programmed by Xilinx into the FPGA, and is unchangeable making it tamper resistant. Each device is programmed with a DNA value that is most often unique. However, up to 32 devices within the family can contain the same DNA value.[1]

## DNA_Extractor.vhd:
A simple State Machine to Extract and output the Unique Device DNA of a single FPGA.
You can use this module in two different scenarios:
* 1- When you need to find the DNA value for a specific FPGA device of your own.
* 2- When you you want to compare a FPGAs DNA number to your valid DNA numbers in order to check whether the current device is a valid one or not.
     In this case, you must import this module inside the DNA_Evaluation.vhd module.





[1] 7 Series FPGAs Configuration User Guide (UG470) 
