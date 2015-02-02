-- Shaun Holtzman
-- 6374-1561

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- DO NOT CHANGE ANYTHING ON THE ENTITY
entity fib is
  generic (width :     positive := 32);
  port( clk      : in  std_logic;
        rst      : in  std_logic;
        go       : in  std_logic;
        n        : in  std_logic_vector(width-1 downto 0);
        result   : out std_logic_vector(width-1 downto 0);
        done     : out std_logic );
end fib;

-- TODO: Implement the Fibonacci calculator using a FSM+D (i.e., have an
-- explicit controller and datapath as described on the lab webpage)
architecture FSM_D of fib is

	SIGNAL i_sel : STD_LOGIC;
	SIGNAL x_sel : STD_LOGIC;
	SIGNAL y_sel : STD_LOGIC;
	SIGNAL i_ld : STD_LOGIC;
	SIGNAL x_ld : STD_LOGIC;
	SIGNAL y_ld : STD_LOGIC;
	SIGNAL n_ld : STD_LOGIC;
	SIGNAL result_ld : STD_LOGIC;
	SIGNAL i_le_n : STD_LOGIC;
	
	
begin

	Datapath : entity work.datapath
	GENERIC MAP(width)
	PORT MAP
	(
		clk => clk,
		reset => rst,
		i_sel => i_sel,
		x_sel => x_sel,
		y_sel => y_sel,
		i_ld => i_ld,
		x_ld => x_ld,
		y_ld => y_ld,
		n_ld => n_ld,
		result_ld => result_ld,
		i_le_n => i_le_n,
		n => n,
		result => result
	);
	
	Controller : entity work.controller
	GENERIC MAP(width)
	PORT MAP
	(
	 clk => clk,
	 reset => rst,
	 go => go,
	 i_le_n => i_le_n,
	 i_sel => i_sel,
	 x_sel => x_sel,
	 y_sel => y_sel,
	 i_ld => i_ld,
	 x_ld => x_ld,
	 y_ld => y_ld,
	 n_ld => n_ld,
	 result_ld => result_ld,
	 done => done
	 );

end FSM_D;

