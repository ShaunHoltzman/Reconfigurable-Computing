-- Shaun Holtzman
-- 6374-1561

library ieee;
use ieee.std_logic_1164.all;

entity enc4to2 is
  port (
    input  : in  std_logic_vector(3 downto 0);
    output : out std_logic_vector(1 downto 0);
    valid  : out std_logic);
end enc4to2;

-- TODO: implement the priority encoder using an if statement

architecture IF_STATEMENT of enc4to2 is
begin

	PROCESS(input)
		BEGIN
		
			IF input(3) = '1' THEN
				output <= "11";
			ELSIF input(2) = '1' THEN
				output <= "10";
			ELSIF input(1) = '1' THEN
				output <= "01";
			ELSIF input(0) = '1' THEN
				output <= "00";
			END IF;
			
			IF input = "0000" THEN
				valid <= '0';
			ELSE
				valid <= '1';
			END IF;
		
	END PROCESS;

end IF_STATEMENT;



architecture CASE_STATEMENT of enc4to2 is
begin
	
	PROCESS(input)
		BEGIN
		
		CASE input IS
			WHEN "1000" =>
					output <= "11";
					valid <= '1';
			WHEN "1001" =>
					output <= "11";
					valid <= '1';
			WHEN "1010" =>
					output <= "11";
					valid <= '1';
			WHEN "1011" =>
					output <= "11";
					valid <= '1';
			WHEN "1100" =>
					output <= "11";
					valid <= '1';
			WHEN "1101" =>
					output <= "11";
					valid <= '1';
			WHEN "1110" =>
					output <= "11";
					valid <= '1';
			WHEN "1111" =>
					output <= "11";
					valid <= '1';
			WHEN "0100" =>
					output <= "10";
					valid <= '1';
			WHEN "0101" =>
					output <= "10";
					valid <= '1';
			WHEN "0110" =>
					output <= "10";
					valid <= '1';
			WHEN "0111" =>
					output <= "10";
					valid <= '1';
			WHEN "0010" =>
					output <= "01";
					valid <= '1';
			WHEN "0011" =>
					output <= "01";
					valid <= '1';
			WHEN "0001" =>
					output <= "00";
					valid <= '1';
			WHEN OTHERS =>
					valid <= '0';
		END CASE;
		
	END PROCESS;
					


end CASE_STATEMENT;
