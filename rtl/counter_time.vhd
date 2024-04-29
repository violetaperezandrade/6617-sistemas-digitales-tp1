library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity counter_time is
    generic (
        constant CLK_PERIOD : time;
        constant COUNTER_PERIOD : time
    );
    port(
        rst : in std_logic;
        clk : in std_logic;
        done : out std_logic
    );
end counter_time;

architecture behavioral of counter_time is
    constant COUNTS : natural := COUNTER_PERIOD/CLK_PERIOD;
begin
    counter : entity work.counter_dynamic
        generic map (
            COUNTS => COUNTS
        )
        port map (
            rst => rst,
            clk => clk,
            done => done
        );
end behavioral;