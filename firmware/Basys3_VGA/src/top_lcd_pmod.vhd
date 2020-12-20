--
-- VGA 80x40 text on 640x480 raster with PMOD LCD
-- (VGA output simultaneously)
--
-- Receive UART data at 9600 baud
-- display on screen as received, except:
-- ^A = home cursor
-- ^B = clear screen and home cursor
--

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
    led        : out std_logic_vector(11 downto 0);
    sw         : in  std_logic_vector(12 downto 0);
    JA, JB, JC : out std_logic_vector(7 downto 0);
    RsRx       : in  std_logic;
    RsTx       : out std_logic
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

  component uart_rx6 is
    port (
      serial_in           : in  std_logic;
      en_16_x_baud        : in  std_logic;
      data_out            : out std_logic_vector(7 downto 0);
      buffer_read         : in  std_logic;
      buffer_data_present : out std_logic;
      buffer_half_full    : out std_logic;
      buffer_full         : out std_logic;
      buffer_reset        : in  std_logic;
      clk                 : in  std_logic);
  end component uart_rx6;

  component mem_text is
    port (
      clk   : in  std_logic;
      addra : in  std_logic_vector(11 downto 0);
      douta : out std_logic_vector(07 downto 0);
      dinb  : in  std_logic_vector(07 downto 0);
      addrb : in  std_logic_vector(11 downto 0);
      web   : in  std_logic;
      doutb : out std_logic_vector(07 downto 0));
  end component mem_text;

  signal pclk  : std_logic;
  signal reset : std_logic;

  signal s_disp, s_vsync, s_hsync : std_logic;
  signal not_disp                 : std_logic;


  signal R, G, B : std_logic;

  signal SCREEN_A, TEXT_A, FONT_A : std_logic_vector(11 downto 0);
  signal SCREEN_D, TEXT_D, FONT_D : std_logic_vector(7 downto 0);

  signal SCREEN_WR : std_logic;

  signal clear_scr : std_logic;

  signal locked : std_logic;

  signal color : std_logic_vector(2 downto 0);

  signal count    : std_logic_vector(7 downto 0);
  signal baud_16x : std_logic;

  signal buffer_read, buffer_data_present : std_logic;
  signal last_dpr                         : std_logic;

  signal uart_rx, uart_rx_data : std_logic_vector(7 downto 0);

  signal control : std_logic_vector(7 downto 0);

begin  -- architecture arch

  reset <= '0';                         -- we don't need no steenkin reset!

  color <= sw(10 downto 8);

  control <= "10000" & color;

  not_disp <= not s_disp;

  -- wire up the PMODs
  JA(0) <= not_disp;                    -- DEN
  JA(1) <= R;                           -- R5
  JA(2) <= '0';                         -- R3
  JA(3) <= '0';                         -- R1
  JA(4) <= pclk;                        -- CLK
  JA(5) <= '0';                         -- R4
  JA(6) <= '0';                         -- R2
  JA(7) <= '0';                         -- R0

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

  mem_text_1 : entity work.mem_text
    port map (
      clk   => pclk,
      addra => TEXT_A,
      douta => TEXT_D,
      dinb  => SCREEN_D,
      addrb => SCREEN_A,
      web   => SCREEN_WR,
      doutb => open);

  uart_rx6_1 : entity work.uart_rx6
    port map (
      serial_in           => RsRx,
      en_16_x_baud        => baud_16x,
      data_out            => uart_rx_data,
      buffer_read         => buffer_read,
      buffer_data_present => buffer_data_present,
      buffer_half_full    => open,
      buffer_full         => open,
      buffer_reset        => '0',
      clk                 => pclk);

  -- make 16x9600 baud from 25.173MHz
  led(8) <= clear_scr;

  led(9)  <= '0';
  led(10) <= '1';
  led(11) <= '1';

  process (pclk) is
  begin  -- process
    if pclk'event and pclk = '1' then   -- rising clock edge

      -- generate baud clock
      if(count = 164) then
        count    <= (others => '0');
        baud_16x <= '1';
      else
        count    <= count + 1;
        baud_16x <= '0';
      end if;

      SCREEN_WR   <= '0';
      buffer_read <= '0';

      last_dpr <= buffer_data_present;

      -- screen clear in process?
      if clear_scr = '1' then
        SCREEN_WR <= '1';
        SCREEN_D  <= X"20";             --space if clearing screen
        if SCREEN_A = 3199 then
          SCREEN_A  <= (others => '0');
          clear_scr <= '0';
        else
          SCREEN_A <= SCREEN_A + 1;
        end if;
      else
        SCREEN_D <= uart_rx_data;

        -- UART char received
        if(buffer_data_present = '1' and last_dpr = '0') then
          buffer_read <= '1';

          -- handle a few control characters
          
          -- ^A = HOME cursor
          if uart_rx_data = 1 then
            SCREEN_A <= (others => '0');
          -- ^B = clear to end
          elsif uart_rx_data = 2 then
            SCREEN_A <= (others => '0');
            clear_scr <= '1';
          else
            -- not special, write to memory
            SCREEN_WR   <= '1';
            if SCREEN_A = 3199 then
              SCREEN_A <= (others => '0');
            else
              SCREEN_A <= SCREEN_A + 1;
            end if;

          end if;


          led(7 downto 0) <= uart_rx_data;
        end if;
      end if;



    end if;


  end process;

end architecture arch;
