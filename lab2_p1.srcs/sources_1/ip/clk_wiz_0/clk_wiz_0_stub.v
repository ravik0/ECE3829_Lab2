// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Sep  1 13:59:17 2019
// Host        : AK113-01 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               r:/Vivado/ECE3829/lab2_p1/lab2_p1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_25M, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_25M,reset,locked,clk_in1" */;
  output clk_25M;
  input reset;
  output locked;
  input clk_in1;
endmodule
