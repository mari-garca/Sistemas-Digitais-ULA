library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FULL_ADDER_4BITS is
    Port( 
        A, B: in STD_LOGIC_VECTOR(3 downto 0);
        Cin : in STD_LOGIC;
        Sum : out STD_LOGIC_VECTOR(3 downto 0);
        Cout: out STD_LOGIC
    );

end entity FULL_ADDER_4BITS;

architecture Behavioral of FULL_ADDER_4BITS is -- Chama full adder 1 bit

    component ADDER_1BIT
        Port (
            A, B, Cin: in STD_LOGIC;
            Sum, Cout: out STD_LOGIC
        );

    end component;

    signal carry: STD_LOGIC_VECTOR(3 downto 0);

    begin
    -- Instanciando full adders para cada bit
    R0 : ADDER_1BIT port map (A(0), B(0), Cin, Sum(0), carry(0));
    R1 : ADDER_1BIT port map (A(1), B(1), carry (0), Sum(1), carry(1));
    R2 : ADDER_1BIT port map (A(2), B(2), carry (1), Sum(2), carry(2));
    R3 : ADDER_1BIT port map (A(3), B(3), carry (2), Sum(3), Cout);

end Behavioral;