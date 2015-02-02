-- Shaun Holtzman
-- 6374-1561

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity datapath is
	GENERIC(
		width : positive := 16);
	PORT(
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		i_sel : IN STD_LOGIC;
		x_sel : IN STD_LOGIC;
		y_sel : IN STD_LOGIC;
		i_ld  : IN STD_LOGIC;
		x_ld  : IN STD_LOGIC;
		y_ld  : IN STD_LOGIC;
		n_ld  : IN STD_LOGIC;
		result_ld : IN STD_LOGIC;
		i_le_n : OUT STD_LOGIC;
		n : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
	);
		
		

end datapath;

architecture Behavioral of datapath is

	SIGNAL three : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL one : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL i_plus1 : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL i_input : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL i_output : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL n_output : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL y_output : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL x_input : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL x_output : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL x_plus_y : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
	SIGNAL y_input : STD_LOGIC_VECTOR(width-1 DOWNTO 0);

begin

	three <= STD_LOGIC_VECTOR(to_unsigned(3, width));
	one <= STD_LOGIC_VECTOR(to_unsigned(1, width));

	i_mux : entity work.mux
	GENERIC MAP(width)
	PORT MAP
	(
	 input0 => three,
	 input1 => i_plus1,
	 sel => i_sel,
	 output => i_input
	);
	
	i_reg : entity work.reg
	GENERIC MAP(width)
	PORT MAP
	(
	 clk => clk,
	 reset => reset,
	 load_enable => i_ld,
	 input => i_input,
	 output => i_output
	 );
	 
	 i_plus1 <= STD_LOGIC_VECTOR(UNSIGNED(i_output) + UNSIGNED(one));
	 
	 n_reg : entity work.reg
	 GENERIC MAP(width)
	 PORT MAP
	 (
	  clk => clk,
	  reset => reset,
	  load_enable => n_ld,
	  input => n,
	  output => n_output
	  );
	  
	  compare : entity work.comparator
	  GENERIC MAP(width)
	  PORT MAP
	  (
	  input0 => n_output,
	  input1 => i_output,
	  in1_le_in0 => i_le_n
	  );
	  
	 x_mux : entity work.mux
	 GENERIC MAP(width)
	 PORT MAP
	 (
	 input0 => one,
	 input1 => y_output,
	 sel => x_sel,
	 output => x_input
    );
	 
	 x_reg : entity work.reg
	 GENERIC MAP(width)
	 PORT MAP
	 (
	  clk => clk,
	  reset => reset,
	  load_enable => x_ld,
	  input => x_input,
	  output => x_output
	  );
	  
	 y_mux : entity work.mux
	 GENERIC MAP(width)
	 PORT MAP
	 (
	 input0 => one,
	 input1 => x_plus_y,
	 sel => y_sel,
	 output => y_input
    );
	 
	 y_reg : entity work.reg
	 GENERIC MAP(width)
	 PORT MAP
	 (
	  clk => clk,
	  reset => reset,
	  load_enable => y_ld,
	  input => y_input,
	  output => y_output
	  );
	  
	  x_plus_y <= STD_LOGIC_VECTOR(UNSIGNED(x_output) + UNSIGNED(y_output)); 
	  
	 result_reg : entity work.reg
	 GENERIC MAP(width)
	 PORT MAP
	 (
	  clk => clk,
	  reset => reset,
	  load_enable => result_ld,
	  input => y_output,
	  output => result
	  );

end Behavioral;

