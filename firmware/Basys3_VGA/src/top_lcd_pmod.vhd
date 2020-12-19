--
-- VGA 80x40 text on 640x480 raster with PMOD LCD
-- (VGA output simultaneously)
-- switches 0-7 set ascii char displayed at all locations
-- switches 8-10 set color

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity top_lcd_pmod is

  port (
    clk        : in  std_logic;
    vgaRed     : out std_logic_vector(3 downto 0);
    vgaBlue    : out std_logic_vector(3 downto 0);
    vgaGreen   : out std_logic_vector(3 downto 0);
    Hsync      : out std_logic;
    Vsync      : out std_logic;
    led        : out std_logic_vector(7 downto 0);
    sw         : in  std_logic_vector(12 downto 0);
    JA, JB, JC : out std_logic_vector(7 downto 0)
    );
end entity top_lcd_pmod;

architecture arch of top_lcd_pmod is

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
      vsync    : out std_logic;
      disp     : out std_logic
      );
  end component vga80x40;

  component mem_font is
    port (
      addr : in  std_logic_vector(11 downto 0);
      dout : out std_logic_vector(07 downto 0));
  end component mem_font;

  signal pclk  : std_logic;
  signal reset : std_logic;

  signal s_disp, s_vsync, s_hsync : std_logic;
  signal not_disp : std_logic;
  

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

  not_disp <= not s_disp;

  -- wire up the PMODs
  JA(0) <= not_disp;                      -- DEN
  JA(1) <= R;                           -- R5
  JA(2) <= '0';                           -- R3
  JA(3) <= '0';                           -- R1
  JA(4) <= pclk;                        -- CLK
  JA(5) <= '0';                           -- R4
  JA(6) <= '0';                           -- R2
  JA(7) <= '0';                           -- R0

  JB(0) <= s_vsync;                     -- VS
  JB(1) <= G;                           -- G5
  JB(2) <= '0';
  JB(3) <= '0';
  JB(4) <= s_hsync;                     -- HS
  JB(5) <= '0';
  JB(6) <= '0';
  JB(7) <= '0';

  JC(0) <= sw(11);                      -- DISP
  JC(1) <= B;
  JC(2) <= '0';
  JC(3) <= '0';
  JC(4) <= sw(12);                      -- REV
  JC(5) <= '0';
  JC(6) <= '0';
  JC(7) <= '0';

  -- all full intensity
  vgaRed(0) <= R;
  vgaRed(1) <= R;
  vgaRed(2) <= R;
  vgaRed(3) <= R;

  vgaGreen(0) <= G;
  vgaGreen(1) <= G;
  vgaGreen(2) <= G;
  vgaGreen(3) <= G;

  vgaBlue(0) <= B;
  vgaBlue(1) <= B;
  vgaBlue(2) <= B;
  vgaBlue(3) <= B;

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
      vsync    => s_vsync,
      disp     => s_disp);

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
        if(frames = X"3b") then
          frames <= (others => '0');
        end if;
      end if;
    end if;
  end process;

end architecture arch;
