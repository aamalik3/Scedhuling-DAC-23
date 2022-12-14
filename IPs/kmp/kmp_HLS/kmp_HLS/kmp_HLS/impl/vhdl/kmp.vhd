-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity kmp is
generic (
    C_S_AXI_BUS_A_ADDR_WIDTH : INTEGER := 16;
    C_S_AXI_BUS_A_DATA_WIDTH : INTEGER := 32 );
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    s_axi_BUS_A_AWVALID : IN STD_LOGIC;
    s_axi_BUS_A_AWREADY : OUT STD_LOGIC;
    s_axi_BUS_A_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_ADDR_WIDTH-1 downto 0);
    s_axi_BUS_A_WVALID : IN STD_LOGIC;
    s_axi_BUS_A_WREADY : OUT STD_LOGIC;
    s_axi_BUS_A_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH-1 downto 0);
    s_axi_BUS_A_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH/8-1 downto 0);
    s_axi_BUS_A_ARVALID : IN STD_LOGIC;
    s_axi_BUS_A_ARREADY : OUT STD_LOGIC;
    s_axi_BUS_A_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_BUS_A_ADDR_WIDTH-1 downto 0);
    s_axi_BUS_A_RVALID : OUT STD_LOGIC;
    s_axi_BUS_A_RREADY : IN STD_LOGIC;
    s_axi_BUS_A_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_BUS_A_DATA_WIDTH-1 downto 0);
    s_axi_BUS_A_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_BUS_A_BVALID : OUT STD_LOGIC;
    s_axi_BUS_A_BREADY : IN STD_LOGIC;
    s_axi_BUS_A_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    interrupt : OUT STD_LOGIC );
end;


