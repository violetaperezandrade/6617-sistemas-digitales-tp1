library ieee;
use ieee.std_logic_1164.all;
use work.tp1_pkg.all;

entity semaforos_fsm is
    port(
            rst             : in std_logic;
            clk             : in std_logic;
            counter_3s_start: out std_logic;
            counter_30s_start: out std_logic;
            counter_3s_end: in std_logic;
            counter_30s_end: in std_logic;
            state 	    : out t_semaforo_state;
            semaforo1       : out semaforo;
            semaforo2       : out semaforo
        );
end semaforos_fsm;

architecture behavioral of semaforos_fsm is
    signal sem1, sem2 : semaforo;
begin
    process(clk,rst)
    begin
        if rst='1' then
            state <= S0;
            counter_30s_start <= '1';
        elsif clk = '1' and clk'event then
            counter_30s_start <= '0';
            counter_3s_start <= '0';
            state <= state;
            case state is
                when S0 =>
                    if (counter_30s_end) then
                        state <= S1;
                        counter_3s_start <= '1';
                    end if;
                when S1 =>
                    if (counter_3s_end) then
                        state <= S2;
                        counter_3s_start <= '1';
                    end if;
                when S2 =>
                    if (counter_3s_end) then
                        state <= S3;
                        counter_30s_start <= '1';
                    end if;
                when S3 =>
                    if (counter_30s_end) then
                        state <= S4;
                        counter_3s_start <= '1';
                    end if;
                when S4 =>
                    if (counter_3s_end) then
                        state <= S5;
                        counter_3s_start <= '1';
                    end if;
                when S5 =>
                    if (counter_3s_end) then
                        state <= S0;
                        counter_30s_start <= '1';
                    end if;
            end case;

            sem1 <= (verde => '0', rojo => '0', amarillo => '0');
            sem2 <= (verde => '0', rojo => '0', amarillo => '0');

            case state is
                when S0 =>
                    sem1.verde   <= '1';
                    sem1.rojo    <= '0';
                    sem1.amarillo<= '0';
                    sem2.verde   <= '0';
                    sem2.rojo    <= '1';
                    sem2.amarillo<= '0';
                when S1 =>
                    sem1.verde   <= '0';
                    sem1.rojo    <= '0';
                    sem1.amarillo<= '1';
                    sem2.verde   <= '0';
                    sem2.rojo    <= '1';
                    sem2.amarillo<= '0';
                when S2 =>
                    sem1.verde   <= '0';
                    sem1.rojo    <= '1';
                    sem1.amarillo<= '0';
                    sem2.verde   <= '1';
                    sem2.rojo    <= '0';
                    sem2.amarillo<= '0';
                when S3 =>
                    sem1.verde   <= '0';
                    sem1.rojo    <= '1';
                    sem1.amarillo<= '0';
                    sem2.verde   <= '0';
                    sem2.rojo    <= '0';
                    sem2.amarillo<= '1';
                when S4 =>
                    sem1.verde   <= '0';
                    sem1.rojo    <= '1';
                    sem1.amarillo<= '0';
                    sem2.verde   <= '1';
                    sem2.rojo    <= '0';
                    sem2.amarillo<= '0';
                when S5 =>
                    sem1.verde   <= '0';
                    sem1.rojo    <= '0';
                    sem1.amarillo<= '1';
                    sem2.verde   <= '0';
                    sem2.rojo    <= '1';
                    sem2.amarillo<= '0';
            end case;
        end if;
    end process;

    semaforo1 <= sem1;
    semaforo2 <= sem2;

end behavioral;
