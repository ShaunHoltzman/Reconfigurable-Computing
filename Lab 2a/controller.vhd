-- Shaun Holtzman
-- 6374-1561

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity controller is
	GENERIC(
		width : positive := 16);
	PORT(
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		go : IN STD_LOGIC;
		i_le_n : IN STD_LOGIC;
		i_sel : OUT STD_LOGIC;
		x_sel : OUT STD_LOGIC;
		y_sel : OUT STD_LOGIC;
		i_ld : OUT STD_LOGIC;
		x_ld : OUT STD_LOGIC;
		y_ld : OUT STD_LOGIC;
		n_ld : OUT STD_LOGIC;
		result_ld : OUT STD_LOGIC;
		done : OUT STD_LOGIC
		);

end controller;

architecture Behavioral of controller is

	TYPE ctrlStateType IS (START, PAUSE, INIT, CHECK, THE_LOOP, LOAD_RESULT, FINISHED);
	SIGNAL state, nextState : ctrlStateType;
	

begin

	PROCESS(clk, reset)
	
	BEGIN
	
		if(reset = '1') THEN
			state <= START;
		elsif(rising_edge(clk)) THEN
			state <= nextState;
		END IF;
		
	END PROCESS;
	
	PROCESS(clk, reset, go)
	
	BEGIN
	
		i_sel <= '0';
		x_sel <= '0';
		y_sel <= '0';
		i_ld <= '0';
		x_ld <= '0';
		y_ld <= '0';
		n_ld <= '0';
		result_ld <= '0';
		done <= '0';
		
		
		CASE state IS
			WHEN START =>
				nextState <= PAUSE;
			WHEN PAUSE =>
				IF (go = '0') THEN
					nextState <= PAUSE;
				ELSE
					nextState <= INIT;
				END IF;
			WHEN INIT =>
				n_ld <= '1';
				i_ld <= '1';
				x_ld <= '1';
				y_ld <= '1';
				i_sel <= '0';
				x_sel <= '0';
				y_sel <= '0';
				nextState <= CHECK;
			WHEN CHECK =>
				IF (i_le_n = '0') THEN
					nextState <= LOAD_RESULT;
				ELSE
					nextState <= THE_LOOP;
				END IF;
			WHEN THE_LOOP =>
				y_sel <= '1';
				x_sel <= '1';
				i_sel <= '1';
				i_ld <= '1';
				x_ld <= '1';
				y_ld <= '1';
				nextState <= CHECK;
			WHEN LOAD_RESULT =>
				result_ld <= '1';
				nextState <= FINISHED;
			WHEN FINISHED =>
				done <= '1';
				IF (go = '1') THEN
					nextState <= FINISHED;
				ELSE
					nextState <= START;
				END IF;
			END CASE;
			
		END PROCESS;



end Behavioral;

