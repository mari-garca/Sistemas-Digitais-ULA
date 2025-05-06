----------------------------------------------------------------------------------
-- Sistemas digitais 2024.1 - UFRJ
-- Autor: Rebecca Gomes Simão e Mariana Garcia
-- 
-- Module Name:    MULTIPLIER - Behavioral 
-- Description: Mutiplicador em uma ALU - VHDL
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MULTIPLIER is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Z : out  STD_LOGIC_VECTOR (3 downto 0));
end MULTIPLIER;

architecture Behavioral of MULTIPLIER is 

	 component ADDER_1BIT is --Chama full adder 1 bit
        port (
            A, B, Cin : in  STD_LOGIC;
            Sum, Cout : out STD_LOGIC
        );
    end component;
		 signal Sum : STD_LOGIC_VECTOR(7 downto 0);
        signal carry : STD_LOGIC_VECTOR(7 downto 0);
        signal A2: STD_LOGIC_VECTOR(7 downto 0):= "0000"&A;
        signal Z_Aux: STD_LOGIC_VECTOR(7 downto 0):= "00000000";
		signal inicio: std_logic := '0';
		signal cout: std_logic;
		signal a = integer range 0 to 3:=0;

begin
		  
		  for_i:for i in 0 to 3 loop -- fazer 4 vezes, quantidade de bits de B
		  
            if (B(a) = '0') then-- se ultimo bit de B = 0, só desloca
                A2<= Z_Aux(6 downto 0) & '0';
            elsif (B(a) = '1') then -- se ultimo bit de B = 1, soma resultado com A deslocado
                A2 <= Z_Aux(6 downto 0) & '0'; -- desloca A

                R0 : ADDER_1BIT port map(A2(0), Z_Aux(0), '0',      Sum(0), carry(0));
                R1 : ADDER_1BIT port map(A2(1), Z_Aux(1), carry(0), Sum(1), carry(1));
                R2 : ADDER_1BIT port map(A2(2), Z_Aux(2), carry(1), Sum(2), carry(2));
                R3 : ADDER_1BIT port map(A2(3), Z_Aux(3), carry(2), Sum(3), carry(3));
                R4 : ADDER_1BIT port map(A2(4), Z_Aux(4), carry(3), Sum(4), carry(4));
                R5 : ADDER_1BIT port map(A2(5), Z_Aux(5), carry(4), Sum(5), carry(5));
                R6 : ADDER_1BIT port map(A2(6), Z_Aux(6), carry(5), Sum(6), carry(6));           
                R7 : ADDER_1BIT port map(A2(7), Z_Aux(7), carry(6), Sum(7), Cout);
				
        end if;
		  
    end loop;

	Z <= Sum(7 downto 4);
	
end Behavioral;				