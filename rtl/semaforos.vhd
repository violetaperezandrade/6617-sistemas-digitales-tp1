library ieee;
use ieee.std_logic_1164.all;
use work.tp1_pkg.all;

entity semaforos is
    generic (
        constant CLK_PERIOD : time
    );
    port(
            rst             : in std_logic;
            clk             : in std_logic;
            semaforo1       : out semaforo;
            semaforo2       : out semaforo
        );
end semaforos;

architecture behavioral of semaforos is
    signal counter_30s_end, counter_3s_end : std_logic;
    signal counter_30s_start, counter_3s_start : std_logic;

    signal estado : t_semaforo_state;
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

    u_semaforos_fsm: entity work.semaforos_fsm
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

end behavioral;
