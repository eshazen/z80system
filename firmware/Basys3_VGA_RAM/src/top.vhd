--
-- VGA 80x40 text on 640x480 raster
-- 
-- switches 0-7 set ascii char displayed at all locations
-- switches 8-10 set color

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity top is

  port (
    clk      : in  std_logic;
    vgaRed   : out std_logic_vector(3 downto 0);
    vgaBlue  : out std_logic_vector(3 downto 0);
    vgaGreen : out std_logic_vector(3 downto 0);
    Hsync    : out std_logic;
    Vsync    : out std_logic;
    led      : out std_logic_vector(7 downto 0);
    sw       : in  std_logic_vector(10 downto 0)
    );
end entity top;

architecture arch of top is

  component clk_vga is
    port (
      clk_out1 : out std_logic;
      locked   : out std_logic;
      clk_in1  : in  std_logic);
  end component clk_vga;

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

  component mem_font is
    port (
      addr : in  std_logic_vector(11 downto 0);
      dout : out std_logic_vector(07 downto 0));
  end component mem_font;

  signal pclk  : std_logic;
  signal reset : std_logic;

  signal s_vsync, s_hsync : std_logic;

  signal R, G, B        : std_logic;
  signal TEXT_A, FONT_A : std_logic_vector(11 downto 0);
  signal TEXT_D, FONT_D : std_logic_vector(7 downto 0);

  signal locked : std_logic;

  signal color : std_logic_vector(2 downto 0);

  signal frames : std_logic_vector(7 downto 0);
  signal vs0    : std_logic;

  signal control : std_logic_vector(7 downto 0);

begin  -- architecture arch

  reset <= '0';                         -- we don't need no steenkin reset!

  led <= frames;

  color <= sw(10 downto 8);

  control <= "10000" & color;

  TEXT_D <= sw(7 downto 0);

  -- all full intensity
  vgaRed(0) <= R;
  vgaRed(1) <= R;
  vgaRed(2) <= R;

  vgaGreen(0) <= G;
  vgaGreen(1) <= G;
  vgaGreen(2) <= G;

  vgaBlue(0) <= B;
  vgaBlue(1) <= B;
  vgaBlue(2) <= B;

  Hsync <= s_hsync;
  Vsync <= s_vsync;

  clk_vga_1 : entity work.clk_vga
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
      ocrx     => X"00",
      ocry     => X"00",
      octl     => control,
      R        => R,
      G        => G,
      B        => B,
      hsync    => s_hsync,
      vsync    => s_vsync);

  -- character generator
  mem_font_1 : entity work.mem_font
    port map (
      addr => FONT_A,
      dout => FONT_D);

  process (clk) is
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      vs0 <= s_vsync;
      if(vs0 = '0' and s_vsync = '1') then
        frames <= frames + 1;
        if( frames = X"3b") then
          frames <= (others => '0');
        end if;
      end if;
    end if;
  end process;

end architecture arch;
