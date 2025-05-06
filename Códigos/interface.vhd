----------------------------------------------------------------------------------
-- Sistemas digitais 2024.1 - UFRJ
-- Autor: Rebecca Gomes Simão e Mariana Garcia
--
-- Module Name:    interface - Behavioral 
-- Description: Interface da ULA - VHDL  
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- definindo entidade
entity interface is
    Port ( switches    : in  STD_LOGIC_VECTOR(3 downto 0); -- Sw seleciona, outros, agregam valor. Exemplo: SW 1001; botão agrega esse valor a A, ou B, ou etc
           botao, reset, clock      : in  STD_LOGIC; -- agrega valor
           leds_right, leds_left  : out STD_LOGIC_VECTOR(3 downto 0) -- aparece para usuário
    );

end interface;

architecture Behavioral of interface is 
    -- definindo arquitetura: divido em:
    -- 1) chamar main e clk
    -- 2) criar signals
    -- 3) chamar na main
    -- 4) definir reset e pegar A, B e OP
    -- 5) mostrar em looping A, B, Z
    -------------------------------------------------------------------------------------
    -- 1) chamar main e clk

    component main is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            OP: in  std_logic_vector(2 downto 0);
            Z : out std_logic_vector(3 downto 0)
        );
		  
    end component;
	 
	     -- func clock pega clock da placa e aumenta para 2 segundos
    component CLK is
        port (
            clock_O   : in std_logic;
            clock_f  : out std_logic
            );
    end component;

	type tipo_estado is (AA, BB, OPP,ZZ, ZA, ZB, ZC, ZD, ZE, ZF, ZG, ZH,Ax,Bx,OPx);
    -----------------------------------------------------------------------------------------------
    -- 2) criar signals

    -- definindo meus estados: setando A, setando B, setando OP e aparecendo as respostas
    -- criando sinal estado e proximo estado, e definindo ambas como tipo_estado (assumem algum estado em tipo_estado)
    signal ESTADO: tipo_estado := AA;
	 signal ESTADOx : tipo_estado:= zz;
	 signal prox_operacaox: tipo_estado := zz;
	 signal prox_operacao: tipo_estado;
    -- Definindo sinais e criando variáveis de saída
    signal Z0,Z1,Z2,Z3,Z4,Z5,Z6,Z7: STD_LOGIC_VECTOR (3 downto 0);
    signal A,B: STD_LOGIC_VECTOR (3 downto 0):= "0000";
    signal OP: STD_LOGIC_VECTOR (2 downto 0);
	signal clock_f: std_logic;
	signal led_laux : std_logic_vector(3 downto 0) := "1000";
	signal led_raux: std_logic_vector(3 downto 0) := "0000";
    ----------------------------------------------------------------------------------------------------
    --
	 -- 3) mandar pra main e descobrir as saidas
    begin
	 
			LEDS_RIGHT <= LED_RAUX;
			LEDS_LEFT <= LED_LAUX;
        a1:CLK port map (clock,clock_f);
        a2:main port map(A,B,"000",Z0);
        a3:main port map(A,B,"001",Z1);
        a4:main port map(A,B,"010",Z2);
        a5:main port map(A,B,"011",Z3);
        a6:main port map(A,B,"100",Z4);
        a7:main port map(A,B,"101",Z5);
        a8:main port map(A,B,"110",Z6);
        a9:main port map(A,B,"111",Z7);
		
		  
    ----------------------------------------------------
    -- 4) definir reset e pegar A, B e OP 

        -- Criando processo que usa clock e reset
 
		  
		  process(botao, reset)
        begin
		  if reset = '1' then
                ESTADO <= AA;
					 A <= "0000";
					 B <= "0000";
					 OP <="000";
					 
        elsif rising_edge(botao) then
            -- separa o que ocorre em cada estado
            case ESTADO is
                when AA =>
                    if botao = '1' then
                        A <= switches;
                        estado <= BB;
                    end if;
						  
					
                when BB =>
                    if botao = '1' then
                        B <= switches;
                        estado <= OPP;
                    end if;
						  
						  
					 when OPP =>
						estado <= ZZ;
                        op <= switches(2 downto 0);
                        -- descobrir estado inicial
                        if (OP = "000") then -- AND
                            prox_operacao <=  ZA;  
                        elsif (OP = "001") then -- OR
                            prox_operacao <=  ZB;
                        elsif (OP = "010") then -- NOT
                            prox_operacao <=  ZC; 
                        elsif (OP = "011") then -- soma
                            prox_operacao <=  ZD; 
							   elsif (OP = "100") then -- complemento de 2
                            prox_operacao <=  ZE;
                        elsif (OP = "101") then -- subtrator
                            prox_operacao <= ZF;
                        elsif (OP = "110") then -- shifter left
                            prox_operacao <= ZG;
                        elsif (OP = "111") then -- multiplier
                            prox_operacao <= ZH;
                        end if;
						  
						 when others => 
                 end case;
			end if;
end process;
---------------------------------------------------------------------------
    -- 5) emostrar em looping A, B, Z
	 PROCESS(clock,estado,reset)
	 begin
	 if (reset = '1') then
	              led_raux <= "0000";
                led_laux <= "1000";
                estadox <= zz;
					 prox_operacaox <= zz;
		elsif(rising_edge(clock)) then
				if(estado = opp) then
					prox_operacaox <= prox_operacao;
					estadox <= Ax;
				elsif (estado = zz)then
							  case ESTADOx is
								when Ax  =>
									led_laux <= "1000"; --coloco leds adequado
									led_raux <= A;
									estadox <=Bx;
								when Bx  =>
									led_laux <= "0100"; --coloco leds adequado
								  led_raux <= B;
								  estadox <= Opx;
								when Opx  =>
									led_raux (2 downto 0) <= OP (2 downto 0);
								  led_laux <= "0001";
									estadox <= prox_operacaox;
								 when ZA =>
										 led_raux <= Z0;
										 prox_operacaox <= ZB;
										 estadox <= Ax;
									when ZB =>
										 led_raux <= Z1;
										 prox_operacaox <= ZC;
										 estadox <= Ax;
									when ZC =>
										 led_raux <= Z2;
										 prox_operacaox <= ZD;
										 estadox <= Ax;
									when ZD =>
										 led_raux <= Z3;
										 prox_operacaox <= ZE;
										 estadox <= Ax;
									when ZE =>
										 led_raux <= Z4;
										 prox_operacaox <= ZF;
										 estadox <= Ax;
									when ZF =>
										 led_raux <= Z5;
										 prox_operacaox <= ZG;
										 estadox <= Ax;
									when ZG =>
											 led_raux <= Z6;
										 prox_operacaox <= ZH;
										 estadox <= Ax;
									when ZH =>
											led_raux <= Z7;
										 prox_operacaox <= ZA;
										 estadox <= Ax;
									when others =>
							end case;
					end if;
			end if;
 end process;
		  
end Behavioral;					  
