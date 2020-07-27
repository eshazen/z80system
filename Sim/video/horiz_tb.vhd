library IEEE;
use IEEE.std_logic_1164.all;

entity horiz_tb is

end entity horiz_tb;

architecture arch of horiz_tb is

  constant period : time       := 1000 ns;
  signal clk      : std_ulogic := '0';
  signal rst      : std_ulogic;

  signal pix : std_ulogic_vector(2 downto 0);
  signal chr : std_ulogic_vector(6 downto 0);
  signal hb  : std_ulogic;
  signal hs  : std_ulogic;

  component horiz is
    port (
      clk : in  std_ulogic;
      rst : in  std_ulogic;
      pix : out std_ulogic_vector(2 downto 0);
      chr : out std_ulogic_vector(6 downto 0);
      hb  : out std_ulogic;
      hs  : out std_ulogic);
  end component horiz;

begin  -- architecture arch

  gen_clk : process(clk)
  begin
    clk <= not clk after period/2;
  end process;

  rst <= '0', '1' after period;

  horiz_1: entity work.horiz
    port map (
      clk => clk,
      rst => rst,
      pix => pix,
      chr => chr,
      hb  => hb,
      hs  => hs);

end architecture arch;
