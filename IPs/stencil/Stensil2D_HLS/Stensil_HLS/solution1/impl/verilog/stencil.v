// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="stencil_stencil,hls_ip_2020_2,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg484-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.742000,HLS_SYN_LAT=70322,HLS_SYN_TPT=none,HLS_SYN_MEM=34,HLS_SYN_DSP=0,HLS_SYN_FF=1142,HLS_SYN_LUT=1175,HLS_VERSION=2020_2}" *)

module stencil (
        ap_clk,
        ap_rst_n,
        s_axi_BUS_A_AWVALID,
        s_axi_BUS_A_AWREADY,
        s_axi_BUS_A_AWADDR,
        s_axi_BUS_A_WVALID,
        s_axi_BUS_A_WREADY,
        s_axi_BUS_A_WDATA,
        s_axi_BUS_A_WSTRB,
        s_axi_BUS_A_ARVALID,
        s_axi_BUS_A_ARREADY,
        s_axi_BUS_A_ARADDR,
        s_axi_BUS_A_RVALID,
        s_axi_BUS_A_RREADY,
        s_axi_BUS_A_RDATA,
        s_axi_BUS_A_RRESP,
        s_axi_BUS_A_BVALID,
        s_axi_BUS_A_BREADY,
        s_axi_BUS_A_BRESP,
        interrupt
);

parameter    ap_ST_fsm_state1 = 20'd1;
parameter    ap_ST_fsm_state2 = 20'd2;
parameter    ap_ST_fsm_state3 = 20'd4;
parameter    ap_ST_fsm_state4 = 20'd8;
parameter    ap_ST_fsm_state5 = 20'd16;
parameter    ap_ST_fsm_state6 = 20'd32;
parameter    ap_ST_fsm_state7 = 20'd64;
parameter    ap_ST_fsm_state8 = 20'd128;
parameter    ap_ST_fsm_state9 = 20'd256;
parameter    ap_ST_fsm_state10 = 20'd512;
parameter    ap_ST_fsm_pp0_stage0 = 20'd1024;
parameter    ap_ST_fsm_pp0_stage1 = 20'd2048;
parameter    ap_ST_fsm_pp0_stage2 = 20'd4096;
parameter    ap_ST_fsm_pp0_stage3 = 20'd8192;
parameter    ap_ST_fsm_pp0_stage4 = 20'd16384;
parameter    ap_ST_fsm_pp0_stage5 = 20'd32768;
parameter    ap_ST_fsm_pp0_stage6 = 20'd65536;
parameter    ap_ST_fsm_pp0_stage7 = 20'd131072;
parameter    ap_ST_fsm_pp0_stage8 = 20'd262144;
parameter    ap_ST_fsm_state24 = 20'd524288;
parameter    C_S_AXI_BUS_A_DATA_WIDTH = 32;
parameter    C_S_AXI_BUS_A_ADDR_WIDTH = 17;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_BUS_A_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
input   s_axi_BUS_A_AWVALID;
output   s_axi_BUS_A_AWREADY;
input  [C_S_AXI_BUS_A_ADDR_WIDTH - 1:0] s_axi_BUS_A_AWADDR;
input   s_axi_BUS_A_WVALID;
output   s_axi_BUS_A_WREADY;
input  [C_S_AXI_BUS_A_DATA_WIDTH - 1:0] s_axi_BUS_A_WDATA;
input  [C_S_AXI_BUS_A_WSTRB_WIDTH - 1:0] s_axi_BUS_A_WSTRB;
input   s_axi_BUS_A_ARVALID;
output   s_axi_BUS_A_ARREADY;
input  [C_S_AXI_BUS_A_ADDR_WIDTH - 1:0] s_axi_BUS_A_ARADDR;
output   s_axi_BUS_A_RVALID;
input   s_axi_BUS_A_RREADY;
output  [C_S_AXI_BUS_A_DATA_WIDTH - 1:0] s_axi_BUS_A_RDATA;
output  [1:0] s_axi_BUS_A_RRESP;
output   s_axi_BUS_A_BVALID;
input   s_axi_BUS_A_BREADY;
output  [1:0] s_axi_BUS_A_BRESP;
output   interrupt;

 reg    ap_rst_n_inv;
