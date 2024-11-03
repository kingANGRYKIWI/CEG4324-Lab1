library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use WORK.ALL;

package oled_pkg is

type oled_mem is array (0 to 3, 0 to 15) of std_logic_vector (7 downto 0);
type add_pkg  is array (0 to 3) of std_logic_vector(7 downto 0);
type sum_pkg  is array (0 to 4) of std_logic_vector(7 downto 0);

end;

package body oled_pkg is 

end;