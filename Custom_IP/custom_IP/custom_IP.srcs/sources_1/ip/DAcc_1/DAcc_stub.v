// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Fri Sep  2 15:02:01 2022
// Host        : diomedes running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/aamalik3/Desktop/GitHub/Scheduling-PR/Custom_IP/custom_IP/custom_IP.srcs/sources_1/ip/DAcc_1/DAcc_stub.v
// Design      : DAcc
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "floating_point_v7_1_5,Vivado 2017.4" *)
module DAcc(aclk, aclken, aresetn, s_axis_a_tvalid, 
  s_axis_a_tdata, s_axis_a_tlast, m_axis_result_tvalid, m_axis_result_tdata, 
  m_axis_result_tlast)
/* synthesis syn_black_box black_box_pad_pin="aclk,aclken,aresetn,s_axis_a_tvalid,s_axis_a_tdata[63:0],s_axis_a_tlast,m_axis_result_tvalid,m_axis_result_tdata[63:0],m_axis_result_tlast" */;
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_a_tvalid;
  input [63:0]s_axis_a_tdata;
  input s_axis_a_tlast;
  output m_axis_result_tvalid;
  output [63:0]m_axis_result_tdata;
  output m_axis_result_tlast;
endmodule
