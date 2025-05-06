library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicNOT is
    Port (A: in STD_LOGIC_VECTOR (3 downto 0);
          Z: out STD_LOGIC_VECTOR (3 downto 0));
end LogicNOT

architecture Behavioral of LogicNOT is

    begin

        Z <= (not A);

    end Behavioral;