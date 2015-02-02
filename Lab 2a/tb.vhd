-- Greg Stitt
-- University of Florida
-- EEL 5934/4930 Reconfigurable Computing
--
-- File: tb.vhd
--
-- Description: This file implements a testbench for the Fibonacci
-- calculator. 
-- Modified by Tosiron 1/25/2012

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behavior of tb is

  constant TEST_WIDTH : positive := 32;
  constant MAX_INPUT  : positive := 40;
  constant TIMEOUT    : time     := MAX_INPUT*20ns;

  signal clk            : std_logic                               := '0';
  signal rst            : std_logic                               := '1';
  signal go             : std_logic                               := '0';
  signal n              : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');
  signal result_fsm_d   : std_logic_vector(TEST_WIDTH-1 downto 0);
  signal done_fsm_d     : std_logic;
 
  signal sim_done : std_logic := '0';

begin

  U_FSM_D : entity work.fib(FSM_D)
    generic map (TEST_WIDTH)
    port map(clk, rst, go, n, result_fsm_d, done_fsm_d);

--  U_FSMD_1P : entity work.fib(FSMD_1P)
--    generic map (TEST_WIDTH)
--    port map(clk, rst, go, n, result_fsmd_1p, done_fsmd_1p);

--  U_FSMD_2P : entity work.fib(FSMD_2P)
--    generic map (TEST_WIDTH)
--    port map(clk, rst, go, n, result_fsmd_2p, done_fsmd_2p);

  -- toggle clock
  clk <= not clk after 5 ns when sim_done = '0' else
         clk;

  -- process to test different inputs
  process

    function checkOutput (
      in1 : integer)
      return unsigned is

      variable i, x, y, temp : integer;
    begin

      i := 3;
      x := 1;
      y := 1;

      while (to_unsigned(i, TEST_WIDTH) <= to_unsigned(in1, TEST_WIDTH)) loop

        temp := x+y;
        x    := y;
        y    := temp;
        i    := i + 1;
      end loop;

      return to_unsigned(y, TEST_WIDTH);
    end checkOutput;

  begin

    -- reset circuit  
    rst <= '1';
    wait for 200 ns;
    rst <= '0';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';

    for i in 1 to MAX_INPUT-1 loop
      n  <= std_logic_vector(to_unsigned(i, TEST_WIDTH));
      go <= '1';
      wait until clk'event and clk = '1';
      go <= '0';
      wait until clk'event and clk = '1';
      wait until (done_fsm_d = '1') for TIMEOUT;

      assert(done_fsm_d = '1');
--      assert(done_fsmd_1p = '1');
      
      assert(unsigned(result_fsm_d) = checkOutput(i))
        report "Result for " & integer'image(i) &
        " is incorrect. The output is " &
        integer'image(to_integer(unsigned(result_fsm_d))) &
        " but should be " & integer'image(to_integer(checkOutput(i)));

--      assert(unsigned(result_fsmd_1p) = checkOutput(i))
--        report "Result for " & integer'image(i) &
--        " is incorrect. The output is " &
--        integer'image(to_integer(unsigned(result_fsmd_1p))) &
--        " but should be " & integer'image(to_integer(checkOutput(i)));

      wait until clk'event and clk = '1';
      wait until clk'event and clk = '1';
    end loop;

    report "SIMULATION FINISHED!!!";
    sim_done <= '1';
    wait;
  end process;

end;