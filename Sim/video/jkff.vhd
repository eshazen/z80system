--
-- crude 74LS112 model
--

library ieee;
use ieee.std_logic_1164.all;

entity jkff is

  port (
    j, k         : in  std_ulogic;
    pre_n, clr_n : in  std_ulogic;
    clk_n        : in  std_ulogic;
    q            : out std_ulogic;
    q_n          : out std_ulogic);

end entity jkff;

architecture arch of jkff is

  signal q_s   : std_ulogic := '0';
  signal q_n_s : std_ulogic := '1';

begin  -- architecture arch

  q <= q_s;
  q_n <= q_n_s;

  process (clk_n, pre_n, clr_n) is
  begin  -- process
    if pre_n = '0' and clr_n = '1' then
      q_s   <= '0';
      q_n_s <= '1';
    elsif pre_n = '1' and clr_n = '0' then
      q_s   <= '1';
      q_n_s <= '0';
    elsif pre_n = '0' and clr_n = '0' then
      q_s   <= '1';
      q_n_s <= '1';
    elsif clk_n'event and clk_n = '0' then  -- falling clock edge
      if j = '1' and k = '0' then
        q_s   <= '1';
        q_n_s <= '0';
      elsif j = '0' and k = '1' then
        q_s   <= '0';
        q_n_s <= '1';
      elsif j = '1' and k = '1' then
        q_s   <= not q_s;
        q_n_s <= not q_n_s;
      end if;
    end if;

  end process;

end architecture arch;
