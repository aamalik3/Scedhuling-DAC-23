-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ms_mergesort is
generic (
    C_S_AXI_BUS_A_ADDR_WIDTH : INTEGER := 14;
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


architecture behav of ms_mergesort is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "ms_mergesort_ms_mergesort,hls_ip_2020_2,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg484-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=9.365750,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=8,HLS_SYN_DSP=0,HLS_SYN_FF=823,HLS_SYN_LUT=1112,HLS_VERSION=2020_2}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (5 downto 0) := "000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (5 downto 0) := "000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (5 downto 0) := "001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (5 downto 0) := "010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (5 downto 0) := "100000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_800 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000100000000000";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv21_1 : STD_LOGIC_VECTOR (20 downto 0) := "000000000000000000001";
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_rst_n_inv : STD_LOGIC;
    signal ap_start : STD_LOGIC;
    signal ap_done : STD_LOGIC;
    signal ap_idle : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_ready : STD_LOGIC;
    signal a_ce0 : STD_LOGIC;
    signal a_we0 : STD_LOGIC;
    signal a_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal m_1_fu_105_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal m_1_reg_169 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal icmp_ln43_fu_99_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal mid_fu_133_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal mid_reg_178 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal icmp_ln44_fu_121_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal to_fu_139_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal to_reg_183 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln48_fu_155_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln48_reg_188 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_fu_161_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal grp_merge_1_fu_78_ap_start : STD_LOGIC;
    signal grp_merge_1_fu_78_ap_done : STD_LOGIC;
    signal grp_merge_1_fu_78_ap_idle : STD_LOGIC;
    signal grp_merge_1_fu_78_ap_ready : STD_LOGIC;
    signal grp_merge_1_fu_78_a_address0 : STD_LOGIC_VECTOR (10 downto 0);
    signal grp_merge_1_fu_78_a_ce0 : STD_LOGIC;
    signal grp_merge_1_fu_78_a_we0 : STD_LOGIC;
    signal grp_merge_1_fu_78_a_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_merge_1_fu_78_stop : STD_LOGIC_VECTOR (31 downto 0);
    signal m_reg_54 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_2_reg_66 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_state5_on_subcall_done : BOOLEAN;
    signal grp_merge_1_fu_78_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal tmp_fu_89_p4 : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_1_fu_111_p4 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln46_fu_127_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_2_fu_145_p4 : STD_LOGIC_VECTOR (20 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component ms_mergesort_merge_1 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        a_address0 : OUT STD_LOGIC_VECTOR (10 downto 0);
        a_ce0 : OUT STD_LOGIC;
        a_we0 : OUT STD_LOGIC;
        a_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        a_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        start_r : IN STD_LOGIC_VECTOR (31 downto 0);
        m : IN STD_LOGIC_VECTOR (31 downto 0);
        stop : IN STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component ms_mergesort_BUS_A_s_axi IS
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
        a_address0 : IN STD_LOGIC_VECTOR (10 downto 0);
        a_ce0 : IN STD_LOGIC;
        a_we0 : IN STD_LOGIC;
        a_d0 : IN STD_LOGIC_VECTOR (31 downto 0);
        a_q0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ap_start : OUT STD_LOGIC;
        interrupt : OUT STD_LOGIC;
        ap_ready : IN STD_LOGIC;
        ap_done : IN STD_LOGIC;
        ap_idle : IN STD_LOGIC );
    end component;



begin
    BUS_A_s_axi_U : component ms_mergesort_BUS_A_s_axi
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
        a_address0 => grp_merge_1_fu_78_a_address0,
        a_ce0 => a_ce0,
        a_we0 => a_we0,
        a_d0 => grp_merge_1_fu_78_a_d0,
        a_q0 => a_q0,
        ap_start => ap_start,
        interrupt => interrupt,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_idle => ap_idle);

    grp_merge_1_fu_78 : component ms_mergesort_merge_1
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => grp_merge_1_fu_78_ap_start,
        ap_done => grp_merge_1_fu_78_ap_done,
        ap_idle => grp_merge_1_fu_78_ap_idle,
        ap_ready => grp_merge_1_fu_78_ap_ready,
        a_address0 => grp_merge_1_fu_78_a_address0,
        a_ce0 => grp_merge_1_fu_78_a_ce0,
        a_we0 => grp_merge_1_fu_78_a_we0,
        a_d0 => grp_merge_1_fu_78_a_d0,
        a_q0 => a_q0,
        start_r => i_2_reg_66,
        m => mid_reg_178,
        stop => grp_merge_1_fu_78_stop);





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


    grp_merge_1_fu_78_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                grp_merge_1_fu_78_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_state6) or (ap_const_logic_1 = ap_CS_fsm_state4))) then 
                    grp_merge_1_fu_78_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_merge_1_fu_78_ap_ready = ap_const_logic_1)) then 
                    grp_merge_1_fu_78_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_2_reg_66_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state5) and (ap_const_boolean_0 = ap_block_state5_on_subcall_done))) then 
                i_2_reg_66 <= i_fu_161_p2;
            elsif (((icmp_ln43_fu_99_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                i_2_reg_66 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;

    m_reg_54_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln44_fu_121_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
                m_reg_54 <= m_1_reg_169;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                m_reg_54 <= ap_const_lv32_1;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln44_fu_121_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                icmp_ln48_reg_188 <= icmp_ln48_fu_155_p2;
                mid_reg_178 <= mid_fu_133_p2;
                to_reg_183 <= to_fu_139_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln43_fu_99_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    m_1_reg_169(31 downto 1) <= m_1_fu_105_p2(31 downto 1);
            end if;
        end if;
    end process;
    m_1_reg_169(0) <= '0';

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, icmp_ln43_fu_99_p2, ap_CS_fsm_state3, icmp_ln44_fu_121_p2, icmp_ln48_fu_155_p2, ap_CS_fsm_state5, ap_block_state5_on_subcall_done)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln43_fu_99_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state3 => 
                if (((icmp_ln44_fu_121_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                elsif (((icmp_ln48_fu_155_p2 = ap_const_lv1_1) and (icmp_ln44_fu_121_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state5) and (ap_const_boolean_0 = ap_block_state5_on_subcall_done))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when others =>  
                ap_NS_fsm <= "XXXXXX";
        end case;
    end process;

    a_ce0_assign_proc : process(icmp_ln48_reg_188, ap_CS_fsm_state5, grp_merge_1_fu_78_a_ce0)
    begin
        if ((((icmp_ln48_reg_188 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state5)) or ((icmp_ln48_reg_188 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5)))) then 
            a_ce0 <= grp_merge_1_fu_78_a_ce0;
        else 
            a_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    a_we0_assign_proc : process(icmp_ln48_reg_188, ap_CS_fsm_state5, grp_merge_1_fu_78_a_we0)
    begin
        if ((((icmp_ln48_reg_188 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state5)) or ((icmp_ln48_reg_188 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5)))) then 
            a_we0 <= grp_merge_1_fu_78_a_we0;
        else 
            a_we0 <= ap_const_logic_0;
        end if; 
    end process;

    add_ln46_fu_127_p2 <= std_logic_vector(unsigned(i_2_reg_66) + unsigned(m_reg_54));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
    ap_CS_fsm_state6 <= ap_CS_fsm(5);

    ap_block_state5_on_subcall_done_assign_proc : process(icmp_ln48_reg_188, grp_merge_1_fu_78_ap_done)
    begin
                ap_block_state5_on_subcall_done <= (((icmp_ln48_reg_188 = ap_const_lv1_1) and (grp_merge_1_fu_78_ap_done = ap_const_logic_0)) or ((icmp_ln48_reg_188 = ap_const_lv1_0) and (grp_merge_1_fu_78_ap_done = ap_const_logic_0)));
    end process;


    ap_done_assign_proc : process(ap_CS_fsm_state2, icmp_ln43_fu_99_p2)
    begin
        if (((icmp_ln43_fu_99_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state2, icmp_ln43_fu_99_p2)
    begin
        if (((icmp_ln43_fu_99_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    grp_merge_1_fu_78_ap_start <= grp_merge_1_fu_78_ap_start_reg;

    grp_merge_1_fu_78_stop_assign_proc : process(to_reg_183, icmp_ln48_reg_188, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then
            if ((icmp_ln48_reg_188 = ap_const_lv1_1)) then 
                grp_merge_1_fu_78_stop <= to_reg_183;
            elsif ((icmp_ln48_reg_188 = ap_const_lv1_0)) then 
                grp_merge_1_fu_78_stop <= ap_const_lv32_800;
            else 
                grp_merge_1_fu_78_stop <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            grp_merge_1_fu_78_stop <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    i_fu_161_p2 <= std_logic_vector(unsigned(m_1_reg_169) + unsigned(i_2_reg_66));
    icmp_ln43_fu_99_p2 <= "1" when (signed(tmp_fu_89_p4) < signed(ap_const_lv21_1)) else "0";
    icmp_ln44_fu_121_p2 <= "1" when (signed(tmp_1_fu_111_p4) < signed(ap_const_lv21_1)) else "0";
    icmp_ln48_fu_155_p2 <= "1" when (signed(tmp_2_fu_145_p4) < signed(ap_const_lv21_1)) else "0";
    m_1_fu_105_p2 <= std_logic_vector(shift_left(unsigned(m_reg_54),to_integer(unsigned('0' & ap_const_lv32_1(31-1 downto 0)))));
    mid_fu_133_p2 <= std_logic_vector(unsigned(add_ln46_fu_127_p2) + unsigned(ap_const_lv32_FFFFFFFF));
    tmp_1_fu_111_p4 <= i_2_reg_66(31 downto 11);
    tmp_2_fu_145_p4 <= to_fu_139_p2(31 downto 11);
    tmp_fu_89_p4 <= m_reg_54(31 downto 11);
    to_fu_139_p2 <= std_logic_vector(unsigned(mid_fu_133_p2) + unsigned(m_reg_54));
end behav;
