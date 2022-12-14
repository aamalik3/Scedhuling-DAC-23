-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity spmv_BUS_A_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 16;
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
    rowDelimiters_address0 :in   STD_LOGIC_VECTOR(8 downto 0);
    rowDelimiters_ce0     :in   STD_LOGIC;
    rowDelimiters_q0      :out  STD_LOGIC_VECTOR(31 downto 0);
    vec_address0          :in   STD_LOGIC_VECTOR(8 downto 0);
    vec_ce0               :in   STD_LOGIC;
    vec_q0                :out  STD_LOGIC_VECTOR(63 downto 0);
    cols_address0         :in   STD_LOGIC_VECTOR(10 downto 0);
    cols_ce0              :in   STD_LOGIC;
    cols_q0               :out  STD_LOGIC_VECTOR(31 downto 0);
    val_r_address0        :in   STD_LOGIC_VECTOR(10 downto 0);
    val_r_ce0             :in   STD_LOGIC;
    val_r_q0              :out  STD_LOGIC_VECTOR(63 downto 0);
    out_r_address0        :in   STD_LOGIC_VECTOR(8 downto 0);
    out_r_ce0             :in   STD_LOGIC;
    out_r_we0             :in   STD_LOGIC;
    out_r_d0              :in   STD_LOGIC_VECTOR(63 downto 0);
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC
);
end entity spmv_BUS_A_s_axi;

