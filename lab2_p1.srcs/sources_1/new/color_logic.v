`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ravi Kirschner and Jonathan Lee
// 
// Create Date: 09/03/2019 09:22:45 AM
// Design Name: Color Logic
// Module Name: color_logic
// Project Name: Light Sensor and VGA Monitor Display 
// Target Devices: Basys 3
// Description: This module deals with decoding the hcount and vcount locations into RGB values depending on the selected mode. It then outputs them as red, green, and blue
// signals, which are then sent to the monitor through the onboard VGA connector. Blank is the signal that lets color logic know that the pixel is currently not on the
// screen. A, B, and Button are used to display the light sensor data on the monitor. When Button is pressed and mode 00 is selected (blue screen), A and B are displayed
// in seven-segment graphics on the screen. A is the light value LSB, so on the left, and B is the light value MSB, so on the right of the screen.
// 
//////////////////////////////////////////////////////////////////////////////////


module color_logic(
    input [1:0] sel,
    input [10:0] hcount,
    input [10:0] vcount,
    input blank,
    input [3:0] A,
    input [3:0] B,
    input Button,
    output reg [3:0] red,
    output reg [3:0] blue,
    output reg [3:0] green
    );

    wire redOrYellow = vcount[4]; //for mode 01 (horizontal red/yellow stripes), tells logic whether stripe should be red or yellow. 1 for yellow, 0 for red.
    wire [6:0] SEG1; 
    wire [6:0] SEG2;
    seg_decoder(.chosenSwitches(A), .SEG(SEG1));
    seg_decoder(.chosenSwitches(B), .SEG(SEG2));
    //this set of lines takes A and B and decodes them into seven-segment logic, with 0 being segment is activated and 1 being deactivated.

    always @ (sel) 
        begin
            if(sel == 2'b00) //full blue screen
                begin
                    red = 4'b0000;
                    blue = blank ? 4'b0000 : 4'b1111;
                    green = 4'b0000; //red & green always off, blue is always blue unless blank
                    if(Button == 1) begin //display is white, so if the condition is met all RGB is full ones, so produce white pixels.
                        //LSB DISPLAY
                        if(vcount >= 232 && vcount <= 248 && hcount >= 412 && hcount <= 444 && SEG1[6] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111; 
                        end //CA
                        if(vcount >= 248 && vcount <= 280 && hcount >= 396 && hcount <= 412 && SEG1[1] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CF
                        if(vcount >= 296 && vcount <= 328 && hcount >= 396 && hcount <= 412 && SEG1[2] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CE
                        if(vcount >= 248 && vcount <= 280 && hcount >= 444 && hcount <= 460 && SEG1[5] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CB
                        if(vcount >= 296 && vcount <= 328 && hcount >= 444 && hcount <= 460 && SEG1[4] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CC
                        if(vcount >= 328 && vcount <= 344 && hcount >= 412 && hcount <= 444 && SEG1[3] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CD
                        if(vcount >= 280 && vcount <= 296 &&hcount >= 412 && hcount <= 444 && SEG1[0] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CG
                        //CA, CB, ..., CG, refer to the pinout of the seven segment display on the board.
                        //MSB DISPLAY
                        if(vcount >= 232 && vcount <= 248 && hcount >= 212 && hcount <= 244 && SEG2[6] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CA
                        if(vcount >= 248 && vcount <= 280 && hcount >= 196 && hcount <= 212 && SEG2[1] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CF
                        if(vcount >= 296 && vcount <= 328 && hcount >= 196 && hcount <= 212 && SEG2[2] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CE
                        if(vcount >= 248 && vcount <= 280 && hcount >= 244 && hcount <= 260 && SEG2[5] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CB
                        if(vcount >= 296 && vcount <= 328 && hcount >= 244 && hcount <= 260 && SEG2[4] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CC
                        if(vcount >= 328 && vcount <= 344 && hcount >= 212 && hcount <= 244 && SEG2[3] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CD
                        if(vcount >= 280 && vcount <= 296 &&hcount >= 212 && hcount <= 244 && SEG2[0] == 0) begin
                            blue = blank ? 4'b0000 : 4'b1111;
                            green = blank ? 4'b0000 : 4'b1111;
                            red = blank ? 4'b0000 : 4'b1111;
                        end //CG
                    end
                end
            else if(sel == 2'b01) //horizontal lines of red/yellow
                begin
                    red = blank ? 4'b0000 : 4'b1111; //always red unless blank 
                    blue = 4'b0000; 
                    green = blank ? 4'b0000 :
                    redOrYellow ? 4'b1111 : 4'b0000; //only turns on green if its yellow and not blank, as green + red = yellow.
                end
            else if(sel == 2'b10) //black screen white box, bottom left
                begin
                    red = blank ? 4'b0000 : 
                    (vcount >= 415 && hcount <= 63) ? 4'b1111 : 4'b0000; 
                    blue = blank ? 4'b0000 : 
                    (vcount >= 415 && hcount <= 63) ? 4'b1111 : 4'b0000;
                    green = blank ? 4'b0000 : 
                    (vcount >= 415 && hcount <= 63) ? 4'b1111 : 4'b0000;
                    //only turns on if the vcount & hcount are in the bottom left of the screen
                end
            else //black screen green box, top right
                begin
                    red = blank ? 4'b0000 : 
                    (vcount <= 63 && hcount >= 575) ? 4'b0000 : 4'b0000;
                    blue = blank ? 4'b0000 : 
                    (vcount <= 63 && hcount >= 575) ? 4'b0000 : 4'b0000;
                    green = blank ? 4'b0000 : 
                    (vcount <= 63 && hcount >= 575) ? 4'b1111 : 4'b0000;
                    //only turns on if the vcount & hcount are in the top right of the screen
                    //although blue & red are never used, logic is left incase the color should be changed.
                end
        end
    
endmodule
