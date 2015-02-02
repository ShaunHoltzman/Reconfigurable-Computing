-- Shaun Holtzman
-- 6374-1561

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux is
	GENERIC(
		width : positive := 16);
	PORT (
			input0 : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
			input1 : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
			sel    : IN STD_LOGIC;
			output : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
			);

end mux;

architecture Behavioral of mux is

begin

	output <= input0 WHEN sel = '0' ELSE
				 input1 WHEN sel = '1';


end Behavioral;

