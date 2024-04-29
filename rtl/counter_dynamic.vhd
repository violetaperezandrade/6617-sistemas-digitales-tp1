library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity counter_dynamic is
    generic (
        constant COUNTS : natural
    );
    port(
        rst : in std_logic;
        clk : in std_logic;
        done : out std_logic
    );
end counter_dynamic;

architecture behavioral of counter_dynamic is
    constant N : integer := integer(ceil(log2(real(COUNTS))));
    signal counter : unsigned(N-1 downto 0);
begin
    process(clk,rst)
    begin
        if rst='1' then
            counter <= (others => '0');
            done <= '0';
        elsif clk = '1' and clk'event then
            if counter = COUNTS-1 then
                counter <= (others => '0');
                done <= '1';
            else
                counter <= counter + 1;
                done <= '0';
            end if;
        end if;
    end process;
end behavioral;