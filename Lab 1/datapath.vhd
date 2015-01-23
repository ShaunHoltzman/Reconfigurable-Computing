-- Shaun Holtzman
-- 6374-1561

library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  generic (
    width     :     positive := 16);
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    valid_in  : in  std_logic;
    valid_out : out std_logic;
    in1       : in  std_logic_vector(width-1 downto 0);
    in2       : in  std_logic_vector(width-1 downto 0);
    in3       : in  std_logic_vector(width-1 downto 0);
    in4       : in  std_logic_vector(width-1 downto 0);
    output    : out std_logic_vector(width*2 downto 0));
end datapath;

-- TODO: Implement the structural description of the datapath shown in
-- datapath.pdf by instantiating your add_pipe and mult_pipe entities. You may
-- also use the provided reg entity, or you can create your own.

architecture STR of datapath is

signal temp_valid_in : std_logic_vector(1 downto 0);
signal temp_valid_out : std_logic_vector(1 downto 0);
signal temp_valid_out2 : std_logic_vector(1 downto 0);
signal temp_mult_out1 : std_logic_vector(width*2-1 downto 0);
signal temp_mult_out2 : std_logic_vector(width*2-1 downto 0);


begin

temp_valid_in <= ('0' & valid_in);





VALID_REG1 : entity work.reg
	GENERIC MAP(2)
	PORT MAP(
		clk => clk,
		rst => rst,
		en => en,
		input => temp_valid_in,
		output => temp_valid_out
	);
	
VALID_REG2 : entity work.reg
		GENERIC MAP(2)
		PORT MAP(
			clk => clk,
			rst => rst,
			en => en,
			input => temp_valid_out,
			output => temp_valid_out2
		);
		
	valid_out <= temp_valid_out2(0);
	
MULT1 : entity work.mult_pipe
		GENERIC MAP(width)
		PORT MAP(
			clk => clk,
			rst => rst,
			en => en,
			in1 => in1,
			in2 => in2,
			output => temp_mult_out1
		);
		
MULT2 : entity work.mult_pipe
		GENERIC MAP(width)
		PORT MAP(
			clk => clk,
			rst => rst,
			en => en,
			in1 => in3,
			in2 => in4,
			output => temp_mult_out2
		);
		
ADD : entity work.add_pipe
		GENERIC MAP(width*2)
		PORT MAP(
			clk => clk,
			rst => rst,
			en => en, 
			in1 => temp_mult_out1,
			in2 => temp_mult_out2,
			output => output
		);


end STR;
