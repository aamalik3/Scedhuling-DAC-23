-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity md_BUS_A_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 17;
    C_S_AXI_DATA_WIDTH    : INTEGER := 32);
port (
    ACLK                  :in   STD_LOGIC;
    ARESET                :in   STD_LOGIC;
    ACLK_EN               :in   STD_LOGIC;
    AWADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    AWVALID               :in   STD_LOGIC;
    AWREADY               :out  STD_LOGIC;
    WDATA                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    WSTRB                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    WVALID                :in   STD_LOGIC;
    WREADY                :out  STD_LOGIC;
    BRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    BVALID                :out  STD_LOGIC;
    BREADY                :in   STD_LOGIC;
    ARADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    ARVALID               :in   STD_LOGIC;
    ARREADY               :out  STD_LOGIC;
    RDATA                 :out  STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    RRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    RVALID                :out  STD_LOGIC;
    RREADY                :in   STD_LOGIC;
    interrupt             :out  STD_LOGIC;
    n_points_address0     :in   STD_LOGIC_VECTOR(5 downto 0);
    n_points_ce0          :in   STD_LOGIC;
    n_points_q0           :out  STD_LOGIC_VECTOR(31 downto 0);
    force_r_address0      :in   STD_LOGIC_VECTOR(9 downto 0);
    force_r_ce0           :in   STD_LOGIC;
    force_r_we0           :in   STD_LOGIC;
    force_r_d0            :in   STD_LOGIC_VECTOR(191 downto 0);
    force_r_q0            :out  STD_LOGIC_VECTOR(191 downto 0);
    position_address0     :in   STD_LOGIC_VECTOR(9 downto 0);
    position_ce0          :in   STD_LOGIC;
    position_q0           :out  STD_LOGIC_VECTOR(191 downto 0);
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC
);
end entity md_BUS_A_s_axi;

