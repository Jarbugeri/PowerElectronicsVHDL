LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pwm IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        m : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s : OUT STD_LOGIC
    );
END pwm;

ARCHITECTURE rtl OF pwm IS

    SIGNAL carrier : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    contador : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            carrier <= "0000";
        ELSIF rising_edge(clk) THEN
            carrier <= STD_LOGIC_VECTOR(unsigned(carrier) + 1);
        END IF;

    END PROCESS contador;
    
    comparacao :  PROCESS (m, carrier)
    BEGIN
        IF m >= carrier THEN
            s <= '1';
        ELSE
            s <= '0';
        END IF;
    END PROCESS comparacao;

END ARCHITECTURE;