wire    ap_start;
reg    ap_done;
reg    ap_idle;
(* fsm_encoding = "none" *) reg   [19:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_ready;
reg   [12:0] orig_address0;
reg    orig_ce0;
wire   [31:0] orig_q0;
wire   [12:0] sol_address0;
reg    sol_ce0;
reg    sol_we0;
wire   [31:0] sol_d0;
reg   [3:0] filter_address0;
reg    filter_ce0;
wire   [31:0] filter_q0;
reg   [12:0] indvar_flatten_reg_272;
reg   [6:0] r_reg_283;
reg   [5:0] c_reg_295;
reg  signed [31:0] reg_306;
wire    ap_CS_fsm_pp0_stage1;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_state12_pp0_stage1_iter0;
wire    ap_block_state21_pp0_stage1_iter1;
wire    ap_block_pp0_stage1_11001;
reg   [0:0] icmp_ln13_reg_653;
wire    ap_CS_fsm_pp0_stage2;
wire    ap_block_state13_pp0_stage2_iter0;
wire    ap_block_state22_pp0_stage2_iter1;
wire    ap_block_pp0_stage2_11001;
wire    ap_CS_fsm_pp0_stage3;
wire    ap_block_state14_pp0_stage3_iter0;
wire    ap_block_state23_pp0_stage3_iter1;
wire    ap_block_pp0_stage3_11001;
wire    ap_CS_fsm_pp0_stage4;
wire    ap_block_state15_pp0_stage4_iter0;
wire    ap_block_pp0_stage4_11001;
wire    ap_CS_fsm_pp0_stage5;
wire    ap_block_state16_pp0_stage5_iter0;
wire    ap_block_pp0_stage5_11001;
wire    ap_CS_fsm_pp0_stage6;
wire    ap_block_state17_pp0_stage6_iter0;
wire    ap_block_pp0_stage6_11001;
wire    ap_CS_fsm_pp0_stage7;
wire    ap_block_state18_pp0_stage7_iter0;
wire    ap_block_pp0_stage7_11001;
wire    ap_CS_fsm_pp0_stage8;
wire    ap_block_state19_pp0_stage8_iter0;
wire    ap_block_pp0_stage8_11001;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_state11_pp0_stage0_iter0;
wire    ap_block_state20_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_11001;
reg  signed [31:0] filter_load_reg_563;
wire    ap_CS_fsm_state2;
reg  signed [31:0] filter_load_1_reg_573;
wire    ap_CS_fsm_state3;
reg  signed [31:0] filter_load_2_reg_583;
wire    ap_CS_fsm_state4;
reg  signed [31:0] filter_load_3_reg_593;
wire    ap_CS_fsm_state5;
reg  signed [31:0] filter_load_4_reg_603;
wire    ap_CS_fsm_state6;
reg  signed [31:0] filter_load_5_reg_613;
wire    ap_CS_fsm_state7;
reg  signed [31:0] filter_load_6_reg_623;
wire    ap_CS_fsm_state8;
reg  signed [31:0] filter_load_7_reg_633;
wire    ap_CS_fsm_state9;
reg  signed [31:0] filter_load_8_reg_643;
wire    ap_CS_fsm_state10;
wire   [12:0] add_ln13_fu_310_p2;
reg   [12:0] add_ln13_reg_648;
wire   [0:0] icmp_ln13_fu_316_p2;
reg   [0:0] icmp_ln13_reg_653_pp0_iter1_reg;
wire   [0:0] icmp_ln14_fu_322_p2;
reg   [0:0] icmp_ln14_reg_657;
wire   [5:0] select_ln10_fu_328_p3;
reg   [5:0] select_ln10_reg_663;
wire   [6:0] empty_13_fu_336_p2;
reg   [6:0] empty_13_reg_670;
wire   [6:0] select_ln13_fu_342_p3;
reg   [6:0] select_ln13_reg_675;
wire   [12:0] add_ln_fu_350_p3;
reg   [12:0] add_ln_reg_680;
wire   [63:0] zext_ln18_fu_358_p1;
reg   [63:0] zext_ln18_reg_686;
reg   [63:0] zext_ln18_reg_686_pp0_iter1_reg;
wire   [31:0] mul_ln18_fu_373_p2;
reg   [31:0] mul_ln18_reg_701;
wire   [6:0] add_ln10_fu_407_p2;
reg   [6:0] add_ln10_reg_711;
wire   [31:0] mul_ln18_1_fu_413_p2;
reg   [31:0] mul_ln18_1_reg_716;
wire   [12:0] add_ln18_3_fu_418_p3;
reg   [12:0] add_ln18_3_reg_721;
wire   [31:0] mul_ln18_2_fu_430_p2;
reg   [31:0] mul_ln18_2_reg_732;
wire   [31:0] add_ln19_fu_445_p2;
reg   [31:0] add_ln19_reg_742;
wire   [31:0] mul_ln18_3_fu_449_p2;
reg   [31:0] mul_ln18_3_reg_747;
wire   [31:0] mul_ln18_4_fu_464_p2;
reg   [31:0] mul_ln18_4_reg_757;
wire   [12:0] add_ln18_6_fu_469_p3;
reg   [12:0] add_ln18_6_reg_762;
wire   [31:0] add_ln19_1_fu_480_p2;
reg   [31:0] add_ln19_1_reg_773;
wire   [31:0] mul_ln18_5_fu_484_p2;
reg   [31:0] mul_ln18_5_reg_778;
wire   [31:0] mul_ln18_6_fu_499_p2;
reg   [31:0] mul_ln18_6_reg_788;
wire   [5:0] add_ln14_fu_514_p2;
reg   [5:0] add_ln14_reg_798;
wire   [31:0] mul_ln18_7_fu_519_p2;
reg   [31:0] mul_ln18_7_reg_803;
wire   [31:0] mul_ln18_8_fu_524_p2;
reg   [31:0] mul_ln18_8_reg_808;
wire   [31:0] add_ln19_6_fu_542_p2;
reg   [31:0] add_ln19_6_reg_813;
wire    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state11;
wire    ap_block_pp0_stage8_subdone;
wire    ap_block_pp0_stage3_subdone;
reg   [12:0] ap_phi_mux_indvar_flatten_phi_fu_276_p4;
wire    ap_block_pp0_stage0;
reg   [6:0] ap_phi_mux_r_phi_fu_287_p4;
reg   [5:0] ap_phi_mux_c_phi_fu_299_p4;
wire   [63:0] zext_ln18_1_fu_368_p1;
wire    ap_block_pp0_stage1;
wire   [63:0] zext_ln18_2_fu_383_p1;
wire    ap_block_pp0_stage2;
wire   [63:0] zext_ln18_3_fu_425_p1;
wire    ap_block_pp0_stage3;
wire   [63:0] zext_ln18_4_fu_440_p1;
wire    ap_block_pp0_stage4;
wire   [63:0] zext_ln18_5_fu_459_p1;
wire    ap_block_pp0_stage5;
wire   [63:0] zext_ln18_6_fu_475_p1;
wire    ap_block_pp0_stage6;
wire   [63:0] zext_ln18_7_fu_494_p1;
wire    ap_block_pp0_stage7;
wire   [63:0] zext_ln18_8_fu_509_p1;
wire    ap_block_pp0_stage8;
wire   [12:0] add_ln18_fu_363_p2;
wire   [12:0] add_ln18_1_fu_378_p2;
wire   [6:0] p_mid1_fu_388_p2;
wire   [6:0] select_ln10_2_fu_400_p3;
wire   [6:0] select_ln10_1_fu_394_p3;
wire   [12:0] add_ln18_2_fu_435_p2;
wire   [12:0] add_ln18_4_fu_454_p2;
wire   [12:0] add_ln18_5_fu_489_p2;
wire   [12:0] add_ln18_7_fu_504_p2;
wire   [31:0] add_ln19_4_fu_533_p2;
wire   [31:0] add_ln19_5_fu_537_p2;
wire   [31:0] add_ln19_3_fu_529_p2;
wire   [31:0] add_ln19_2_fu_548_p2;
wire    ap_CS_fsm_state24;
reg   [19:0] ap_NS_fsm;
wire    ap_block_pp0_stage1_subdone;
wire    ap_block_pp0_stage2_subdone;
wire    ap_block_pp0_stage4_subdone;
wire    ap_block_pp0_stage5_subdone;
wire    ap_block_pp0_stage6_subdone;
wire    ap_block_pp0_stage7_subdone;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 20'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

stencil_BUS_A_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_BUS_A_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_BUS_A_DATA_WIDTH ))
BUS_A_s_axi_U(
    .AWVALID(s_axi_BUS_A_AWVALID),
    .AWREADY(s_axi_BUS_A_AWREADY),
    .AWADDR(s_axi_BUS_A_AWADDR),
    .WVALID(s_axi_BUS_A_WVALID),
    .WREADY(s_axi_BUS_A_WREADY),
    .WDATA(s_axi_BUS_A_WDATA),
    .WSTRB(s_axi_BUS_A_WSTRB),
    .ARVALID(s_axi_BUS_A_ARVALID),
    .ARREADY(s_axi_BUS_A_ARREADY),
    .ARADDR(s_axi_BUS_A_ARADDR),
    .RVALID(s_axi_BUS_A_RVALID),
    .RREADY(s_axi_BUS_A_RREADY),
    .RDATA(s_axi_BUS_A_RDATA),
    .RRESP(s_axi_BUS_A_RRESP),
    .BVALID(s_axi_BUS_A_BVALID),
    .BREADY(s_axi_BUS_A_BREADY),
    .BRESP(s_axi_BUS_A_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .filter_address0(filter_address0),
    .filter_ce0(filter_ce0),
    .filter_q0(filter_q0),
    .orig_address0(orig_address0),
    .orig_ce0(orig_ce0),
    .orig_q0(orig_q0),
    .sol_address0(sol_address0),
    .sol_ce0(sol_ce0),
    .sol_we0(sol_we0),
    .sol_d0(sol_d0),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U1(
    .din0(reg_306),
    .din1(filter_load_reg_563),
    .dout(mul_ln18_fu_373_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U2(
    .din0(reg_306),
    .din1(filter_load_1_reg_573),
    .dout(mul_ln18_1_fu_413_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U3(
    .din0(reg_306),
    .din1(filter_load_2_reg_583),
    .dout(mul_ln18_2_fu_430_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U4(
    .din0(reg_306),
    .din1(filter_load_3_reg_593),
    .dout(mul_ln18_3_fu_449_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U5(
    .din0(reg_306),
    .din1(filter_load_4_reg_603),
    .dout(mul_ln18_4_fu_464_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U6(
    .din0(reg_306),
    .din1(filter_load_5_reg_613),
    .dout(mul_ln18_5_fu_484_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U7(
    .din0(reg_306),
    .din1(filter_load_6_reg_623),
    .dout(mul_ln18_6_fu_499_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U8(
    .din0(reg_306),
    .din1(filter_load_7_reg_633),
    .dout(mul_ln18_7_fu_519_p2)
);

stencil_mul_32s_32s_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_1_1_U9(
    .din0(reg_306),
    .din1(filter_load_8_reg_643),
    .dout(mul_ln18_8_fu_524_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state11) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state10)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((((1'b1 == ap_CS_fsm_pp0_stage8) & (1'b0 == ap_block_pp0_stage8_subdone)) | ((1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0)))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if ((1'b1 == ap_CS_fsm_state10)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        c_reg_295 <= add_ln14_reg_798;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        c_reg_295 <= 6'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        indvar_flatten_reg_272 <= add_ln13_reg_648;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        indvar_flatten_reg_272 <= 13'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        r_reg_283 <= select_ln13_reg_675;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        r_reg_283 <= 7'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage3) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage3_11001))) begin
        add_ln10_reg_711 <= add_ln10_fu_407_p2;
        add_ln18_3_reg_721 <= add_ln18_3_fu_418_p3;
        mul_ln18_1_reg_716 <= mul_ln18_1_fu_413_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
        add_ln13_reg_648 <= add_ln13_fu_310_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage8) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage8_11001) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
        add_ln14_reg_798 <= add_ln14_fu_514_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage6) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage6_11001))) begin
        add_ln18_6_reg_762 <= add_ln18_6_fu_469_p3;
        add_ln19_1_reg_773 <= add_ln19_1_fu_480_p2;
        mul_ln18_4_reg_757 <= mul_ln18_4_fu_464_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln13_reg_653_pp0_iter1_reg == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage2) & (1'b0 == ap_block_pp0_stage2_11001))) begin
        add_ln19_6_reg_813 <= add_ln19_6_fu_542_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage4) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage4_11001))) begin
        add_ln19_reg_742 <= add_ln19_fu_445_p2;
        mul_ln18_2_reg_732 <= mul_ln18_2_fu_430_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln13_fu_316_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        add_ln_reg_680 <= add_ln_fu_350_p3;
        empty_13_reg_670 <= empty_13_fu_336_p2;
        icmp_ln14_reg_657 <= icmp_ln14_fu_322_p2;
        select_ln10_reg_663 <= select_ln10_fu_328_p3;
        zext_ln18_reg_686[12 : 0] <= zext_ln18_fu_358_p1[12 : 0];
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        filter_load_1_reg_573 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        filter_load_2_reg_583 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        filter_load_3_reg_593 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        filter_load_4_reg_603 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        filter_load_5_reg_613 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state8)) begin
        filter_load_6_reg_623 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        filter_load_7_reg_633 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state10)) begin
        filter_load_8_reg_643 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        filter_load_reg_563 <= filter_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln13_reg_653 <= icmp_ln13_fu_316_p2;
        icmp_ln13_reg_653_pp0_iter1_reg <= icmp_ln13_reg_653;
        zext_ln18_reg_686_pp0_iter1_reg[12 : 0] <= zext_ln18_reg_686[12 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage5) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage5_11001))) begin
        mul_ln18_3_reg_747 <= mul_ln18_3_fu_449_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage7) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage7_11001))) begin
        mul_ln18_5_reg_778 <= mul_ln18_5_fu_484_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage8) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage8_11001))) begin
        mul_ln18_6_reg_788 <= mul_ln18_6_fu_499_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        mul_ln18_7_reg_803 <= mul_ln18_7_fu_519_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln13_reg_653_pp0_iter1_reg == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_11001))) begin
        mul_ln18_8_reg_808 <= mul_ln18_8_fu_524_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage2) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage2_11001))) begin
        mul_ln18_reg_701 <= mul_ln18_fu_373_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((1'b1 == ap_CS_fsm_pp0_stage8) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage8_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage7) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage7_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage6) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage6_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage5) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage5_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage4) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage4_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage3) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage3_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage2) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage1) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)))) begin
        reg_306 <= orig_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln13_fu_316_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
        select_ln13_reg_675 <= select_ln13_fu_342_p3;
    end
end

always @ (*) begin
    if ((icmp_ln13_fu_316_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state11 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state11 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state24)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_c_phi_fu_299_p4 = add_ln14_reg_798;
    end else begin
        ap_phi_mux_c_phi_fu_299_p4 = c_reg_295;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_indvar_flatten_phi_fu_276_p4 = add_ln13_reg_648;
    end else begin
        ap_phi_mux_indvar_flatten_phi_fu_276_p4 = indvar_flatten_reg_272;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln13_reg_653 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_r_phi_fu_287_p4 = select_ln13_reg_675;
    end else begin
        ap_phi_mux_r_phi_fu_287_p4 = r_reg_283;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state24)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        filter_address0 = 64'd8;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        filter_address0 = 64'd7;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        filter_address0 = 64'd6;
    end else if ((1'b1 == ap_CS_fsm_state6)) begin
        filter_address0 = 64'd5;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        filter_address0 = 64'd4;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        filter_address0 = 64'd3;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        filter_address0 = 64'd2;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        filter_address0 = 64'd1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        filter_address0 = 64'd0;
    end else begin
        filter_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state2) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        filter_ce0 = 1'b1;
    end else begin
        filter_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b1)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage8) & (1'b0 == ap_block_pp0_stage8))) begin
            orig_address0 = zext_ln18_8_fu_509_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage7) & (1'b0 == ap_block_pp0_stage7))) begin
            orig_address0 = zext_ln18_7_fu_494_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage6) & (1'b0 == ap_block_pp0_stage6))) begin
            orig_address0 = zext_ln18_6_fu_475_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage5) & (1'b0 == ap_block_pp0_stage5))) begin
            orig_address0 = zext_ln18_5_fu_459_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage4) & (1'b0 == ap_block_pp0_stage4))) begin
            orig_address0 = zext_ln18_4_fu_440_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3))) begin
            orig_address0 = zext_ln18_3_fu_425_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage2) & (1'b0 == ap_block_pp0_stage2))) begin
            orig_address0 = zext_ln18_2_fu_383_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1))) begin
            orig_address0 = zext_ln18_1_fu_368_p1;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
            orig_address0 = zext_ln18_fu_358_p1;
        end else begin
            orig_address0 = 'bx;
        end
    end else begin
        orig_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage8) & (1'b0 == ap_block_pp0_stage8_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage7) & (1'b0 == ap_block_pp0_stage7_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage6) & (1'b0 == ap_block_pp0_stage6_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage5) & (1'b0 == ap_block_pp0_stage5_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage4) & (1'b0 == ap_block_pp0_stage4_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage2) & (1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1)))) begin
        orig_ce0 = 1'b1;
    end else begin
        orig_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_11001))) begin
        sol_ce0 = 1'b1;
    end else begin
        sol_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln13_reg_653_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_11001))) begin
        sol_we0 = 1'b1;
    end else begin
        sol_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((icmp_ln13_fu_316_p2 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else if (((icmp_ln13_fu_316_p2 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state24;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_pp0_stage2 : begin
            if ((1'b0 == ap_block_pp0_stage2_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end
        end
        ap_ST_fsm_pp0_stage3 : begin
            if ((~((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0)) & (1'b0 == ap_block_pp0_stage3_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage4;
            end else if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3) & (1'b0 == ap_block_pp0_stage3_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state24;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage3;
            end
        end
        ap_ST_fsm_pp0_stage4 : begin
            if ((1'b0 == ap_block_pp0_stage4_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage4;
            end
        end
        ap_ST_fsm_pp0_stage5 : begin
            if ((1'b0 == ap_block_pp0_stage5_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage5;
            end
        end
        ap_ST_fsm_pp0_stage6 : begin
            if ((1'b0 == ap_block_pp0_stage6_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage6;
            end
        end
        ap_ST_fsm_pp0_stage7 : begin
            if ((1'b0 == ap_block_pp0_stage7_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage8;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage7;
            end
        end
        ap_ST_fsm_pp0_stage8 : begin
            if ((1'b0 == ap_block_pp0_stage8_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage8;
            end
        end
        ap_ST_fsm_state24 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln10_fu_407_p2 = (r_reg_283 + select_ln10_2_fu_400_p3);

assign add_ln13_fu_310_p2 = (ap_phi_mux_indvar_flatten_phi_fu_276_p4 + 13'd1);

assign add_ln14_fu_514_p2 = (select_ln10_reg_663 + 6'd1);

assign add_ln18_1_fu_378_p2 = (add_ln_reg_680 + 13'd2);

assign add_ln18_2_fu_435_p2 = (add_ln18_3_reg_721 + 13'd1);

assign add_ln18_3_fu_418_p3 = {{select_ln10_1_fu_394_p3}, {select_ln10_reg_663}};

assign add_ln18_4_fu_454_p2 = (add_ln18_3_reg_721 + 13'd2);

assign add_ln18_5_fu_489_p2 = (add_ln18_6_reg_762 + 13'd1);

assign add_ln18_6_fu_469_p3 = {{add_ln10_reg_711}, {select_ln10_reg_663}};

assign add_ln18_7_fu_504_p2 = (add_ln18_6_reg_762 + 13'd2);

assign add_ln18_fu_363_p2 = (add_ln_reg_680 + 13'd1);

assign add_ln19_1_fu_480_p2 = (mul_ln18_2_reg_732 + mul_ln18_3_reg_747);

assign add_ln19_2_fu_548_p2 = (add_ln19_1_reg_773 + add_ln19_reg_742);

assign add_ln19_3_fu_529_p2 = (mul_ln18_4_reg_757 + mul_ln18_5_reg_778);

assign add_ln19_4_fu_533_p2 = (mul_ln18_7_reg_803 + mul_ln18_8_reg_808);

assign add_ln19_5_fu_537_p2 = (add_ln19_4_fu_533_p2 + mul_ln18_6_reg_788);

assign add_ln19_6_fu_542_p2 = (add_ln19_5_fu_537_p2 + add_ln19_3_fu_529_p2);

assign add_ln19_fu_445_p2 = (mul_ln18_1_reg_716 + mul_ln18_reg_701);

assign add_ln_fu_350_p3 = {{select_ln13_fu_342_p3}, {select_ln10_fu_328_p3}};

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd11];

assign ap_CS_fsm_pp0_stage2 = ap_CS_fsm[32'd12];

assign ap_CS_fsm_pp0_stage3 = ap_CS_fsm[32'd13];

assign ap_CS_fsm_pp0_stage4 = ap_CS_fsm[32'd14];

assign ap_CS_fsm_pp0_stage5 = ap_CS_fsm[32'd15];

assign ap_CS_fsm_pp0_stage6 = ap_CS_fsm[32'd16];

assign ap_CS_fsm_pp0_stage7 = ap_CS_fsm[32'd17];

assign ap_CS_fsm_pp0_stage8 = ap_CS_fsm[32'd18];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state24 = ap_CS_fsm[32'd19];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage4 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage4_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage4_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage5 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage5_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage5_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage6 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage6_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage6_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage7 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage7_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage7_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage8 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage8_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage8_subdone = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage2_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage3_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp0_stage4_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state16_pp0_stage5_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state17_pp0_stage6_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state18_pp0_stage7_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state19_pp0_stage8_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state20_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state21_pp0_stage1_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state22_pp0_stage2_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state23_pp0_stage3_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign empty_13_fu_336_p2 = (ap_phi_mux_r_phi_fu_287_p4 + 7'd1);

assign icmp_ln13_fu_316_p2 = ((ap_phi_mux_indvar_flatten_phi_fu_276_p4 == 13'd7812) ? 1'b1 : 1'b0);

assign icmp_ln14_fu_322_p2 = ((ap_phi_mux_c_phi_fu_299_p4 == 6'd62) ? 1'b1 : 1'b0);

assign p_mid1_fu_388_p2 = (r_reg_283 + 7'd2);

assign select_ln10_1_fu_394_p3 = ((icmp_ln14_reg_657[0:0] == 1'b1) ? p_mid1_fu_388_p2 : empty_13_reg_670);

assign select_ln10_2_fu_400_p3 = ((icmp_ln14_reg_657[0:0] == 1'b1) ? 7'd3 : 7'd2);

assign select_ln10_fu_328_p3 = ((icmp_ln14_fu_322_p2[0:0] == 1'b1) ? 6'd0 : ap_phi_mux_c_phi_fu_299_p4);

assign select_ln13_fu_342_p3 = ((icmp_ln14_fu_322_p2[0:0] == 1'b1) ? empty_13_fu_336_p2 : ap_phi_mux_r_phi_fu_287_p4);

assign sol_address0 = zext_ln18_reg_686_pp0_iter1_reg;

assign sol_d0 = (add_ln19_6_reg_813 + add_ln19_2_fu_548_p2);

assign zext_ln18_1_fu_368_p1 = add_ln18_fu_363_p2;

assign zext_ln18_2_fu_383_p1 = add_ln18_1_fu_378_p2;

assign zext_ln18_3_fu_425_p1 = add_ln18_3_fu_418_p3;

assign zext_ln18_4_fu_440_p1 = add_ln18_2_fu_435_p2;

assign zext_ln18_5_fu_459_p1 = add_ln18_4_fu_454_p2;

assign zext_ln18_6_fu_475_p1 = add_ln18_6_fu_469_p3;

assign zext_ln18_7_fu_494_p1 = add_ln18_5_fu_489_p2;

assign zext_ln18_8_fu_509_p1 = add_ln18_7_fu_504_p2;

assign zext_ln18_fu_358_p1 = add_ln_fu_350_p3;

always @ (posedge ap_clk) begin
    zext_ln18_reg_686[63:13] <= 51'b000000000000000000000000000000000000000000000000000;
    zext_ln18_reg_686_pp0_iter1_reg[63:13] <= 51'b000000000000000000000000000000000000000000000000000;
end

endmodule //stencil