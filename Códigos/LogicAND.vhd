library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicAND is
    Port (A: in STD_LOGIC_VECTOR (3 downto 0);
          B: in STD_LOGIC_VECTOR (3 downto 0);
          Z: out STD_LOGIC_VECTOR (3 downto 0));
end LogicAND

architecture Behavioral of LogicAND is

    begin

        Z <= A and B;

    end Behavioral;