architecture behav of kmp is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "kmp_kmp,hls_ip_2020_2,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg484-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.626500,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=20,HLS_SYN_DSP=0,HLS_SYN_FF=680,HLS_SYN_LUT=968,HLS_VERSION=2020_2}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (12 downto 0) := "0000000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (12 downto 0) := "0000000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (12 downto 0) := "0000000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (12 downto 0) := "0000001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (12 downto 0) := "0000010000000";
    constant ap_ST_fsm_pp1_stage0 : STD_LOGIC_VECTOR (12 downto 0) := "0000100000000";
    constant ap_ST_fsm_pp1_stage1 : STD_LOGIC_VECTOR (12 downto 0) := "0001000000000";
    constant ap_ST_fsm_state12 : STD_LOGIC_VECTOR (12 downto 0) := "0010000000000";
    constant ap_ST_fsm_state13 : STD_LOGIC_VECTOR (12 downto 0) := "0100000000000";
    constant ap_ST_fsm_state14 : STD_LOGIC_VECTOR (12 downto 0) := "1000000000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_lv32_9 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001001";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv32_C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001100";
    constant ap_const_lv15_0 : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv3_4 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv15_1 : STD_LOGIC_VECTOR (14 downto 0) := "000000000000001";
    constant ap_const_lv15_7E9B : STD_LOGIC_VECTOR (14 downto 0) := "111111010011011";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv30_0 : STD_LOGIC_VECTOR (29 downto 0) := "000000000000000000000000000000";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";

    signal ap_rst_n_inv : STD_LOGIC;
    signal ap_start : STD_LOGIC;
    signal ap_done : STD_LOGIC;
    signal ap_idle : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_ready : STD_LOGIC;
    signal pattern_address0 : STD_LOGIC_VECTOR (1 downto 0);
    signal pattern_ce0 : STD_LOGIC;
    signal pattern_q0 : STD_LOGIC_VECTOR (7 downto 0);
    signal input_r_address0 : STD_LOGIC_VECTOR (14 downto 0);
    signal input_r_ce0 : STD_LOGIC;
    signal input_r_q0 : STD_LOGIC_VECTOR (7 downto 0);
    signal kmpNext_address0 : STD_LOGIC_VECTOR (1 downto 0);
    signal kmpNext_ce0 : STD_LOGIC;
    signal kmpNext_we0 : STD_LOGIC;
    signal kmpNext_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal kmpNext_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal n_matches : STD_LOGIC_VECTOR (31 downto 0);
    signal n_matches_ap_vld : STD_LOGIC;
    signal q_1_reg_249 : STD_LOGIC_VECTOR (31 downto 0);
    signal reg_277 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_pp1_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp1_stage0 : signal is "none";
    signal ap_enable_reg_pp1_iter1 : STD_LOGIC := '0';
    signal ap_block_state9_pp1_stage0_iter0 : BOOLEAN;
    signal ap_block_state11_pp1_stage0_iter1 : BOOLEAN;
    signal ap_block_pp1_stage0_11001 : BOOLEAN;
    signal icmp_ln40_reg_506 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln40_1_reg_521 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal icmp_ln12_fu_283_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal kmpNext_addr_1_reg_442 : STD_LOGIC_VECTOR (1 downto 0);
    signal pattern_load_reg_454 : STD_LOGIC_VECTOR (7 downto 0);
    signal icmp_ln13_fu_300_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln13_reg_460 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal pattern_load_1_reg_470 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal add_ln12_fu_321_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal k_3_fu_337_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln39_fu_346_p2 : STD_LOGIC_VECTOR (14 downto 0);
    signal add_ln39_reg_488 : STD_LOGIC_VECTOR (14 downto 0);
    signal ap_CS_fsm_state7 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state7 : signal is "none";
    signal icmp_ln39_fu_352_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal input_load_reg_501 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_CS_fsm_state8 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state8 : signal is "none";
    signal icmp_ln40_fu_363_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal idxprom8_fu_369_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal idxprom8_reg_510 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_enable_reg_pp1_iter0 : STD_LOGIC := '0';
    signal grp_fu_272_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp1_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp1_stage1 : signal is "none";
    signal ap_block_state10_pp1_stage1_iter0 : BOOLEAN;
    signal ap_block_pp1_stage1_11001 : BOOLEAN;
    signal ap_CS_fsm_state12 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state12 : signal is "none";
    signal q_4_fu_380_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state13 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state13 : signal is "none";
    signal icmp_ln46_fu_402_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln46_reg_540 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp1_stage1_subdone : BOOLEAN;
    signal ap_predicate_tran10to12_state10 : BOOLEAN;
    signal ap_condition_pp1_exit_iter0_state10 : STD_LOGIC;
    signal q_reg_191 : STD_LOGIC_VECTOR (2 downto 0);
    signal k_reg_203 : STD_LOGIC_VECTOR (31 downto 0);
    signal k_1_reg_215 : STD_LOGIC_VECTOR (31 downto 0);
    signal and_ln13_fu_316_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_reg_226 : STD_LOGIC_VECTOR (14 downto 0);
    signal ap_CS_fsm_state14 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state14 : signal is "none";
    signal ap_phi_mux_q_3_phi_fu_264_p4 : STD_LOGIC_VECTOR (31 downto 0);
    signal q_2_reg_237 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_phi_mux_q_1_phi_fu_252_p4 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp1_stage0 : BOOLEAN;
    signal q_3_reg_260 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln12_fu_289_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln16_fu_306_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln39_fu_358_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp1_stage1 : BOOLEAN;
    signal zext_ln48_fu_424_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal empty_20_fu_90 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln47_fu_411_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln13_1_fu_311_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln16_fu_327_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln17_fu_331_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln44_fu_374_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_fu_392_p4 : STD_LOGIC_VECTOR (29 downto 0);
    signal trunc_ln33_fu_388_p1 : STD_LOGIC_VECTOR (1 downto 0);
    signal add_ln48_fu_418_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_block_pp1_stage0_subdone : BOOLEAN;
    signal ap_idle_pp1 : STD_LOGIC;
    signal ap_enable_pp1 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;
    signal ap_return : STD_LOGIC_VECTOR (31 downto 0);

    component kmp_BUS_A_s_axi IS
    generic (
        C_S_AXI_ADDR_WIDTH : INTEGER;
        C_S_AXI_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        ap_start : OUT STD_LOGIC;
        interrupt : OUT STD_LOGIC;
        ap_ready : IN STD_LOGIC;
        ap_done : IN STD_LOGIC;
        ap_idle : IN STD_LOGIC;
        ap_return : IN STD_LOGIC_VECTOR (31 downto 0);
        pattern_address0 : IN STD_LOGIC_VECTOR (1 downto 0);
        pattern_ce0 : IN STD_LOGIC;
        pattern_q0 : OUT STD_LOGIC_VECTOR (7 downto 0);
        kmpNext_address0 : IN STD_LOGIC_VECTOR (1 downto 0);
        kmpNext_ce0 : IN STD_LOGIC;
        kmpNext_we0 : IN STD_LOGIC;
        kmpNext_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        kmpNext_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        n_matches : IN STD_LOGIC_VECTOR (31 downto 0);
        n_matches_ap_vld : IN STD_LOGIC;
        input_r_address0 : IN STD_LOGIC_VECTOR (14 downto 0);
        input_r_ce0 : IN STD_LOGIC;
        input_r_q0 : OUT STD_LOGIC_VECTOR (7 downto 0) );
    end component;



