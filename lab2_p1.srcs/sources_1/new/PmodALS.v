`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ravi Kirschner and Jonathan Lee
// 
// Create Date: 09/09/2019 11:53:13 AM
// Design Name: PmodALS Light Decoder
// Module Name: PmodALS
// Project Name: Light Sensor and VGA Monitor Display 
// Target Devices: Basys 3 & Digilent PmodALS Light Sensor
// Description: This module takes the data from the PmodALS sensor and shifts it into a 16 bit register, which at the end of 16 SCLK cycles is then read
// for the data, and that data is sent back to the seven_seg module. It also takes in an async reset signal, which resets the light sensor data.
// 
//////////////////////////////////////////////////////////////////////////////////


module PmodALS(
    input SDO,
    input SCLK,
    input clk_10Hz,
    input reset,
    output reg [3:0] color1,
    output reg [3:0] color2
    );  
    
    reg [3:0] count; 
    reg [15:0] lightLevel;
    always @ (posedge SCLK, posedge reset)
        if(reset) begin
            count <= 4'b0000;
            lightLevel <= 16'b0; //if reset, remove current counter and light data
        end
        else if(clk_10Hz == 0 && count != 4'b1111) begin
            count <= count + 1'b1; 
            lightLevel = {lightLevel[14:0], SDO};
            //clk_10Hz is just a 10Hz clock, so this counts until 16 cycles of SCLK has passed. In each cycle, the module shifts one bit of light data, SDO, 
            //into lightLevel.
        end
        else if(clk_10Hz == 1) begin
            count <= 4'b0000;
            color1 <= lightLevel[12:9];
            color2 <= lightLevel[8:5];
            //When the clk_10Hz returns to 1, read the light sensor data and send it off to the seven segment display and color logic.
        end
   
endmodule