-- ------------------------Address Info-------------------
-- 0x00000 : Control signals
--           bit 0  - ap_start (Read/Write/COH)
--           bit 1  - ap_done (Read/COR)
--           bit 2  - ap_idle (Read)
--           bit 3  - ap_ready (Read)
--           bit 7  - auto_restart (Read/Write)
--           others - reserved
-- 0x00004 : Global Interrupt Enable Register
--           bit 0  - Global Interrupt Enable (Read/Write)
--           others - reserved
-- 0x00008 : IP Interrupt Enable Register (Read/Write)
--           bit 0  - enable ap_done interrupt (Read/Write)
--           bit 1  - enable ap_ready interrupt (Read/Write)
--           others - reserved
-- 0x0000c : IP Interrupt Status Register (Read/TOW)
--           bit 0  - ap_done (COR/TOW)
--           bit 1  - ap_ready (COR/TOW)
--           others - reserved
-- 0x00100 ~
-- 0x001ff : Memory 'n_points' (64 * 32b)
--           Word n : bit [31:0] - n_points[n]
-- 0x08000 ~
-- 0x0ffff : Memory 'force_r' (640 * 192b)
--           Word 8n   : bit [31:0] - force_r[n][31: 0]
--           Word 8n+1 : bit [31:0] - force_r[n][63:32]
--           Word 8n+2 : bit [31:0] - force_r[n][95:64]
--           Word 8n+3 : bit [31:0] - force_r[n][127:96]
--           Word 8n+4 : bit [31:0] - force_r[n][159:128]
--           Word 8n+5 : bit [31:0] - force_r[n][191:160]
--           Word 8n+6 : bit [31:0] - reserved
--           Word 8n+7 : bit [31:0] - reserved
-- 0x10000 ~
-- 0x17fff : Memory 'position' (640 * 192b)
--           Word 8n   : bit [31:0] - position[n][31: 0]
--           Word 8n+1 : bit [31:0] - position[n][63:32]
--           Word 8n+2 : bit [31:0] - position[n][95:64]
--           Word 8n+3 : bit [31:0] - position[n][127:96]
--           Word 8n+4 : bit [31:0] - position[n][159:128]
--           Word 8n+5 : bit [31:0] - position[n][191:160]
--           Word 8n+6 : bit [31:0] - reserved
--           Word 8n+7 : bit [31:0] - reserved
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of md_BUS_A_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL       : INTEGER := 16#00000#;
    constant ADDR_GIE           : INTEGER := 16#00004#;
    constant ADDR_IER           : INTEGER := 16#00008#;
    constant ADDR_ISR           : INTEGER := 16#0000c#;
    constant ADDR_N_POINTS_BASE : INTEGER := 16#00100#;
    constant ADDR_N_POINTS_HIGH : INTEGER := 16#001ff#;
    constant ADDR_FORCE_R_BASE  : INTEGER := 16#08000#;
    constant ADDR_FORCE_R_HIGH  : INTEGER := 16#0ffff#;
    constant ADDR_POSITION_BASE : INTEGER := 16#10000#;
    constant ADDR_POSITION_HIGH : INTEGER := 16#17fff#;
    constant ADDR_BITS         : INTEGER := 17;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_ap_idle         : STD_LOGIC;
    signal int_ap_ready        : STD_LOGIC;
    signal int_ap_done         : STD_LOGIC := '0';
    signal int_ap_start        : STD_LOGIC := '0';
    signal int_auto_restart    : STD_LOGIC := '0';
    signal int_gie             : STD_LOGIC := '0';
    signal int_ier             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_isr             : UNSIGNED(1 downto 0) := (others => '0');
    -- memory signals
    signal int_n_points_address0 : UNSIGNED(5 downto 0);
    signal int_n_points_ce0    : STD_LOGIC;
    signal int_n_points_we0    : STD_LOGIC;
    signal int_n_points_be0    : UNSIGNED(3 downto 0);
    signal int_n_points_d0     : UNSIGNED(31 downto 0);
    signal int_n_points_q0     : UNSIGNED(31 downto 0);
    signal int_n_points_address1 : UNSIGNED(5 downto 0);
    signal int_n_points_ce1    : STD_LOGIC;
    signal int_n_points_we1    : STD_LOGIC;
    signal int_n_points_be1    : UNSIGNED(3 downto 0);
    signal int_n_points_d1     : UNSIGNED(31 downto 0);
    signal int_n_points_q1     : UNSIGNED(31 downto 0);
    signal int_n_points_read   : STD_LOGIC;
    signal int_n_points_write  : STD_LOGIC;
    signal int_force_r_address0 : UNSIGNED(9 downto 0);
    signal int_force_r_ce0     : STD_LOGIC;
    signal int_force_r_we0     : STD_LOGIC;
    signal int_force_r_be0     : UNSIGNED(23 downto 0);
    signal int_force_r_d0      : UNSIGNED(191 downto 0);
    signal int_force_r_q0      : UNSIGNED(191 downto 0);
    signal int_force_r_address1 : UNSIGNED(9 downto 0);
    signal int_force_r_ce1     : STD_LOGIC;
    signal int_force_r_we1     : STD_LOGIC;
    signal int_force_r_be1     : UNSIGNED(23 downto 0);
    signal int_force_r_d1      : UNSIGNED(191 downto 0);
    signal int_force_r_q1      : UNSIGNED(191 downto 0);
    signal int_force_r_read    : STD_LOGIC;
    signal int_force_r_write   : STD_LOGIC;
    signal int_force_r_shift   : UNSIGNED(2 downto 0);
    signal int_position_address0 : UNSIGNED(9 downto 0);
    signal int_position_ce0    : STD_LOGIC;
    signal int_position_we0    : STD_LOGIC;
    signal int_position_be0    : UNSIGNED(23 downto 0);
    signal int_position_d0     : UNSIGNED(191 downto 0);
    signal int_position_q0     : UNSIGNED(191 downto 0);
    signal int_position_address1 : UNSIGNED(9 downto 0);
    signal int_position_ce1    : STD_LOGIC;
    signal int_position_we1    : STD_LOGIC;
    signal int_position_be1    : UNSIGNED(23 downto 0);
    signal int_position_d1     : UNSIGNED(191 downto 0);
    signal int_position_q1     : UNSIGNED(191 downto 0);
    signal int_position_read   : STD_LOGIC;
    signal int_position_write  : STD_LOGIC;
    signal int_position_shift  : UNSIGNED(2 downto 0);

    component md_BUS_A_s_axi_ram is
        generic (
            BYTES   : INTEGER :=4;
            DEPTH   : INTEGER :=256;
            AWIDTH  : INTEGER :=8);
        port (
            clk0    : in  STD_LOGIC;
            address0: in  UNSIGNED(AWIDTH-1 downto 0);
            ce0     : in  STD_LOGIC;
            we0     : in  STD_LOGIC;
            be0     : in  UNSIGNED(BYTES-1 downto 0);
            d0      : in  UNSIGNED(BYTES*8-1 downto 0);
            q0      : out UNSIGNED(BYTES*8-1 downto 0);
            clk1    : in  STD_LOGIC;
            address1: in  UNSIGNED(AWIDTH-1 downto 0);
            ce1     : in  STD_LOGIC;
            we1     : in  STD_LOGIC;
            be1     : in  UNSIGNED(BYTES-1 downto 0);
            d1      : in  UNSIGNED(BYTES*8-1 downto 0);
            q1      : out UNSIGNED(BYTES*8-1 downto 0));
    end component md_BUS_A_s_axi_ram;

    function log2 (x : INTEGER) return INTEGER is
        variable n, m : INTEGER;
    begin
        n := 1;
        m := 2;
        while m < x loop
            n := n + 1;
            m := m * 2;
        end loop;
        return n;
    end function log2;

