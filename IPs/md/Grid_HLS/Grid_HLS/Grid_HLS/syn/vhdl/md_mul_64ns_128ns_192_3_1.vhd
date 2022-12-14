-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity md_mul_64ns_128ns_192_3_1_Multiplier_1 is
port (
    clk: in std_logic;
    ce: in std_logic;
    a: in std_logic_vector(64 - 1 downto 0);
    b: in std_logic_vector(128 - 1 downto 0);
    p: out std_logic_vector(192 - 1 downto 0));
end entity;

architecture behav of md_mul_64ns_128ns_192_3_1_Multiplier_1 is
    signal tmp_product : std_logic_vector(192 - 1 downto 0);
    signal a_i : std_logic_vector(64 - 1 downto 0);
    signal b_i : std_logic_vector(128 - 1 downto 0);
    signal p_tmp : std_logic_vector(192 - 1 downto 0);
    signal a_reg0 : std_logic_vector(64 - 1 downto 0);
    signal b_reg0 : std_logic_vector(128 - 1 downto 0);

    signal buff0 : std_logic_vector(192 - 1 downto 0);
begin
    a_i <= a;
    b_i <= b;
    p <= p_tmp;

    p_tmp <= buff0;
    tmp_product <= std_logic_vector(resize(unsigned(a_reg0) * unsigned(b_reg0), 192));

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                a_reg0 <= a_i;
                b_reg0 <= b_i;
                buff0 <= tmp_product;
            end if;
        end if;
    end process;
end architecture;
Library IEEE;
use IEEE.std_logic_1164.all;

entity md_mul_64ns_128ns_192_3_1 is
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER);
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        ce : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR(din0_WIDTH - 1 DOWNTO 0);
        din1 : IN STD_LOGIC_VECTOR(din1_WIDTH - 1 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR(dout_WIDTH - 1 DOWNTO 0));
end entity;

architecture arch of md_mul_64ns_128ns_192_3_1 is
    component md_mul_64ns_128ns_192_3_1_Multiplier_1 is
        port (
            clk : IN STD_LOGIC;
            ce : IN STD_LOGIC;
            a : IN STD_LOGIC_VECTOR;
            b : IN STD_LOGIC_VECTOR;
            p : OUT STD_LOGIC_VECTOR);
    end component;



begin
    md_mul_64ns_128ns_192_3_1_Multiplier_1_U :  component md_mul_64ns_128ns_192_3_1_Multiplier_1
    port map (
        clk => clk,
        ce => ce,
        a => din0,
        b => din1,
        p => dout);

end architecture;


