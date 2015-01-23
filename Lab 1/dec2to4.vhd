-- Shaun Holtzman 
-- 6374-1561

library ieee;
use ieee.std_logic_1164.all;

entity dec2to4 is
  port (
    input  : in  std_logic_vector(1 downto 0);
    output : out std_logic_vector(3 downto 0));
end dec2to4;

-- Implement the decoder using a with-select statement

architecture WITH_SELECT of dec2to4 is
begin

	WITH input SELECT
		output <= "0001" WHEN "00",
					 "0010" WHEN "01",
					 "0100" WHEN "10",
					 "1000" WHEN OTHERS;

end WITH_SELECT;

-- Implement the decoder using a when-else statement

architecture WHEN_ELSE of dec2to4 is
begin

	output <= "0001" WHEN input = "00" ELSE
				 "0010" WHEN input = "01" ELSE
				 "0100" WHEN input = "10" ELSE
				 "1000";

  
end WHEN_ELSE;

-- Implement the decoder using an if statement

architecture IF_STATEMENT of dec2to4 is
begin

	PROCESS(input) 
	BEGIN
		IF input = "00" THEN
			output <= "0001";
		ELSIF input = "01" THEN
			output <= "0010";
		ELSIF input = "10" THEN
			output <= "0100";
		ELSE
			output <= "1000";
		END IF;
	END PROCESS;

end IF_STATEMENT;

-- Implement the decoder using a case statement

architecture CASE_STATEMENT of dec2to4 is
begin

	PROCESS(input)
	BEGIN
		CASE input IS
			WHEN "00" =>
				output <= "0001";
			WHEN "01" =>
				output <= "0010";
			WHEN "10" =>
				output <= "0100";
			WHEN OTHERS =>
				output <= "1000";
		END CASE;
	END PROCESS;

end CASE_STATEMENT;
