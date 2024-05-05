library ieee;
use ieee.std_logic_1164.all;

package tp1_pkg is
    type t_semaforo_state is (S0, S1, S2, S3, S4, S5);
    
    type semaforo is record
        verde   : std_logic;
        rojo    : std_logic;
        amarillo: std_logic;
    end record;
    
end tp1_pkg;