-- ------------------------Address Info-------------------
-- 0x0000 : Control signals
--          bit 0  - ap_start (Read/Write/COH)
--          bit 1  - ap_done (Read/COR)
--          bit 2  - ap_idle (Read)
--          bit 3  - ap_ready (Read)
--          bit 7  - auto_restart (Read/Write)
--          others - reserved
-- 0x0004 : Global Interrupt Enable Register
--          bit 0  - Global Interrupt Enable (Read/Write)
--          others - reserved
-- 0x0008 : IP Interrupt Enable Register (Read/Write)
--          bit 0  - enable ap_done interrupt (Read/Write)
--          bit 1  - enable ap_ready interrupt (Read/Write)
--          others - reserved
-- 0x000c : IP Interrupt Status Register (Read/TOW)
--          bit 0  - ap_done (COR/TOW)
--          bit 1  - ap_ready (COR/TOW)
--          others - reserved
-- 0x0800 ~
-- 0x0fff : Memory 'rowDelimiters' (495 * 32b)
--          Word n : bit [31:0] - rowDelimiters[n]
-- 0x1000 ~
-- 0x1fff : Memory 'vec' (494 * 64b)
--          Word 2n   : bit [31:0] - vec[n][31: 0]
--          Word 2n+1 : bit [31:0] - vec[n][63:32]
-- 0x2000 ~
-- 0x3fff : Memory 'cols' (1666 * 32b)
--          Word n : bit [31:0] - cols[n]
-- 0x4000 ~
-- 0x7fff : Memory 'val_r' (1666 * 64b)
--          Word 2n   : bit [31:0] - val_r[n][31: 0]
--          Word 2n+1 : bit [31:0] - val_r[n][63:32]
-- 0x8000 ~
-- 0x8fff : Memory 'out_r' (494 * 64b)
--          Word 2n   : bit [31:0] - out_r[n][31: 0]
--          Word 2n+1 : bit [31:0] - out_r[n][63:32]
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of spmv_BUS_A_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL            : INTEGER := 16#0000#;
    constant ADDR_GIE                : INTEGER := 16#0004#;
    constant ADDR_IER                : INTEGER := 16#0008#;
    constant ADDR_ISR                : INTEGER := 16#000c#;
    constant ADDR_ROWDELIMITERS_BASE : INTEGER := 16#0800#;
    constant ADDR_ROWDELIMITERS_HIGH : INTEGER := 16#0fff#;
    constant ADDR_VEC_BASE           : INTEGER := 16#1000#;
    constant ADDR_VEC_HIGH           : INTEGER := 16#1fff#;
    constant ADDR_COLS_BASE          : INTEGER := 16#2000#;
    constant ADDR_COLS_HIGH          : INTEGER := 16#3fff#;
    constant ADDR_VAL_R_BASE         : INTEGER := 16#4000#;
    constant ADDR_VAL_R_HIGH         : INTEGER := 16#7fff#;
    constant ADDR_OUT_R_BASE         : INTEGER := 16#8000#;
    constant ADDR_OUT_R_HIGH         : INTEGER := 16#8fff#;
    constant ADDR_BITS         : INTEGER := 16;

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
    signal int_rowDelimiters_address0 : UNSIGNED(8 downto 0);
    signal int_rowDelimiters_ce0 : STD_LOGIC;
    signal int_rowDelimiters_we0 : STD_LOGIC;
    signal int_rowDelimiters_be0 : UNSIGNED(3 downto 0);
    signal int_rowDelimiters_d0 : UNSIGNED(31 downto 0);
    signal int_rowDelimiters_q0 : UNSIGNED(31 downto 0);
    signal int_rowDelimiters_address1 : UNSIGNED(8 downto 0);
    signal int_rowDelimiters_ce1 : STD_LOGIC;
    signal int_rowDelimiters_we1 : STD_LOGIC;
    signal int_rowDelimiters_be1 : UNSIGNED(3 downto 0);
    signal int_rowDelimiters_d1 : UNSIGNED(31 downto 0);
    signal int_rowDelimiters_q1 : UNSIGNED(31 downto 0);
    signal int_rowDelimiters_read : STD_LOGIC;
    signal int_rowDelimiters_write : STD_LOGIC;
    signal int_vec_address0    : UNSIGNED(8 downto 0);
    signal int_vec_ce0         : STD_LOGIC;
    signal int_vec_we0         : STD_LOGIC;
    signal int_vec_be0         : UNSIGNED(7 downto 0);
    signal int_vec_d0          : UNSIGNED(63 downto 0);
    signal int_vec_q0          : UNSIGNED(63 downto 0);
    signal int_vec_address1    : UNSIGNED(8 downto 0);
    signal int_vec_ce1         : STD_LOGIC;
    signal int_vec_we1         : STD_LOGIC;
    signal int_vec_be1         : UNSIGNED(7 downto 0);
    signal int_vec_d1          : UNSIGNED(63 downto 0);
    signal int_vec_q1          : UNSIGNED(63 downto 0);
    signal int_vec_read        : STD_LOGIC;
    signal int_vec_write       : STD_LOGIC;
    signal int_vec_shift       : UNSIGNED(0 downto 0);
    signal int_cols_address0   : UNSIGNED(10 downto 0);
    signal int_cols_ce0        : STD_LOGIC;
    signal int_cols_we0        : STD_LOGIC;
    signal int_cols_be0        : UNSIGNED(3 downto 0);
    signal int_cols_d0         : UNSIGNED(31 downto 0);
    signal int_cols_q0         : UNSIGNED(31 downto 0);
    signal int_cols_address1   : UNSIGNED(10 downto 0);
    signal int_cols_ce1        : STD_LOGIC;
    signal int_cols_we1        : STD_LOGIC;
    signal int_cols_be1        : UNSIGNED(3 downto 0);
    signal int_cols_d1         : UNSIGNED(31 downto 0);
    signal int_cols_q1         : UNSIGNED(31 downto 0);
    signal int_cols_read       : STD_LOGIC;
    signal int_cols_write      : STD_LOGIC;
    signal int_val_r_address0  : UNSIGNED(10 downto 0);
    signal int_val_r_ce0       : STD_LOGIC;
    signal int_val_r_we0       : STD_LOGIC;
    signal int_val_r_be0       : UNSIGNED(7 downto 0);
    signal int_val_r_d0        : UNSIGNED(63 downto 0);
    signal int_val_r_q0        : UNSIGNED(63 downto 0);
    signal int_val_r_address1  : UNSIGNED(10 downto 0);
    signal int_val_r_ce1       : STD_LOGIC;
    signal int_val_r_we1       : STD_LOGIC;
    signal int_val_r_be1       : UNSIGNED(7 downto 0);
    signal int_val_r_d1        : UNSIGNED(63 downto 0);
    signal int_val_r_q1        : UNSIGNED(63 downto 0);
    signal int_val_r_read      : STD_LOGIC;
    signal int_val_r_write     : STD_LOGIC;
    signal int_val_r_shift     : UNSIGNED(0 downto 0);
    signal int_out_r_address0  : UNSIGNED(8 downto 0);
    signal int_out_r_ce0       : STD_LOGIC;
    signal int_out_r_we0       : STD_LOGIC;
    signal int_out_r_be0       : UNSIGNED(7 downto 0);
    signal int_out_r_d0        : UNSIGNED(63 downto 0);
    signal int_out_r_q0        : UNSIGNED(63 downto 0);
    signal int_out_r_address1  : UNSIGNED(8 downto 0);
    signal int_out_r_ce1       : STD_LOGIC;
    signal int_out_r_we1       : STD_LOGIC;
    signal int_out_r_be1       : UNSIGNED(7 downto 0);
    signal int_out_r_d1        : UNSIGNED(63 downto 0);
    signal int_out_r_q1        : UNSIGNED(63 downto 0);
    signal int_out_r_read      : STD_LOGIC;
    signal int_out_r_write     : STD_LOGIC;
    signal int_out_r_shift     : UNSIGNED(0 downto 0);

    component spmv_BUS_A_s_axi_ram is
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
    end component spmv_BUS_A_s_axi_ram;

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
-- int_rowDelimiters
int_rowDelimiters : spmv_BUS_A_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 495,
     AWIDTH   => log2(495))
