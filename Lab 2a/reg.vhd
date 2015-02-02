-- Shaun Holtzman
-- 6374-1561

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity reg is
	GENERIC(
		width : positive := 16);
	PORT(	
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			load_enable : IN STD_LOGIC;
			input : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
		 );
			

end reg;

architecture Behavioral of reg is

	SIGNAL temp_output : STD_LOGIC_VECTOR(width-1 DOWNTO 0);

begin

	PROCESS(clk, reset)
	
		BEGIN
		
		IF reset = '1' THEN
			temp_output <= (OTHERS => '0');
		ELSIF rising_edge(clk) THEN
			IF load_enable = '1' THEN
				temp_output <= input;
			ELSE
				temp_output <= temp_output;
			END IF;
		END IF;
		
	END PROCESS;
	
	output <= temp_output;

end Behavioral;

