library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tp1_pkg.all;

entity tb is
end tb;

architecture sim of tb is

    constant CLK_PERIOD : time := 10 ms; -- Assuming a 100 MHz clock
    constant COUNTER_PERIOD : time := 1e3 ms;
    constant COUNTS : natural := COUNTER_PERIOD/CLK_PERIOD;

    signal clk, rst : std_logic := '0';
    signal done : std_logic; -- Assuming N=4

    signal estado : t_semaforo_state;
    signal semaforo1 : semaforo;
    signal semaforo2 : semaforo;

begin

    counter_1s : entity work.counter_time
        generic map (
            CLK_PERIOD => CLK_PERIOD,
            COUNTER_PERIOD => 1e3 ms
        )
        port map (
            rst => rst,
            clk => clk
        );

    counter_10s : entity work.counter_time
        generic map (
            CLK_PERIOD => CLK_PERIOD,
            COUNTER_PERIOD => 10e3 ms
        )
        port map (
            rst => rst,
            clk => clk
        );

    u_semaforo: entity work.semaforos
        port map(
            rst => rst,
            clk => clk,
            state => estado,
            semaforo1 => semaforo1,
            semaforo2 => semaforo2
        );

    -- Clock process
    clk_process : process
    begin
        while now < 21e3 ms loop
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