port map (
     clk0     => ACLK,
     address0 => int_rowDelimiters_address0,
     ce0      => int_rowDelimiters_ce0,
     we0      => int_rowDelimiters_we0,
     be0      => int_rowDelimiters_be0,
     d0       => int_rowDelimiters_d0,
     q0       => int_rowDelimiters_q0,
     clk1     => ACLK,
     address1 => int_rowDelimiters_address1,
     ce1      => int_rowDelimiters_ce1,
     we1      => int_rowDelimiters_we1,
     be1      => int_rowDelimiters_be1,
     d1       => int_rowDelimiters_d1,
     q1       => int_rowDelimiters_q1);
-- int_vec
int_vec : spmv_BUS_A_s_axi_ram
generic map (
     BYTES    => 8,
     DEPTH    => 494,
     AWIDTH   => log2(494))
port map (
     clk0     => ACLK,
     address0 => int_vec_address0,
     ce0      => int_vec_ce0,
     we0      => int_vec_we0,
     be0      => int_vec_be0,
     d0       => int_vec_d0,
     q0       => int_vec_q0,
     clk1     => ACLK,
     address1 => int_vec_address1,
     ce1      => int_vec_ce1,
     we1      => int_vec_we1,
     be1      => int_vec_be1,
     d1       => int_vec_d1,
     q1       => int_vec_q1);
-- int_cols
int_cols : spmv_BUS_A_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 1666,
     AWIDTH   => log2(1666))
port map (
     clk0     => ACLK,
     address0 => int_cols_address0,
     ce0      => int_cols_ce0,
     we0      => int_cols_we0,
     be0      => int_cols_be0,
     d0       => int_cols_d0,
     q0       => int_cols_q0,
     clk1     => ACLK,
     address1 => int_cols_address1,
     ce1      => int_cols_ce1,
     we1      => int_cols_we1,
     be1      => int_cols_be1,
     d1       => int_cols_d1,
     q1       => int_cols_q1);
-- int_val_r
int_val_r : spmv_BUS_A_s_axi_ram
generic map (
     BYTES    => 8,
     DEPTH    => 1666,
     AWIDTH   => log2(1666))
port map (
     clk0     => ACLK,
     address0 => int_val_r_address0,
     ce0      => int_val_r_ce0,
     we0      => int_val_r_we0,
     be0      => int_val_r_be0,
     d0       => int_val_r_d0,
     q0       => int_val_r_q0,
     clk1     => ACLK,
     address1 => int_val_r_address1,
     ce1      => int_val_r_ce1,
     we1      => int_val_r_we1,
     be1      => int_val_r_be1,
     d1       => int_val_r_d1,
     q1       => int_val_r_q1);
-- int_out_r
int_out_r : spmv_BUS_A_s_axi_ram
generic map (
     BYTES    => 8,
     DEPTH    => 494,
     AWIDTH   => log2(494))