begin
-- ----------------------- Instantiation------------------
-- int_n_points
int_n_points : md_BUS_A_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 64,
     AWIDTH   => log2(64))
port map (
     clk0     => ACLK,
     address0 => int_n_points_address0,
     ce0      => int_n_points_ce0,
     we0      => int_n_points_we0,
     be0      => int_n_points_be0,
     d0       => int_n_points_d0,
     q0       => int_n_points_q0,
     clk1     => ACLK,
     address1 => int_n_points_address1,
     ce1      => int_n_points_ce1,
     we1      => int_n_points_we1,
     be1      => int_n_points_be1,
     d1       => int_n_points_d1,
     q1       => int_n_points_q1);
-- int_force_r
int_force_r : md_BUS_A_s_axi_ram
generic map (
     BYTES    => 24,
     DEPTH    => 640,
     AWIDTH   => log2(640))
port map (
     clk0     => ACLK,
     address0 => int_force_r_address0,
     ce0      => int_force_r_ce0,
     we0      => int_force_r_we0,
     be0      => int_force_r_be0,
     d0       => int_force_r_d0,
     q0       => int_force_r_q0,
     clk1     => ACLK,
     address1 => int_force_r_address1,
     ce1      => int_force_r_ce1,
     we1      => int_force_r_we1,
     be1      => int_force_r_be1,
     d1       => int_force_r_d1,
     q1       => int_force_r_q1);
-- int_position
int_position : md_BUS_A_s_axi_ram
generic map (
     BYTES    => 24,
     DEPTH    => 640,
     AWIDTH   => log2(640))
port map (
     clk0     => ACLK,
     address0 => int_position_address0,
     ce0      => int_position_ce0,
     we0      => int_position_we0,
     be0      => int_position_be0,
     d0       => int_position_d0,
     q0       => int_position_q0,
     clk1     => ACLK,
     address1 => int_position_address1,
     ce1      => int_position_ce1,
     we1      => int_position_we1,
     be1      => int_position_be1,
     d1       => int_position_d1,
     q1       => int_position_q1);


