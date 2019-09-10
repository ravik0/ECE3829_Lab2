`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ravi Kirschner and Jonathan Lee
// 
// Create Date: 09/01/2019 02:34:44 PM
// Design Name: Lab 2 Top File
// Module Name: lab2_p1_top
// Project Name: Light Sensor and VGA Monitor Display 
// Target Devices: Basys 3
// Description: This module is the top module for all of Lab 2. It takes in the 100MHz clock, a reset signal, two switch signals, light sensor data, and a button
// input, and outputs a lock_led signal, the VGA RGB signals, hsync/vsync signals, chip select & SCLK for the kight sensor, and SEG/ANODE for the seven segment display.
//  
//////////////////////////////////////////////////////////////////////////////////


module lab2_p1_top(
    input clk,
    input reset,
    input [1:0] sw,
    input SDO,
    input Button,
    output lock_led,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output hSync,
    output vSync,
    output CS,
    output SCLK,
    output [6:0] SEG,
    output [3:0] ANODE
    );
    
     //1MHZ CLK SECTION - Slows down 100MHz clock to 1MHz
    reg clk_1M;
    reg [5:0] counter1; //6 bit bus to hold up to 50, 2^6 = 64, 64 > 50.
    always @ (posedge clk)
        begin
            if(counter1 == 50-1) 
                begin
                    counter1 <= 0;
                    clk_1M <= clk_1M == 1 ? 0 : 1;
                    //required to be 50 rather than 100 because we want to create a square wave rather than pulses.
                    //if we divide the 100MHz by 100 but keep code above we get a 500kHz signal. Same is true for 10Hz.
                end
            else
                begin
                    counter1 <= counter1 + 1'b1;
                end
        end
        
    //10Hz CLK SECTION - Slows down 100MHz clock to 10Hz.
    reg clk_10Hz;
    reg [23:0] counter10; //24 bit bus to hold up to 5000000, 2^24 = 16777216, 16777216 > 5000000.
    always @ (posedge clk)
        begin
            if(counter10 == 5000000-1) 
                begin
                    counter10 <= 0;
                    clk_10Hz <= clk_10Hz == 1 ? 0 : 1;
                    //See 1MHZ CLK SECTION comments to understand why we divided by 5000000 instead of 10000000. 
                end
            else
                begin
                    counter10 <= counter10 + 1'b1;
                end
        end
        
    wire clk_25MHz; //25MHz clock
    wire blank; //blank signal from VGA controller
    wire [10:0] hCount; //current horizontal pixel location on the screen
    wire [10:0] vCount; //current vertical pixel location on the screen
    wire [3:0] A; //Light sensor value LSB
    wire [3:0] B; //Light sensor value MSB
    dcm u1(.clk_fpga(clk), .reset(reset), .lock_led(lock_led), .clk25(clk_25MHz));
    vga_controller_640_60 u2(.rst(reset), .pixel_clk(clk_25MHz), .HS(hSync), .VS(vSync), .hcount(hCount), .vcount(vCount), .blank(blank));
    //VGA controller takes in a reset signal (to redraw the screen), a 25MHz clock, and outputs hSync/vSync signals, as well as outputs the current
    //vertical and horizontal pixel location that it's working on. It also outputs blank, which says if the pixel it is working on is off the screen
    //or not. Description written here as can't write in VGA controller module. 
    color_logic(.sel(sw), .hcount(hCount), .A(A), .B(B), .vcount(vCount), .blank(blank), .red(vgaRed), .blue(vgaBlue), .green(vgaGreen), .Button(Button));
    PmodALS(.SDO(SDO), .color1(A), .color2(B), .SCLK(clk_1M), .clk_10Hz(clk_10Hz), .reset(reset));
    seven_seg(.clk(clk_25MHz), .A(A), .B(B), .C(4'b0000), .D(4'b0000), .SEG(SEG), .ANODE(ANODE)); //pass in 0 for C and D as those segments are off.
    assign SCLK = clk_1M;
    assign CS = clk_10Hz; //assigning the CS and SCLK to the correct signals
   
endmodule
