// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="bfs_bfs,hls_ip_2020_2,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg484-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.059000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=30,HLS_SYN_DSP=0,HLS_SYN_FF=994,HLS_SYN_LUT=1047,HLS_VERSION=2020_2}" *)

module custom_IP (
        s_axi_clk,
        s_axi_rst_n,
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

parameter    ap_ST_fsm_state1 = 8'd1;
parameter    ap_ST_fsm_state2 = 8'd2;
parameter    ap_ST_fsm_state3 = 8'd4;
parameter    ap_ST_fsm_state4 = 8'd8;
parameter    ap_ST_fsm_state5 = 8'd16;
parameter    ap_ST_fsm_pp0_stage0 = 8'd32;
parameter    ap_ST_fsm_pp0_stage1 = 8'd64;
parameter    ap_ST_fsm_state9 = 8'd128;
parameter    C_S_AXI_BUS_A_DATA_WIDTH = 32;
parameter    C_S_AXI_BUS_A_ADDR_WIDTH = 16;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_BUS_A_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   s_axi_clk;
input   s_axi_rst_n;
input   s_axi_BUS_A_AWVALID;
output   s_axi_BUS_A_AWREADY;
input  [31:0] s_axi_BUS_A_AWADDR;
input   s_axi_BUS_A_WVALID;
output   s_axi_BUS_A_WREADY;
input  [C_S_AXI_BUS_A_DATA_WIDTH - 1:0] s_axi_BUS_A_WDATA;
input  [C_S_AXI_BUS_A_WSTRB_WIDTH - 1:0] s_axi_BUS_A_WSTRB;
input   s_axi_BUS_A_ARVALID;
output   s_axi_BUS_A_ARREADY;
input  [31:0] s_axi_BUS_A_ARADDR;
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
(* fsm_encoding = "none" *) reg   [7:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_ready;
wire   [7:0] nodes_address0;
reg    nodes_ce0;
wire   [127:0] nodes_q0;
wire   [11:0] edges_address0;
reg    edges_ce0;
wire   [63:0] edges_q0;
wire   [63:0] starting_node;
reg   [7:0] level_address0;
reg    level_ce0;
reg    level_we0;
reg   [7:0] level_d0;
wire   [7:0] level_q0;
reg   [3:0] level_counts_address0;
reg    level_counts_ce0;
reg    level_counts_we0;
reg   [63:0] level_counts_d0;
reg   [63:0] e_1_reg_213;
reg   [63:0] cnt_1_reg_224;
wire   [63:0] add_ln27_fu_263_p2;
reg   [63:0] add_ln27_reg_360;
wire    ap_CS_fsm_state2;
wire   [7:0] empty_20_fu_273_p2;
reg   [7:0] empty_20_reg_366;
wire   [8:0] n_1_fu_279_p2;
reg   [8:0] n_1_reg_371;
wire    ap_CS_fsm_state3;
wire   [63:0] zext_ln30_fu_291_p1;
reg   [63:0] zext_ln30_reg_379;
wire   [0:0] icmp_ln30_fu_285_p2;
wire   [0:0] icmp_ln31_fu_310_p2;
reg   [0:0] icmp_ln31_reg_392;
wire    ap_CS_fsm_state4;
wire   [63:0] tmp_begin_fu_316_p1;
wire    ap_CS_fsm_state5;
wire   [63:0] tmp_end_fu_320_p4;
reg   [63:0] tmp_end_reg_406;
wire   [0:0] icmp_ln34_fu_330_p2;
reg   [0:0] icmp_ln34_reg_411;
wire   [0:0] icmp_ln34_1_fu_336_p2;
reg   [0:0] icmp_ln34_1_reg_415;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state6_pp0_stage0_iter0;
wire    ap_block_state8_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_11001;
reg   [7:0] level_addr_2_reg_424;
wire    ap_CS_fsm_pp0_stage1;
wire    ap_block_state7_pp0_stage1_iter0;
wire    ap_block_pp0_stage1_11001;
wire   [63:0] e_2_fu_341_p2;
reg   [63:0] e_2_reg_429;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage1_subdone;
reg    ap_condition_pp0_exit_iter0_state7;
reg    ap_enable_reg_pp0_iter1;
reg   [63:0] horizon_reg_177;
wire   [0:0] icmp_ln45_fu_296_p2;
reg   [63:0] cnt_reg_189;
reg   [63:0] ap_phi_mux_cnt_3_phi_fu_251_p6;
wire    ap_CS_fsm_state9;
reg   [8:0] n_reg_202;
reg   [63:0] ap_phi_mux_e_1_phi_fu_216_p4;
wire    ap_block_pp0_stage0;
reg   [63:0] ap_phi_mux_cnt_2_phi_fu_239_p4;
wire   [63:0] cnt_4_fu_353_p2;
wire   [63:0] ap_phi_reg_pp0_iter1_cnt_2_reg_235;
wire   [0:0] icmp_ln38_fu_347_p2;
reg   [63:0] cnt_3_reg_247;
wire    ap_block_pp0_stage1;
wire   [7:0] trunc_ln27_fu_269_p1;
wire  signed [31:0] sext_ln31_fu_302_p1;
wire   [63:0] zext_ln31_fu_306_p1;
reg   [7:0] ap_NS_fsm;
wire    ap_block_pp0_stage0_subdone;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 8'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

bfs_BUS_A_s_axi #(
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
    .ACLK(s_axi_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .starting_node(starting_node),
    .level_counts_address0(level_counts_address0),
    .level_counts_ce0(level_counts_ce0),
    .level_counts_we0(level_counts_we0),
    .level_counts_d0(level_counts_d0),
    .level_address0(level_address0),
    .level_ce0(level_ce0),
    .level_we0(level_we0),
    .level_d0(level_d0),
    .level_q0(level_q0),
    .nodes_address0(nodes_address0),
    .nodes_ce0(nodes_ce0),
    .nodes_q0(nodes_q0),
    .edges_address0(edges_address0),
    .edges_ce0(edges_ce0),
    .edges_q0(edges_q0),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

always @ (posedge s_axi_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge s_axi_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state7) & (1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge s_axi_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state7) & (1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state7);
        end else if (((1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_subdone))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd1))) begin
        cnt_1_reg_224 <= cnt_reg_189;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln34_1_reg_415 == 1'd0))) begin
        cnt_1_reg_224 <= ap_phi_mux_cnt_2_phi_fu_239_p4;
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_state9) & (icmp_ln34_reg_411 == 1'd1) & (icmp_ln31_reg_392 == 1'd1))) begin
        cnt_3_reg_247 <= cnt_1_reg_224;
    end else if ((((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd0)) | ((1'b1 == ap_CS_fsm_state4) & (icmp_ln31_fu_310_p2 == 1'd0)))) begin
        cnt_3_reg_247 <= cnt_reg_189;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        cnt_reg_189 <= ap_phi_mux_cnt_3_phi_fu_251_p6;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        cnt_reg_189 <= 64'd0;
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd1))) begin
        e_1_reg_213 <= tmp_begin_fu_316_p1;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln34_1_reg_415 == 1'd0))) begin
        e_1_reg_213 <= e_2_reg_429;
    end
