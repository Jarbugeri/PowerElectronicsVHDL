LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE std.textio.ALL;
USE std.env.finish;

ENTITY pwm_tb IS
END pwm_tb;

ARCHITECTURE sim OF pwm_tb IS

    CONSTANT clk_hz : INTEGER := 50e6;
    CONSTANT clk_period : TIME := 1 sec / clk_hz;
    CONSTANT N : INTEGER := 8;

    SIGNAL clk : STD_LOGIC := '1';
    SIGNAL rst : STD_LOGIC := '1';
    SIGNAL s : STD_LOGIC := '0';
    SIGNAL m : UNSIGNED(N - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

    clk <= NOT clk AFTER clk_period / 2;

    DUT : ENTITY work.pwm(rtl)
        GENERIC MAP(
            N => N
        )
        PORT MAP(
            clk => clk,
            rst => rst,
            m => m,
            s => s
        );

    SEQUENCER_PROC : PROCESS
    BEGIN
        WAIT FOR clk_period * 2;

        rst <= '0';
        m <= to_unsigned(2 ** N / 8, m'length);

        WAIT FOR clk_period * 2 ** N/2;

        m <= to_unsigned( 150, m'length);

        WAIT FOR clk_period * 2 ** N/2;

        m <= to_unsigned( 160 , m'length);

        WAIT FOR clk_period * 2 ** N/2;

        m <= to_unsigned( 200 / 4, m'length);

        WAIT FOR clk_period * 2 ** N/2;

        m <= to_unsigned( 150 / 2, m'length);

        WAIT FOR clk_period * 2 ** N/2;

        m <= to_unsigned( 140 / 3, m'length);

        WAIT FOR clk_period * 2 ** N/2;

        finish;
    END PROCESS;

END ARCHITECTURE;