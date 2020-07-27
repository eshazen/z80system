--
-- 74LS 194 4-bit bi-directional SR
-- timing more like 74AS194
-- not tested
--

library IEEE;
use IEEE.std_logic_1164.all;

entity ls194 is
  
  port (
    clr   : in  std_ulogic;
    clk   : in  std_ulogic;
    s0    : in  std_ulogic;
    s1    : in  std_ulogic;
    left  : in  std_ulogic;
    right : in  std_ulogic;
    data  : in  std_ulogic_vector(3 downto 0);
    q     : out std_ulogic_vector(3 downto 0));

end entity ls194;

architecture arch of ls194 is

  signal reg : std_ulogic_vector(3 downto 0);

begin  -- architecture arch

  q <= reg;

  process (clk, clr) is
  begin  -- process
    if clr = '0' then                   -- asynchronous reset (active low)
      reg <= (others => '0') after 5 ns;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if s0='1' and s1='1' then         -- load
        reg <= data after 5 ns;
      elsif s0='1' and s1='0' then      -- shift right
        reg <= right & reg(3 downto 1) after 5 ns;
      elsif s0='0' and s1='1' then      -- shift left
        reg <= reg(2 downto 0) & left after 5 ns;
      end if;
    end if;
  end process;
    

end architecture arch;