-- ----------------------- AXI WRITE ---------------------
    AWREADY_t <=  '1' when wstate = wridle else '0';
    AWREADY   <=  AWREADY_t;
    WREADY_t  <=  '1' when wstate = wrdata and ar_hs = '0' else '0';
    WREADY    <=  WREADY_t;
    BRESP     <=  "00";  -- OKAY
    BVALID    <=  '1' when wstate = wrresp else '0';
    wmask     <=  (31 downto 24 => WSTRB(3), 23 downto 16 => WSTRB(2), 15 downto 8 => WSTRB(1), 7 downto 0 => WSTRB(0));
    aw_hs     <=  AWVALID and AWREADY_t;
    w_hs      <=  WVALID and WREADY_t;

    -- write FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                wstate <= wrreset;
            elsif (ACLK_EN = '1') then
                wstate <= wnext;
            end if;
        end if;
    end process;

    process (wstate, AWVALID, w_hs, BREADY)
    begin
        case (wstate) is
        when wridle =>
            if (AWVALID = '1') then
                wnext <= wrdata;
            else
                wnext <= wridle;
            end if;
        when wrdata =>
            if (w_hs = '1') then
                wnext <= wrresp;
            else
                wnext <= wrdata;
            end if;
        when wrresp =>
            if (BREADY = '1') then
                wnext <= wridle;
            else
                wnext <= wrresp;
            end if;
        when others =>
            wnext <= wridle;
        end case;
    end process;

    waddr_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (aw_hs = '1') then
                    waddr <= UNSIGNED(AWADDR(ADDR_BITS-1 downto 0));
                end if;
            end if;
        end if;
    end process;

-- ----------------------- AXI READ ----------------------
    ARREADY_t <= '1' when (rstate = rdidle) else '0';
    ARREADY <= ARREADY_t;
    RDATA   <= STD_LOGIC_VECTOR(rdata_data);
    RRESP   <= "00";  -- OKAY
    RVALID_t  <= '1' when (rstate = rddata) and (int_n_points_read = '0') and (int_force_r_read = '0') and (int_position_read = '0') else '0';
    RVALID    <= RVALID_t;
    ar_hs   <= ARVALID and ARREADY_t;
    raddr   <= UNSIGNED(ARADDR(ADDR_BITS-1 downto 0));

    -- read FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                rstate <= rdreset;
            elsif (ACLK_EN = '1') then
                rstate <= rnext;
            end if;
        end if;
    end process;

    process (rstate, ARVALID, RREADY, RVALID_t)
    begin
        case (rstate) is
        when rdidle =>
            if (ARVALID = '1') then
                rnext <= rddata;
            else
                rnext <= rdidle;
            end if;
        when rddata =>
            if (RREADY = '1' and RVALID_t = '1') then
                rnext <= rdidle;
            else
                rnext <= rddata;
            end if;
        when others =>
            rnext <= rdidle;
        end case;
    end process;

    rdata_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    rdata_data <= (others => '0');
                    case (TO_INTEGER(raddr)) is
                    when ADDR_AP_CTRL =>
                        rdata_data(7) <= int_auto_restart;
                        rdata_data(3) <= int_ap_ready;
                        rdata_data(2) <= int_ap_idle;
                        rdata_data(1) <= int_ap_done;
                        rdata_data(0) <= int_ap_start;
                    when ADDR_GIE =>
                        rdata_data(0) <= int_gie;
                    when ADDR_IER =>
                        rdata_data(1 downto 0) <= int_ier;
                    when ADDR_ISR =>
                        rdata_data(1 downto 0) <= int_isr;
                    when others =>
                        NULL;
                    end case;
                elsif (int_n_points_read = '1') then
                    rdata_data <= int_n_points_q1;
                elsif (int_force_r_read = '1') then
                    rdata_data <= RESIZE(SHIFT_RIGHT(int_force_r_q1, TO_INTEGER(int_force_r_shift)*32), 32);
                elsif (int_position_read = '1') then
                    rdata_data <= RESIZE(SHIFT_RIGHT(int_position_q1, TO_INTEGER(int_position_shift)*32), 32);
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    interrupt            <= int_gie and (int_isr(0) or int_isr(1));
    ap_start             <= int_ap_start;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_start <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' and WDATA(0) = '1') then
                    int_ap_start <= '1';
                elsif (ap_ready = '1') then
                    int_ap_start <= int_auto_restart; -- clear on handshake/auto restart
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_done <= '0';
            elsif (ACLK_EN = '1') then
                if (ap_done = '1') then
                    int_ap_done <= '1';
                elsif (ar_hs = '1' and raddr = ADDR_AP_CTRL) then
                    int_ap_done <= '0'; -- clear on read
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_idle <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_idle <= ap_idle;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_ready <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_ready <= ap_ready;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_auto_restart <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1') then
                    int_auto_restart <= WDATA(7);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_gie <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_GIE and WSTRB(0) = '1') then
                    int_gie <= WDATA(0);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ier <= "00";
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_IER and WSTRB(0) = '1') then
                    int_ier <= UNSIGNED(WDATA(1 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(0) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(0) = '1' and ap_done = '1') then
                    int_isr(0) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(0) <= int_isr(0) xor WDATA(0); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(1) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(1) = '1' and ap_ready = '1') then
                    int_isr(1) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(1) <= int_isr(1) xor WDATA(1); -- toggle on write
                end if;
            end if;
        end if;
    end process;