port map (
     clk0     => ACLK,
     address0 => int_out_r_address0,
     ce0      => int_out_r_ce0,
     we0      => int_out_r_we0,
     be0      => int_out_r_be0,
     d0       => int_out_r_d0,
     q0       => int_out_r_q0,
     clk1     => ACLK,
     address1 => int_out_r_address1,
     ce1      => int_out_r_ce1,
     we1      => int_out_r_we1,
     be1      => int_out_r_be1,
     d1       => int_out_r_d1,
     q1       => int_out_r_q1);


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
    RVALID_t  <= '1' when (rstate = rddata) and (int_rowDelimiters_read = '0') and (int_vec_read = '0') and (int_cols_read = '0') and (int_val_r_read = '0') and (int_out_r_read = '0') else '0';
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
                elsif (int_rowDelimiters_read = '1') then
                    rdata_data <= int_rowDelimiters_q1;
                elsif (int_vec_read = '1') then
                    rdata_data <= RESIZE(SHIFT_RIGHT(int_vec_q1, TO_INTEGER(int_vec_shift)*32), 32);
                elsif (int_cols_read = '1') then
                    rdata_data <= int_cols_q1;
                elsif (int_val_r_read = '1') then
                    rdata_data <= RESIZE(SHIFT_RIGHT(int_val_r_q1, TO_INTEGER(int_val_r_shift)*32), 32);
                elsif (int_out_r_read = '1') then
                    rdata_data <= RESIZE(SHIFT_RIGHT(int_out_r_q1, TO_INTEGER(int_out_r_shift)*32), 32);
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
    -- rowDelimiters
    int_rowDelimiters_address0 <= UNSIGNED(rowDelimiters_address0);
    int_rowDelimiters_ce0 <= rowDelimiters_ce0;
    int_rowDelimiters_we0 <= '0';
    int_rowDelimiters_be0 <= (others => '0');
    int_rowDelimiters_d0 <= (others => '0');
    rowDelimiters_q0     <= STD_LOGIC_VECTOR(RESIZE(int_rowDelimiters_q0, 32));
    int_rowDelimiters_address1 <= raddr(10 downto 2) when ar_hs = '1' else waddr(10 downto 2);
    int_rowDelimiters_ce1 <= '1' when ar_hs = '1' or (int_rowDelimiters_write = '1' and WVALID  = '1') else '0';
    int_rowDelimiters_we1 <= '1' when int_rowDelimiters_write = '1' and w_hs = '1' else '0';
    int_rowDelimiters_be1 <= UNSIGNED(WSTRB);
    int_rowDelimiters_d1 <= UNSIGNED(WDATA);
    -- vec
    int_vec_address0     <= UNSIGNED(vec_address0);
    int_vec_ce0          <= vec_ce0;
    int_vec_we0          <= '0';
    int_vec_be0          <= (others => '0');
    int_vec_d0           <= (others => '0');
    vec_q0               <= STD_LOGIC_VECTOR(RESIZE(int_vec_q0, 64));
    int_vec_address1     <= raddr(11 downto 3) when ar_hs = '1' else waddr(11 downto 3);
    int_vec_ce1          <= '1' when ar_hs = '1' or (int_vec_write = '1' and WVALID  = '1') else '0';
    int_vec_we1          <= '1' when int_vec_write = '1' and w_hs = '1' else '0';
    int_vec_be1          <= SHIFT_LEFT(RESIZE(UNSIGNED(WSTRB), 8), TO_INTEGER(waddr(2 downto 2)) * 4);
    int_vec_d1           <= RESIZE(UNSIGNED(WDATA) & UNSIGNED(WDATA), 64);
    -- cols
    int_cols_address0    <= UNSIGNED(cols_address0);
    int_cols_ce0         <= cols_ce0;
    int_cols_we0         <= '0';
    int_cols_be0         <= (others => '0');
    int_cols_d0          <= (others => '0');
    cols_q0              <= STD_LOGIC_VECTOR(RESIZE(int_cols_q0, 32));
    int_cols_address1    <= raddr(12 downto 2) when ar_hs = '1' else waddr(12 downto 2);
    int_cols_ce1         <= '1' when ar_hs = '1' or (int_cols_write = '1' and WVALID  = '1') else '0';
    int_cols_we1         <= '1' when int_cols_write = '1' and w_hs = '1' else '0';
    int_cols_be1         <= UNSIGNED(WSTRB);
    int_cols_d1          <= UNSIGNED(WDATA);
    -- val_r
    int_val_r_address0   <= UNSIGNED(val_r_address0);
    int_val_r_ce0        <= val_r_ce0;
    int_val_r_we0        <= '0';
    int_val_r_be0        <= (others => '0');
    int_val_r_d0         <= (others => '0');
    val_r_q0             <= STD_LOGIC_VECTOR(RESIZE(int_val_r_q0, 64));
    int_val_r_address1   <= raddr(13 downto 3) when ar_hs = '1' else waddr(13 downto 3);
    int_val_r_ce1        <= '1' when ar_hs = '1' or (int_val_r_write = '1' and WVALID  = '1') else '0';
    int_val_r_we1        <= '1' when int_val_r_write = '1' and w_hs = '1' else '0';
    int_val_r_be1        <= SHIFT_LEFT(RESIZE(UNSIGNED(WSTRB), 8), TO_INTEGER(waddr(2 downto 2)) * 4);
    int_val_r_d1         <= RESIZE(UNSIGNED(WDATA) & UNSIGNED(WDATA), 64);
    -- out_r
    int_out_r_address0   <= UNSIGNED(out_r_address0);
    int_out_r_ce0        <= out_r_ce0;
    int_out_r_we0        <= out_r_we0;
    int_out_r_be0        <= (others => out_r_we0);
    int_out_r_d0         <= RESIZE(UNSIGNED(out_r_d0), 64);
    int_out_r_address1   <= raddr(11 downto 3) when ar_hs = '1' else waddr(11 downto 3);
    int_out_r_ce1        <= '1' when ar_hs = '1' or (int_out_r_write = '1' and WVALID  = '1') else '0';
    int_out_r_we1        <= '1' when int_out_r_write = '1' and w_hs = '1' else '0';
    int_out_r_be1        <= SHIFT_LEFT(RESIZE(UNSIGNED(WSTRB), 8), TO_INTEGER(waddr(2 downto 2)) * 4);
    int_out_r_d1         <= RESIZE(UNSIGNED(WDATA) & UNSIGNED(WDATA), 64);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_rowDelimiters_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_ROWDELIMITERS_BASE and raddr <= ADDR_ROWDELIMITERS_HIGH) then
                    int_rowDelimiters_read <= '1';
                else
                    int_rowDelimiters_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_rowDelimiters_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_ROWDELIMITERS_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_ROWDELIMITERS_HIGH) then
                    int_rowDelimiters_write <= '1';
                elsif (w_hs = '1') then
                    int_rowDelimiters_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_vec_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_VEC_BASE and raddr <= ADDR_VEC_HIGH) then
                    int_vec_read <= '1';
                else
                    int_vec_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_vec_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_VEC_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_VEC_HIGH) then
                    int_vec_write <= '1';
                elsif (w_hs = '1') then
                    int_vec_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    int_vec_shift <= raddr(2 downto 2);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cols_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_COLS_BASE and raddr <= ADDR_COLS_HIGH) then
                    int_cols_read <= '1';
                else
                    int_cols_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cols_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_COLS_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_COLS_HIGH) then
                    int_cols_write <= '1';
                elsif (w_hs = '1') then
                    int_cols_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_val_r_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_VAL_R_BASE and raddr <= ADDR_VAL_R_HIGH) then
                    int_val_r_read <= '1';
                else
                    int_val_r_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_val_r_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_VAL_R_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_VAL_R_HIGH) then
                    int_val_r_write <= '1';
                elsif (w_hs = '1') then
                    int_val_r_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    int_val_r_shift <= raddr(2 downto 2);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_out_r_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_OUT_R_BASE and raddr <= ADDR_OUT_R_HIGH) then
                    int_out_r_read <= '1';
                else
                    int_out_r_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_out_r_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_OUT_R_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_OUT_R_HIGH) then
                    int_out_r_write <= '1';
                elsif (w_hs = '1') then
                    int_out_r_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    int_out_r_shift <= raddr(2 downto 2);
                end if;
            end if;
        end if;
    end process;


end architecture behave;

library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity spmv_BUS_A_s_axi_ram is
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

end entity spmv_BUS_A_s_axi_ram;

architecture behave of spmv_BUS_A_s_axi_ram is
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


