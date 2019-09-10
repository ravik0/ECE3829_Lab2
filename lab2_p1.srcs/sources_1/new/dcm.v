`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ravi Kirschner and Jonathan Lee
// 
// Create Date: 09/01/2019 01:48:46 PM
// Design Name: 25MHz MMCM Clock Generator
// Module Name: dcm
// Project Name: Light Sensor and VGA Monitor Display 
// Target Devices: Basys 3
// Description: Generates a 25MHz clock using the onboard MMCM. Takes in the 100MHz clock signal from the FPGA as well as a reset signal, outputs a lock signal and 
// the 25MHz signal.
// 
//////////////////////////////////////////////////////////////////////////////////


module dcm(
    input clk_fpga,
    input reset,
    output lock_led,
    output clk25
    );
    
    wire clk_25M;
    
    
      clk_wiz_0 mmcm_inst
      (
      // Clock out ports  
      .clk_25M(clk_25M),
      // Status and control signals               
      .reset(reset), 
      .locked(lock_led),
     // Clock in ports
      .clk_in1(clk_fpga)
      );
    
    assign clk25 = clk_25M;
        
endmodule
