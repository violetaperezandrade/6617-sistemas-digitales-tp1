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
        start : in std_logic;
        done : out std_logic
    );
end counter_time;

architecture behavioral of counter_time is
    constant COUNTS : natural := COUNTER_PERIOD/CLK_PERIOD;
    signal counting : std_logic;
begin
    process (clk,rst) begin
        if rst = '1' then
            counting <= '0';
        elsif clk = '1' and clk'event then
            if start then
                counting <= '1';
            elsif done  then
                counting <= '0';
            else
                counting <= counting;
            end if;
        end if;
    end process;

    counter: entity work.counter_dynamic
        generic map (
            COUNTS => COUNTS
        )
        port map (
            rst => rst,
            clk => clk,
            enable => counting,
            done => done
        );

end behavioral;
