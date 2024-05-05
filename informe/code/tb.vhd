library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tp1_pkg.all;

entity tb is
end tb;

architecture sim of tb is

    constant CLK_PERIOD : time := 100 ms;
    constant TEST_TIME : time := 100 sec;

    signal clk, rst : std_logic := '0';

    signal semaforo1 : semaforo;
    signal semaforo2 : semaforo;
begin

    u_semaforos: entity work.semaforos
        generic map (
            CLK_PERIOD => CLK_PERIOD
        )
        port map (
            rst => rst,
            clk => clk,
            semaforo1 => semaforo1,
            semaforo2 => semaforo2
        );

    -- Clock process
    clk_process : process
    begin
        while now < TEST_TIME loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;

    -- Reset process
    reset_process : process
    begin
        rst <= '1'; -- Assert reset
        wait for CLK_PERIOD * 2; -- Hold reset for 2 clock cycles
        rst <= '0'; -- De-assert reset
        wait;
    end process reset_process;

end sim;