-- ----------------------- Memory logic ------------------
    -- n_points
    int_n_points_address0 <= UNSIGNED(n_points_address0);
    int_n_points_ce0     <= n_points_ce0;
    int_n_points_we0     <= '0';
    int_n_points_be0     <= (others => '0');
    int_n_points_d0      <= (others => '0');
    n_points_q0          <= STD_LOGIC_VECTOR(RESIZE(int_n_points_q0, 32));
    int_n_points_address1 <= raddr(7 downto 2) when ar_hs = '1' else waddr(7 downto 2);
    int_n_points_ce1     <= '1' when ar_hs = '1' or (int_n_points_write = '1' and WVALID  = '1') else '0';
    int_n_points_we1     <= '1' when int_n_points_write = '1' and w_hs = '1' else '0';
    int_n_points_be1     <= UNSIGNED(WSTRB);
    int_n_points_d1      <= UNSIGNED(WDATA);
    -- force_r
    int_force_r_address0 <= UNSIGNED(force_r_address0);
    int_force_r_ce0      <= force_r_ce0;
    int_force_r_we0      <= force_r_we0;
    int_force_r_be0      <= (others => force_r_we0);
    int_force_r_d0       <= RESIZE(UNSIGNED(force_r_d0), 192);
    force_r_q0           <= STD_LOGIC_VECTOR(RESIZE(int_force_r_q0, 192));
    int_force_r_address1 <= raddr(14 downto 5) when ar_hs = '1' else waddr(14 downto 5);
    int_force_r_ce1      <= '1' when ar_hs = '1' or (int_force_r_write = '1' and WVALID  = '1') else '0';
    int_force_r_we1      <= '1' when int_force_r_write = '1' and w_hs = '1' else '0';
    int_force_r_be1      <= SHIFT_LEFT(RESIZE(UNSIGNED(WSTRB), 24), TO_INTEGER(waddr(4 downto 2)) * 4);
    int_force_r_d1       <= RESIZE(UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA), 192);
    -- position
    int_position_address0 <= UNSIGNED(position_address0);
    int_position_ce0     <= position_ce0;
    int_position_we0     <= '0';
    int_position_be0     <= (others => '0');
    int_position_d0      <= (others => '0');
    position_q0          <= STD_LOGIC_VECTOR(RESIZE(int_position_q0, 192));
    int_position_address1 <= raddr(14 downto 5) when ar_hs = '1' else waddr(14 downto 5);
    int_position_ce1     <= '1' when ar_hs = '1' or (int_position_write = '1' and WVALID  = '1') else '0';
    int_position_we1     <= '1' when int_position_write = '1' and w_hs = '1' else '0';
    int_position_be1     <= SHIFT_LEFT(RESIZE(UNSIGNED(WSTRB), 24), TO_INTEGER(waddr(4 downto 2)) * 4);
    int_position_d1      <= RESIZE(UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA) & UNSIGNED(WDATA), 192);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_n_points_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_N_POINTS_BASE and raddr <= ADDR_N_POINTS_HIGH) then
                    int_n_points_read <= '1';
                else
                    int_n_points_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_n_points_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_N_POINTS_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_N_POINTS_HIGH) then
                    int_n_points_write <= '1';
                elsif (w_hs = '1') then
                    int_n_points_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_force_r_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_FORCE_R_BASE and raddr <= ADDR_FORCE_R_HIGH) then
                    int_force_r_read <= '1';
                else
                    int_force_r_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_force_r_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_FORCE_R_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_FORCE_R_HIGH) then
                    int_force_r_write <= '1';
                elsif (w_hs = '1') then
                    int_force_r_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    int_force_r_shift <= raddr(4 downto 2);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_position_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_POSITION_BASE and raddr <= ADDR_POSITION_HIGH) then
                    int_position_read <= '1';
                else
                    int_position_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_position_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_POSITION_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_POSITION_HIGH) then
                    int_position_write <= '1';
                elsif (w_hs = '1') then
                    int_position_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    int_position_shift <= raddr(4 downto 2);
                end if;
            end if;
        end if;
    end process;