end

always @ (posedge s_axi_clk) begin
    if (((icmp_ln45_fu_296_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1))) begin
        horizon_reg_177 <= add_ln27_reg_360;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        horizon_reg_177 <= 64'd0;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        n_reg_202 <= n_1_reg_371;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        n_reg_202 <= 9'd0;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        add_ln27_reg_360 <= add_ln27_fu_263_p2;
        empty_20_reg_366 <= empty_20_fu_273_p2;
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage1_11001) & (icmp_ln34_1_reg_415 == 1'd0))) begin
        e_2_reg_429 <= e_2_fu_341_p2;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        icmp_ln31_reg_392 <= icmp_ln31_fu_310_p2;
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln34_1_reg_415 <= icmp_ln34_1_fu_336_p2;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        icmp_ln34_reg_411 <= icmp_ln34_fu_330_p2;
        tmp_end_reg_406 <= {{nodes_q0[127:64]}};
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage1) & (1'b0 == ap_block_pp0_stage1_11001) & (icmp_ln34_1_reg_415 == 1'd0))) begin
        level_addr_2_reg_424 <= edges_q0;
    end
end

always @ (posedge s_axi_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        n_1_reg_371 <= n_1_fu_279_p2;
    end
end

always @ (posedge s_axi_clk) begin
    if (((1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd0))) begin
        zext_ln30_reg_379[8 : 0] <= zext_ln30_fu_291_p1[8 : 0];
    end
end

always @ (*) begin
    if ((icmp_ln34_1_reg_415 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state7 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state7 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln45_fu_296_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
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
    if ((icmp_ln34_1_reg_415 == 1'd0)) begin
        if ((icmp_ln38_fu_347_p2 == 1'd0)) begin
            ap_phi_mux_cnt_2_phi_fu_239_p4 = cnt_1_reg_224;
        end else if ((icmp_ln38_fu_347_p2 == 1'd1)) begin
            ap_phi_mux_cnt_2_phi_fu_239_p4 = cnt_4_fu_353_p2;
        end else begin
            ap_phi_mux_cnt_2_phi_fu_239_p4 = ap_phi_reg_pp0_iter1_cnt_2_reg_235;
        end
    end else begin
        ap_phi_mux_cnt_2_phi_fu_239_p4 = ap_phi_reg_pp0_iter1_cnt_2_reg_235;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state9) & (icmp_ln34_reg_411 == 1'd1) & (icmp_ln31_reg_392 == 1'd1))) begin
        ap_phi_mux_cnt_3_phi_fu_251_p6 = cnt_1_reg_224;
    end else begin
        ap_phi_mux_cnt_3_phi_fu_251_p6 = cnt_3_reg_247;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (icmp_ln34_1_reg_415 == 1'd0))) begin
        ap_phi_mux_e_1_phi_fu_216_p4 = e_2_reg_429;
    end else begin
        ap_phi_mux_e_1_phi_fu_216_p4 = e_1_reg_213;
    end
end

always @ (*) begin
    if (((icmp_ln45_fu_296_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        edges_ce0 = 1'b1;
    end else begin
        edges_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        level_address0 = level_addr_2_reg_424;
    end else if (((1'b1 == ap_CS_fsm_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage1))) begin
        level_address0 = edges_q0;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        level_address0 = zext_ln30_fu_291_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        level_address0 = starting_node;
    end else begin
        level_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage1_11001)) | ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        level_ce0 = 1'b1;
    end else begin
        level_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        level_counts_address0 = add_ln27_reg_360;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        level_counts_address0 = 64'd0;
    end else begin
        level_counts_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        level_counts_ce0 = 1'b1;
    end else begin
        level_counts_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        level_counts_d0 = cnt_reg_189;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        level_counts_d0 = 64'd1;
    end else begin
        level_counts_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1)))) begin
        level_counts_we0 = 1'b1;
    end else begin
        level_counts_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        level_d0 = empty_20_reg_366;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        level_d0 = 8'd0;
    end else begin
        level_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | ((icmp_ln38_fu_347_p2 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln34_1_reg_415 == 1'd0)))) begin
        level_we0 = 1'b1;
    end else begin
        level_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        nodes_ce0 = 1'b1;
    end else begin
        nodes_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((icmp_ln45_fu_296_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else if (((icmp_ln45_fu_296_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln30_fu_285_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (icmp_ln31_fu_310_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state5 : begin
            if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln34_fu_330_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((~((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (icmp_ln34_1_reg_415 == 1'd1)) & (1'b0 == ap_block_pp0_stage1_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (icmp_ln34_1_reg_415 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln27_fu_263_p2 = (horizon_reg_177 + 64'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd7];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_subdone = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter1_cnt_2_reg_235 = 'bx;

always @ (*) begin
    ap_rst_n_inv = ~s_axi_rst_n;
end

assign cnt_4_fu_353_p2 = (cnt_1_reg_224 + 64'd1);

assign e_2_fu_341_p2 = (e_1_reg_213 + 64'd1);

assign edges_address0 = ap_phi_mux_e_1_phi_fu_216_p4;

assign empty_20_fu_273_p2 = (trunc_ln27_fu_269_p1 + 8'd1);

assign icmp_ln30_fu_285_p2 = ((n_reg_202 == 9'd256) ? 1'b1 : 1'b0);

assign icmp_ln31_fu_310_p2 = ((zext_ln31_fu_306_p1 == horizon_reg_177) ? 1'b1 : 1'b0);

assign icmp_ln34_1_fu_336_p2 = ((ap_phi_mux_e_1_phi_fu_216_p4 == tmp_end_reg_406) ? 1'b1 : 1'b0);

assign icmp_ln34_fu_330_p2 = ((tmp_begin_fu_316_p1 < tmp_end_fu_320_p4) ? 1'b1 : 1'b0);

assign icmp_ln38_fu_347_p2 = ((level_q0 == 8'd127) ? 1'b1 : 1'b0);

assign icmp_ln45_fu_296_p2 = ((cnt_reg_189 == 64'd0) ? 1'b1 : 1'b0);

assign n_1_fu_279_p2 = (n_reg_202 + 9'd1);

assign nodes_address0 = zext_ln30_reg_379;

assign sext_ln31_fu_302_p1 = $signed(level_q0);

assign tmp_begin_fu_316_p1 = nodes_q0[63:0];

assign tmp_end_fu_320_p4 = {{nodes_q0[127:64]}};

assign trunc_ln27_fu_269_p1 = horizon_reg_177[7:0];

assign zext_ln30_fu_291_p1 = n_reg_202;

assign zext_ln31_fu_306_p1 = $unsigned(sext_ln31_fu_302_p1);

always @ (posedge s_axi_clk) begin
    zext_ln30_reg_379[63:9] <= 55'b0000000000000000000000000000000000000000000000000000000;
end

endmodule //bfs
