library ieee;
use ieee.std_logic_1164.all;
use work.tp1_pkg.all;

entity semaforos is
	port(
		rst             : in std_logic;
		clk             : in std_logic;
		state 		    : out t_semaforo_state;
        semaforo1       : out semaforo;
        semaforo2       : out semaforo
	);
end semaforos;

architecture behavioral of semaforos is
    signal sem1, sem2 : semaforo;

begin
	process(clk,rst)
	begin
		if rst='1' then
			state <= S0;
		elsif clk = '1' and clk'event then
			case state is
				when S0 => state <= S1;
                when S1 => state <= S2;
                when S2 => state <= S3;
                when S3 => state <= S4;
                when S4 => state <= S5;
                when S5 => state <= S0;
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