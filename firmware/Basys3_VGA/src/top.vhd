--
-- VGA 640x480 display core
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity top is

  generic (
    AWIDE : integer := 4;
    DWIDE : integer := 4);

  port (
    clk   : in  std_logic;
    R     : out std_logic;
    G     : out std_logic;
    B     : out std_logic;
    hsync : out std_logic;
    vsync : out std_logic
    sw    : in  std_logic_vector(7 downto 0);
    );
end entity top;

architecture arch of top is

  signal pclk   : std_logic;

  component clock_vga is
    port (
      clk_out1 : out std_logic;
      locked   : out std_logic;
      clk_in1  : in  std_logic);
  end component clock_vga;

  component vga80x40 is
    port (
      reset    : in  std_logic;
      clk25MHz : in  std_logic;
      TEXT_A   : out std_logic_vector(11 downto 0);
      TEXT_D   : in  std_logic_vector(07 downto 0);
      FONT_A   : out std_logic_vector(11 downto 0);
      FONT_D   : in  std_logic_vector(07 downto 0);
      ocrx     : in  std_logic_vector(07 downto 0);
      ocry     : in  std_logic_vector(07 downto 0);
      octl     : in  std_logic_vector(07 downto 0);
      R        : out std_logic;
      G        : out std_logic;
      B        : out std_logic;
      hsync    : out std_logic;
      vsync    : out std_logic);
  end component vga80x40;

begin  -- architecture arch

  clock_vga_1 : entity work.clock_vga
    port map (
      clk_out1 => pclk,
      locked   => locked,
      clk_in1  => clk);

  vga80x40_1 : entity work.vga80x40
    port map (
      reset    => reset,
      clk25MHz => pclk,
      TEXT_A   => TEXT_A,
      TEXT_D   => TEXT_D,
      FONT_A   => FONT_A,
      FONT_D   => FONT_D,
      ocrx     => ocrx,
      ocry     => ocry,
      octl     => octl,
      R        => R,
      G        => G,
      B        => B,
      hsync    => hsync,
      vsync    => vsync);





end architecture arch;
