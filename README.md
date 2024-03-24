# pwm_multibit_ip

## Introduction
Pulse Width Modulation (PWM) is a widely-used technique for controlling the power delivered to electrical devices, such as motors, LEDs, and heaters. In this tutorial, we'll explore how to design and implement a multi-bit PWM IP core using VHDL (VHSIC Hardware Description Language). We'll cover the basics of PWM, dive into the provided VHDL files, set up a project, simulate the design, synthesize it, and optionally test it on an FPGA board.
Prerequisites
Basic understanding of digital logic and VHDL programming.
Xilinx Vivado or any VHDL synthesis tool installed on your system.
## 1. Understanding PWM Basics
Pulse Width Modulation (PWM) is a technique used to encode information in a pulsing signal. It involves varying the width of pulses while keeping the frequency constant. Note that frequency should be set so that it is not too high (no visible effect) or too low (visible flickering). PWM is commonly used for controlling the speed of motors, brightness of LEDs, and generating analog waveforms.
The ratio of pulse width to the total period is called the duty cycle and is often expressed as a percentage. However, in this tutorial we will be expressing it in terms of resoluton bits R. The duty ranges from 0/2^R  (0%) to 2^R/2^R (100%). please note that the input duty signal should be R + 1 bits to accomodate for the 100% duty.
An appropriate PWM frequency varies with the application, for example it is in case of 10s of kilo hertzs for an LED, and of 1s of Kilo Hertzs for a motor.
To calculate the frequency divisior that steps down the frequency from the FPGA's board oscilator clock to the desired frequency. We use the following equation:
Divisior = (frequency of the fpga) / (2^R) / (desired frequency in khz)
In this example, the Artix 7 fpga has almost a 100Mhz clock; the resolution is chosen at 8 bits; and a relevant frequency for led pwm at 50khz. This yields a divisor value of 7812.
## 2. Exploring the Project Files
__pwm_helper.vhd__: This file contains the helper module for PWM generation.  
__pwm_core.vhd__: This file implements the core PWM functionality.  
__top.vhd__: This is the top-level module that integrates the PWM core into a complete design.  
__Basys-3-Master.xdc__: This is the constraint file, which maps the design into our Basys 3 board.  
You can find all the project files in the github repo below.
## 3. Setting Up the Project
Open Xilinx Vivado or your preferred synthesis tool.
Create a new project and add the provided VHDL files to it.
## 4. Understanding the VHDL Code
__pwm_helper.vhd__:  This module provides the basic PWM functionality, including duty cycle calculation and output generation.  
__pwm_core.vhd__:    The core PWM module handles resolution, duty cycle setting, and PWM signal generation, it includes an address signal addr which specifies PWM duty register of the output signals to write to.  
__pwm_core.vhd__:    This top-level module connects the PWM core to external signals and interfaces, all you need to do is to specify the number of resolution bits R, the divisor DVSR, and the width of the output signal W inside the generic map.  
## 5. Simulating The Design
Before playing with the design, you should make sure to include the constraints file. In my case here with the basys 3 board, I have specified the the first 9 switches (8 to 0) to be the duty resolution bits, and the upper 4 switches (15 to 12) as the address signals. when you finish uploading all of these files to your project, click Generate Bitstream and let vivado go through all the implementation pipeline automatically. Once you generat the bitsteam, connect your fpga board and hit Program Device.
Here is a video of me playing with the project.    
[![](https://img.youtube.com/vi/VTcqhlPA_Ls/0.jpg)](https://www.youtube.com/watch?v=VTcqhlPA_Ls)

## Project Files
Please don't forget to star the github repo if you found it useful also follow me on hackster for more VHDL IP cores projects coming soon.
__for vhdl files:__ pwm.srcs/sources_1/new   
__for the constraint file:__ pwm.srcs/constrs_1/imports/Desktop
