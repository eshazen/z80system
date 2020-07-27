LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity ctest_tb is
  
end entity ctest_tb;

architecture arch of ctest_tb is

  constant period : time := 250 ns;
  signal clk : std_ulogic := '0';
  signal rst : std_ulogic;
  signal q : std_ulogic_vector(3 downto 0);

begin  -- architecture arch

  gen_clk: process( clk)
  begin
    clk <= not clk after period/2;
  end process;
  
  rst <= '0', '1' after period;
  

  ctest_1: entity work.ctest
    port map (
      clk => clk,
      rst => rst,
      q   => q);

end architecture arch;
