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

    SIGNAL clk : STD_LOGIC := '1';
    SIGNAL rst : STD_LOGIC := '1';
    SIGNAL m : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL s : STD_LOGIC := '0';

BEGIN

    clk <= NOT clk AFTER clk_period / 2;

    DUT : ENTITY work.pwm(rtl)
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
        m <= "1000";

        WAIT FOR clk_period * 16;

        m <= "1100";

        WAIT FOR clk_period * 16;

        m <= "0101";

        WAIT FOR clk_period * 16;

        finish;
    END PROCESS;

END ARCHITECTURE;