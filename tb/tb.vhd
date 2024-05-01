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
    signal counter_30s_end, counter_3s_end : std_logic;
    signal counter_30s_start, counter_3s_start : std_logic;

    signal estado : t_semaforo_state;
    signal semaforo1 : semaforo;
    signal semaforo2 : semaforo;

begin

    counter_3s : entity work.counter_time
        generic map (
            CLK_PERIOD => CLK_PERIOD,
            COUNTER_PERIOD => 3 sec
        )
        port map (
            rst => rst,
            start => counter_3s_start,
            done => counter_3s_end,
            clk => clk
        );

    counter_30s : entity work.counter_time
        generic map (
            CLK_PERIOD => CLK_PERIOD,
            COUNTER_PERIOD => 30 sec
        )
        port map (
            rst => rst,
            start => counter_30s_start,
            done => counter_30s_end,
            clk => clk
        );

    u_semaforo: entity work.semaforos
        port map(
            rst => rst,
            clk => clk,
            state => estado,
            semaforo1 => semaforo1,
            counter_30s_start => counter_30s_start,
            counter_3s_start => counter_3s_start,
            counter_30s_end => counter_30s_end,
            counter_3s_end => counter_3s_end,
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