end architecture behave;

library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity md_BUS_A_s_axi_ram is
    generic (
        BYTES   : INTEGER :=4;
        DEPTH   : INTEGER :=256;
        AWIDTH  : INTEGER :=8);
    port (
        clk0    : in  STD_LOGIC;
        address0: in  UNSIGNED(AWIDTH-1 downto 0);
        ce0     : in  STD_LOGIC;
        we0     : in  STD_LOGIC;
        be0     : in  UNSIGNED(BYTES-1 downto 0);
        d0      : in  UNSIGNED(BYTES*8-1 downto 0);
        q0      : out UNSIGNED(BYTES*8-1 downto 0);
        clk1    : in  STD_LOGIC;
        address1: in  UNSIGNED(AWIDTH-1 downto 0);
        ce1     : in  STD_LOGIC;
        we1     : in  STD_LOGIC;
        be1     : in  UNSIGNED(BYTES-1 downto 0);
        d1      : in  UNSIGNED(BYTES*8-1 downto 0);
        q1      : out UNSIGNED(BYTES*8-1 downto 0));

end entity md_BUS_A_s_axi_ram;

architecture behave of md_BUS_A_s_axi_ram is
    signal address0_tmp : UNSIGNED(AWIDTH-1 downto 0);
    signal address1_tmp : UNSIGNED(AWIDTH-1 downto 0);
    type RAM_T is array (0 to DEPTH - 1) of UNSIGNED(BYTES*8 - 1 downto 0);
    shared variable mem : RAM_T := (others => (others => '0'));
begin

    process (address0)
    begin
    address0_tmp <= address0;
    --synthesis translate_off
          if (address0 > DEPTH-1) then
              address0_tmp <= (others => '0');
          else
              address0_tmp <= address0;
          end if;
    --synthesis translate_on
    end process;

    process (address1)
    begin
    address1_tmp <= address1;
    --synthesis translate_off
          if (address1 > DEPTH-1) then
              address1_tmp <= (others => '0');
          else
              address1_tmp <= address1;
          end if;
    --synthesis translate_on
    end process;

    --read port 0
    process (clk0) begin
        if (clk0'event and clk0 = '1') then
            if (ce0 = '1') then
                q0 <= mem(to_integer(address0_tmp));
            end if;
        end if;
    end process;

    --read port 1
    process (clk1) begin
        if (clk1'event and clk1 = '1') then
            if (ce1 = '1') then
                q1 <= mem(to_integer(address1_tmp));
            end if;
        end if;
    end process;

    gen_write : for i in 0 to BYTES - 1 generate
    begin
        --write port 0
        process (clk0)
        begin
            if (clk0'event and clk0 = '1') then
                if (ce0 = '1' and we0 = '1' and be0(i) = '1') then
                    mem(to_integer(address0_tmp))(8*i+7 downto 8*i) := d0(8*i+7 downto 8*i);
                end if;
            end if;
        end process;

        --write port 1
        process (clk1)
        begin
            if (clk1'event and clk1 = '1') then
                if (ce1 = '1' and we1 = '1' and be1(i) = '1') then
                    mem(to_integer(address1_tmp))(8*i+7 downto 8*i) := d1(8*i+7 downto 8*i);
                end if;
            end if;
        end process;

    end generate;

end architecture behave;


