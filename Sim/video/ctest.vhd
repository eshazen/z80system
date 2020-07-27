LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity ctest is
  port (
    clk : in  std_ulogic;
    rst : in  std_ulogic;
    q   : out std_ulogic_vector(3 downto 0));
end entity ctest;

architecture arch of ctest is

  component ls163 is
    port (
      out1  : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0);
      rc    : OUT STD_ULOGIC;
      data  : IN  STD_ULOGIC_VECTOR(3 DOWNTO 0);
      clock : IN  STD_ULOGIC;
      load  : IN  STD_ULOGIC;
      clear : IN  STD_ULOGIC;
      p     : IN  STD_ULOGIC;
      t     : IN  STD_ULOGIC);
  end component ls163;

  signal out1 : std_ulogic_vector(3 downto 0);
  signal rc : std_ulogic;

begin  -- architecture arch

  q <= out1;

  ls163_1: entity work.ls163
    port map (
      out1  => out1,
      rc    => rc,
      data  => (others => '0'),
      clock => clk,
      load  => '1',
      clear => rst,
      p     => '1',
      t     => '1');

end architecture arch;