begin
    BUS_A_s_axi_U : component kmp_BUS_A_s_axi
    generic map (
        C_S_AXI_ADDR_WIDTH => C_S_AXI_BUS_A_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH => C_S_AXI_BUS_A_DATA_WIDTH)
    port map (
        AWVALID => s_axi_BUS_A_AWVALID,
        AWREADY => s_axi_BUS_A_AWREADY,
        AWADDR => s_axi_BUS_A_AWADDR,
        WVALID => s_axi_BUS_A_WVALID,
        WREADY => s_axi_BUS_A_WREADY,
        WDATA => s_axi_BUS_A_WDATA,
        WSTRB => s_axi_BUS_A_WSTRB,
        ARVALID => s_axi_BUS_A_ARVALID,
        ARREADY => s_axi_BUS_A_ARREADY,
        ARADDR => s_axi_BUS_A_ARADDR,
        RVALID => s_axi_BUS_A_RVALID,
        RREADY => s_axi_BUS_A_RREADY,
        RDATA => s_axi_BUS_A_RDATA,
        RRESP => s_axi_BUS_A_RRESP,
        BVALID => s_axi_BUS_A_BVALID,
        BREADY => s_axi_BUS_A_BREADY,
        BRESP => s_axi_BUS_A_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        ap_start => ap_start,
        interrupt => interrupt,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_idle => ap_idle,
        ap_return => ap_const_lv32_0,
        pattern_address0 => pattern_address0,
        pattern_ce0 => pattern_ce0,
        pattern_q0 => pattern_q0,
        kmpNext_address0 => kmpNext_address0,
        kmpNext_ce0 => kmpNext_ce0,
        kmpNext_we0 => kmpNext_we0,
        kmpNext_d0 => kmpNext_d0,
        kmpNext_q0 => kmpNext_q0,
        n_matches => n_matches,
        n_matches_ap_vld => n_matches_ap_vld,
        input_r_address0 => input_r_address0,
        input_r_ce0 => input_r_ce0,
        input_r_q0 => input_r_q0);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp1_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp1_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_condition_pp1_exit_iter0_state10) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) then 
                    ap_enable_reg_pp1_iter0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state8)) then 
                    ap_enable_reg_pp1_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp1_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp1_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_condition_pp1_exit_iter0_state10) and (ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) then 
                    ap_enable_reg_pp1_iter1 <= (ap_const_logic_1 xor ap_condition_pp1_exit_iter0_state10);
                elsif (((ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) then 
                    ap_enable_reg_pp1_iter1 <= ap_enable_reg_pp1_iter0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state8)) then 
                    ap_enable_reg_pp1_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    empty_20_fu_90_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state2) and (icmp_ln12_fu_283_p2 = ap_const_lv1_1))) then 
                empty_20_fu_90 <= ap_const_lv32_0;
            elsif (((icmp_ln46_fu_402_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state13))) then 
                empty_20_fu_90 <= add_ln47_fu_411_p2;
            end if; 
        end if;
    end process;

    i_reg_226_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state2) and (icmp_ln12_fu_283_p2 = ap_const_lv1_1))) then 
                i_reg_226 <= ap_const_lv15_0;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state14)) then 
                i_reg_226 <= add_ln39_reg_488;
            end if; 
        end if;
    end process;

    k_1_reg_215_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state5) and (ap_const_lv1_1 = and_ln13_fu_316_p2))) then 
                k_1_reg_215 <= reg_277;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                k_1_reg_215 <= k_reg_203;
            end if; 
        end if;
    end process;

    k_reg_203_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                k_reg_203 <= ap_const_lv32_0;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
                k_reg_203 <= k_3_fu_337_p3;
            end if; 
        end if;
    end process;

    q_1_reg_249_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (icmp_ln40_1_reg_521 = ap_const_lv1_0) and (icmp_ln40_reg_506 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001) and (ap_enable_reg_pp1_iter1 = ap_const_logic_1))) then 
                q_1_reg_249 <= kmpNext_q0;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state8)) then 
                q_1_reg_249 <= q_2_reg_237;
            end if; 
        end if;
    end process;

    q_2_reg_237_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state2) and (icmp_ln12_fu_283_p2 = ap_const_lv1_1))) then 
                q_2_reg_237 <= ap_const_lv32_0;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state14)) then 
                q_2_reg_237 <= ap_phi_mux_q_3_phi_fu_264_p4;
            end if; 
        end if;
    end process;

    q_3_reg_260_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln46_fu_402_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state13))) then 
                q_3_reg_260 <= q_4_fu_380_p3;
            elsif (((icmp_ln46_reg_540 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state14))) then 
                q_3_reg_260 <= kmpNext_q0;
            end if; 
        end if;
    end process;

    q_reg_191_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                q_reg_191 <= ap_const_lv3_1;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
                q_reg_191 <= add_ln12_fu_321_p2;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state7)) then
                add_ln39_reg_488 <= add_ln39_fu_346_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state4)) then
                icmp_ln13_reg_460 <= icmp_ln13_fu_300_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (icmp_ln40_reg_506 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp1_stage1_11001))) then
                icmp_ln40_1_reg_521 <= grp_fu_272_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then
                icmp_ln40_reg_506 <= icmp_ln40_fu_363_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state13)) then
                icmp_ln46_reg_540 <= icmp_ln46_fu_402_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001))) then
                    idxprom8_reg_510(31 downto 0) <= idxprom8_fu_369_p1(31 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state8)) then
                input_load_reg_501 <= input_r_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state2) and (icmp_ln12_fu_283_p2 = ap_const_lv1_0))) then
                kmpNext_addr_1_reg_442 <= zext_ln12_fu_289_p1(2 - 1 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state5)) then
                pattern_load_1_reg_470 <= pattern_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                pattern_load_reg_454 <= pattern_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state3) or ((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (icmp_ln40_1_reg_521 = ap_const_lv1_0) and (icmp_ln40_reg_506 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001) and (ap_enable_reg_pp1_iter1 = ap_const_logic_1)))) then
                reg_277 <= kmpNext_q0;
            end if;
        end if;
    end process;
    idxprom8_reg_510(63 downto 32) <= "00000000000000000000000000000000";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, icmp_ln12_fu_283_p2, ap_CS_fsm_state5, ap_CS_fsm_state7, icmp_ln39_fu_352_p2, ap_enable_reg_pp1_iter0, ap_block_pp1_stage1_subdone, ap_predicate_tran10to12_state10, and_ln13_fu_316_p2, ap_block_pp1_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state2) and (icmp_ln12_fu_283_p2 = ap_const_lv1_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state7;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state5) and (ap_const_lv1_1 = and_ln13_fu_316_p2))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_state6;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state2;
            when ap_ST_fsm_state7 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state7) and (icmp_ln39_fu_352_p2 = ap_const_lv1_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state8;
                end if;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
            when ap_ST_fsm_pp1_stage0 => 
                if ((ap_const_boolean_0 = ap_block_pp1_stage0_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
                end if;
            when ap_ST_fsm_pp1_stage1 => 
                if ((not(((ap_predicate_tran10to12_state10 = ap_const_boolean_1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage0;
                elsif (((ap_predicate_tran10to12_state10 = ap_const_boolean_1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage1_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_state12;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp1_stage1;
                end if;
            when ap_ST_fsm_state12 => 
                ap_NS_fsm <= ap_ST_fsm_state13;
            when ap_ST_fsm_state13 => 
                ap_NS_fsm <= ap_ST_fsm_state14;
            when ap_ST_fsm_state14 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXXXXXX";
        end case;
    end process;
    add_ln12_fu_321_p2 <= std_logic_vector(unsigned(q_reg_191) + unsigned(ap_const_lv3_1));
    add_ln17_fu_331_p2 <= std_logic_vector(unsigned(k_1_reg_215) + unsigned(ap_const_lv32_1));
    add_ln39_fu_346_p2 <= std_logic_vector(unsigned(i_reg_226) + unsigned(ap_const_lv15_1));
    add_ln44_fu_374_p2 <= std_logic_vector(unsigned(q_1_reg_249) + unsigned(ap_const_lv32_1));
    add_ln47_fu_411_p2 <= std_logic_vector(unsigned(empty_20_fu_90) + unsigned(ap_const_lv32_1));
    add_ln48_fu_418_p2 <= std_logic_vector(unsigned(trunc_ln33_fu_388_p1) + unsigned(ap_const_lv2_3));
    and_ln13_fu_316_p2 <= (icmp_ln13_reg_460 and icmp_ln13_1_fu_311_p2);
    ap_CS_fsm_pp1_stage0 <= ap_CS_fsm(8);
    ap_CS_fsm_pp1_stage1 <= ap_CS_fsm(9);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state12 <= ap_CS_fsm(10);
    ap_CS_fsm_state13 <= ap_CS_fsm(11);
    ap_CS_fsm_state14 <= ap_CS_fsm(12);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
    ap_CS_fsm_state6 <= ap_CS_fsm(5);
    ap_CS_fsm_state7 <= ap_CS_fsm(6);
    ap_CS_fsm_state8 <= ap_CS_fsm(7);
        ap_block_pp1_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage1_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp1_stage1_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state10_pp1_stage1_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state11_pp1_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state9_pp1_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_pp1_exit_iter0_state10_assign_proc : process(ap_predicate_tran10to12_state10)
    begin
        if ((ap_predicate_tran10to12_state10 = ap_const_boolean_1)) then 
            ap_condition_pp1_exit_iter0_state10 <= ap_const_logic_1;
        else 
            ap_condition_pp1_exit_iter0_state10 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_CS_fsm_state7, icmp_ln39_fu_352_p2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state7) and (icmp_ln39_fu_352_p2 = ap_const_lv1_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp1 <= (ap_idle_pp1 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp1_assign_proc : process(ap_enable_reg_pp1_iter1, ap_enable_reg_pp1_iter0)
    begin
        if (((ap_enable_reg_pp1_iter0 = ap_const_logic_0) and (ap_enable_reg_pp1_iter1 = ap_const_logic_0))) then 
            ap_idle_pp1 <= ap_const_logic_1;
        else 
            ap_idle_pp1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_q_1_phi_fu_252_p4_assign_proc : process(kmpNext_q0, q_1_reg_249, ap_CS_fsm_pp1_stage0, ap_enable_reg_pp1_iter1, icmp_ln40_reg_506, icmp_ln40_1_reg_521, ap_block_pp1_stage0)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (icmp_ln40_1_reg_521 = ap_const_lv1_0) and (icmp_ln40_reg_506 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp1_stage0) and (ap_enable_reg_pp1_iter1 = ap_const_logic_1))) then 
            ap_phi_mux_q_1_phi_fu_252_p4 <= kmpNext_q0;
        else 
            ap_phi_mux_q_1_phi_fu_252_p4 <= q_1_reg_249;
        end if; 
    end process;


    ap_phi_mux_q_3_phi_fu_264_p4_assign_proc : process(kmpNext_q0, icmp_ln46_reg_540, ap_CS_fsm_state14, q_3_reg_260)
    begin
        if (((icmp_ln46_reg_540 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state14))) then 
            ap_phi_mux_q_3_phi_fu_264_p4 <= kmpNext_q0;
        else 
            ap_phi_mux_q_3_phi_fu_264_p4 <= q_3_reg_260;
        end if; 
    end process;


    ap_predicate_tran10to12_state10_assign_proc : process(icmp_ln40_reg_506, grp_fu_272_p2)
    begin
                ap_predicate_tran10to12_state10 <= ((grp_fu_272_p2 = ap_const_lv1_1) or (icmp_ln40_reg_506 = ap_const_lv1_0));
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state7, icmp_ln39_fu_352_p2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state7) and (icmp_ln39_fu_352_p2 = ap_const_lv1_1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    grp_fu_272_p2 <= "1" when (pattern_q0 = input_load_reg_501) else "0";
    icmp_ln12_fu_283_p2 <= "1" when (q_reg_191 = ap_const_lv3_4) else "0";
    icmp_ln13_1_fu_311_p2 <= "0" when (pattern_q0 = pattern_load_reg_454) else "1";
    icmp_ln13_fu_300_p2 <= "1" when (signed(k_1_reg_215) > signed(ap_const_lv32_0)) else "0";
    icmp_ln16_fu_327_p2 <= "1" when (pattern_load_1_reg_470 = pattern_load_reg_454) else "0";
    icmp_ln39_fu_352_p2 <= "1" when (i_reg_226 = ap_const_lv15_7E9B) else "0";
    icmp_ln40_fu_363_p2 <= "1" when (signed(ap_phi_mux_q_1_phi_fu_252_p4) > signed(ap_const_lv32_0)) else "0";
    icmp_ln46_fu_402_p2 <= "1" when (signed(tmp_fu_392_p4) > signed(ap_const_lv30_0)) else "0";
    idxprom8_fu_369_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_phi_mux_q_1_phi_fu_252_p4),64));
    input_r_address0 <= zext_ln39_fu_358_p1(15 - 1 downto 0);

    input_r_ce0_assign_proc : process(ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            input_r_ce0 <= ap_const_logic_1;
        else 
            input_r_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    k_3_fu_337_p3 <= 
        add_ln17_fu_331_p2 when (icmp_ln16_fu_327_p2(0) = '1') else 
        k_1_reg_215;

    kmpNext_address0_assign_proc : process(ap_CS_fsm_state1, ap_CS_fsm_state2, kmpNext_addr_1_reg_442, ap_CS_fsm_state6, idxprom8_reg_510, ap_enable_reg_pp1_iter0, ap_CS_fsm_pp1_stage1, ap_CS_fsm_state13, zext_ln12_fu_289_p1, ap_block_pp1_stage1, zext_ln48_fu_424_p1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state13)) then 
            kmpNext_address0 <= zext_ln48_fu_424_p1(2 - 1 downto 0);
        elsif (((ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage1))) then 
            kmpNext_address0 <= idxprom8_reg_510(2 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            kmpNext_address0 <= kmpNext_addr_1_reg_442;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            kmpNext_address0 <= zext_ln12_fu_289_p1(2 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
            kmpNext_address0 <= ap_const_lv64_0(2 - 1 downto 0);
        else 
            kmpNext_address0 <= "XX";
        end if; 
    end process;


    kmpNext_ce0_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state2, ap_CS_fsm_state6, ap_enable_reg_pp1_iter0, ap_CS_fsm_pp1_stage1, ap_block_pp1_stage1_11001, ap_CS_fsm_state13)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state13) or (ap_const_logic_1 = ap_CS_fsm_state6) or (ap_const_logic_1 = ap_CS_fsm_state2) or ((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1)) or ((ap_const_logic_1 = ap_CS_fsm_pp1_stage1) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage1_11001)))) then 
            kmpNext_ce0 <= ap_const_logic_1;
        else 
            kmpNext_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    kmpNext_d0_assign_proc : process(ap_CS_fsm_state1, ap_CS_fsm_state6, k_3_fu_337_p3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            kmpNext_d0 <= k_3_fu_337_p3;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
            kmpNext_d0 <= ap_const_lv32_0;
        else 
            kmpNext_d0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    kmpNext_we0_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state6)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state6) or ((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            kmpNext_we0 <= ap_const_logic_1;
        else 
            kmpNext_we0 <= ap_const_logic_0;
        end if; 
    end process;


    n_matches_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state13, icmp_ln46_fu_402_p2, add_ln47_fu_411_p2)
    begin
        if (((icmp_ln46_fu_402_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state13))) then 
            n_matches <= add_ln47_fu_411_p2;
        elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            n_matches <= ap_const_lv32_0;
        else 
            n_matches <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    n_matches_ap_vld_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state13, icmp_ln46_fu_402_p2)
    begin
        if ((((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1)) or ((icmp_ln46_fu_402_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state13)))) then 
            n_matches_ap_vld <= ap_const_logic_1;
        else 
            n_matches_ap_vld <= ap_const_logic_0;
        end if; 
    end process;


    pattern_address0_assign_proc : process(ap_CS_fsm_pp1_stage0, ap_CS_fsm_state2, ap_CS_fsm_state4, idxprom8_fu_369_p1, idxprom8_reg_510, ap_enable_reg_pp1_iter0, ap_CS_fsm_state12, ap_block_pp1_stage0, zext_ln12_fu_289_p1, zext_ln16_fu_306_p1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state12)) then 
            pattern_address0 <= idxprom8_reg_510(2 - 1 downto 0);
        elsif (((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0))) then 
            pattern_address0 <= idxprom8_fu_369_p1(2 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            pattern_address0 <= zext_ln16_fu_306_p1(2 - 1 downto 0);
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            pattern_address0 <= zext_ln12_fu_289_p1(2 - 1 downto 0);
        else 
            pattern_address0 <= "XX";
        end if; 
    end process;


    pattern_ce0_assign_proc : process(ap_CS_fsm_pp1_stage0, ap_block_pp1_stage0_11001, ap_CS_fsm_state2, ap_CS_fsm_state4, ap_enable_reg_pp1_iter0, ap_CS_fsm_state12)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state12) or (ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state2) or ((ap_const_logic_1 = ap_CS_fsm_pp1_stage0) and (ap_enable_reg_pp1_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp1_stage0_11001)))) then 
            pattern_ce0 <= ap_const_logic_1;
        else 
            pattern_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    q_4_fu_380_p3 <= 
        add_ln44_fu_374_p2 when (grp_fu_272_p2(0) = '1') else 
        q_1_reg_249;
    tmp_fu_392_p4 <= q_4_fu_380_p3(31 downto 2);
    trunc_ln33_fu_388_p1 <= q_4_fu_380_p3(2 - 1 downto 0);
    zext_ln12_fu_289_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(q_reg_191),64));
    zext_ln16_fu_306_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(k_1_reg_215),64));
    zext_ln39_fu_358_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_reg_226),64));
    zext_ln48_fu_424_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(add_ln48_fu_418_p2),64));
end behav;
