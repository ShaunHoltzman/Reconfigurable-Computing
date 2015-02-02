-- Shaun Holtzman
-- 6374-1561

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity comparator is
	GENERIC(
		width : positive := 16);
	PORT(
		input0 : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
		input1 : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
		in1_le_in0 : OUT STD_LOGIC
		);

end comparator;

architecture Behavioral of comparator is

	

begin

	PROCESS(input0, input1) 
		BEGIN
		
		IF (UNSIGNED(input1) <= UNSIGNED(input0)) THEN
			in1_le_in0 <= '1';
		ELSE
			in1_le_in0 <= '0';
		END IF;
		
	END PROCESS;


end Behavioral;

