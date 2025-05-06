----------------------------------------------------------------------------------
-- Sistemas digitais 2024.1 - UFRJ
-- Autor: Rebecca Gomes Simão e Mariana Garcia
--
-- Module Name:    SHIFTER - Behavioral 
-- Description: Deslocador em uma ALU - VHDL 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SHIFTER is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           Q : in  STD_LOGIC_VECTOR (3 downto 0);
           Z : out  STD_LOGIC_VECTOR (3 downto 0));
end SHIFTER;

architecture Behavioral of SHIFTER is

begin
    P1: process(Q, A)
        begin
            if (Q = "00") then -- 0 deslocamentos
                Z <= A;
            elsif (Q = "01") then -- 1 deslocamentos
                Z <= "0" & A(3 downto 1);
            elsif (Q = "10") then -- 2 deslocamentos
                Z <= "00" & A(3 downto 2);
            elsif (Q = "11") then -- 3 deslocamentos
                Z <= "000" & A(3);
            end if;
    end process P1; 
end Behavioral;

