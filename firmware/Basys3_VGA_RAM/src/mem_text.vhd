--
-- display memory 80x40
--

library ieee;
use ieee.std_logic_1164.all;


entity mem_text is

  port (
    -- common clock for both ports
    clk   : in  std_logic;
    -- port a is read-only for VGA controller
    addra : in  std_logic_vector(11 downto 0);
    douta : out std_logic_vector(07 downto 0);
    -- port b is read-write for CPU
    dinb  : in  std_logic_vector(07 downto 0);
    addrb : in  std_logic_vector(11 downto 0);
    web   : in  std_logic;
    doutb : out std_logic_vector(07 downto 0));

end entity mem_text;


architecture arch of mem_text is

  type ram_type is array (0 to 40*80) of std_logic_vector(7 downto 0);
  signal RAM : ram_type;

begin  -- architecture arch

  -- clocked write on port b
  process(clk, web, addrb)
  begin
    if(rising_edge(clk)) then
      if(we = '1') then
        RAM(conv_integer(addrb)) <= dinb;
      end if;
    end if;
  end process;

  -- asynchronous read on port b
  process(addrb)
  begin
    doutb <= RAM(conv_integer(addrb));
  end process;

  -- asynchronous read on port a
  process(addra)
  begin
    douta <= RAM(conv_integer(addra));
  end process;


end architecture arch;
