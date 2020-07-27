library IEEE;
use IEEE.std_logic_1164.all;

entity horiz is
  port (
    clk : in  std_ulogic;
    rst : in  std_ulogic;
    pix : out std_ulogic_vector(2 downto 0);  -- pixel out
    chr : out std_ulogic_vector(6 downto 0);  -- character out
    hb  : out std_ulogic;                     -- horiz blank
    hs  : out std_ulogic);                    -- horiz sync

end entity horiz;

architecture arch of horiz is

  component jkff is
    port (
      j, k         : in  std_ulogic;
      pre_n, clr_n : in  std_ulogic;
      clk_n        : in  std_ulogic;
      q            : out std_ulogic;
      q_n          : out std_ulogic);
  end component jkff;

  component ls163 is
    port (
      out1  : out std_ulogic_vector(3 downto 0);
      rc    : out std_ulogic;
      data  : in  std_ulogic_vector(3 downto 0);
      clock : in  std_ulogic;
      load  : in  std_ulogic;
      clear : in  std_ulogic;
      p     : in  std_ulogic;
      t     : in  std_ulogic);
  end component ls163;

  component ls11 is
    port (
      o1 : out std_ulogic;
      i1 : in  std_ulogic;
      i2 : in  std_ulogic;
      i3 : in  std_ulogic);
  end component ls11;

  component ls21 is
    port (
      o1 : out std_ulogic;
      i1 : in  std_ulogic;
      i2 : in  std_ulogic;
      i3 : in  std_ulogic;
      i4 : in  std_ulogic);
  end component ls21;

  signal pixel     : std_ulogic_vector(2 downto 0);  -- pixel 0-7
  signal char      : std_ulogic_vector(6 downto 0);  -- character 0-99
  signal hblank    : std_ulogic := '0';              -- horiz blanking
  signal hsync     : std_ulogic := '0';              -- horiz sync active
  signal n_hsync   : std_ulogic;                     -- horiz sync active
  signal clk_n     : std_ulogic;                     -- inverted clock
  signal blank_s   : std_ulogic := '0';              -- start blank
  signal blank_e   : std_ulogic := '0';              -- end blank
  signal n_blank_e : std_ulogic;                     -- end blank
  signal hsync_s   : std_ulogic := '0';              -- start h sync
  signal hsync_e   : std_ulogic := '0';              -- end h sync

  signal p_load : std_ulogic;                     -- pixel reload
  signal p_rc   : std_ulogic;                     -- pixel RCO
  signal p_ctr  : std_ulogic_vector(3 downto 0);  -- pixel counter

  signal c_ctr : std_ulogic_vector(7 downto 0);  -- char counter

  signal c_rc0 : std_ulogic;            -- first char ctr RCO
  signal c_rc1 : std_ulogic;            -- second char ctr RCO

  signal hblank_n : std_ulogic;

  signal hsync_q0 : std_ulogic;
  signal hsync_q1_n : std_ulogic;

begin  -- architecture arch

  hb       <= hblank;
  hs       <= hsync;
  n_hsync  <= not hsync;
  pixel    <= p_ctr(2 downto 0);
  pix      <= pixel;
  chr      <= c_ctr(6 downto 0);
  clk_n    <= not clk;

  ls163_1 : entity work.ls163           -- pixel count (3 bits)
    port map (
      out1  => p_ctr,
      rc    => p_rc,
      data  => "1000",                  -- (load to 8 for 3 bits)
      clock => clk,
      load  => p_load,
      clear => rst,
      p     => '1',
      t     => '1');

  p_load <= not p_rc;                   -- reload on rco

  ls163_2 : entity work.ls163           -- character 0-3
    port map (
      out1  => c_ctr(3 downto 0),
      rc    => c_rc0,
      data  => "0000",
      clock => clk,
      load  => n_blank_e,
      clear => rst,
      p     => '1',
      t     => p_rc);

  ls163_3 : entity work.ls163           -- character 4-6
    port map (
      out1  => c_ctr(7 downto 4),
      rc    => c_rc1,
      data  => "0000",
      clock => clk,
      load  => n_blank_e,
      clear => rst,
      p     => '1',
      t     => c_rc0);

  ls11_1 : entity work.ls11             -- start-of-blank
    port map (
      o1 => blank_s,
      i1 => c_ctr(6),
      i2 => c_rc0,
      i3 => hblank_n);

  ls21_1 : entity work.ls21             -- generate end-of-frame/blank
    port map (
      o1 => blank_e,
      i1 => c_ctr(0),
      i2 => c_ctr(1),
      i3 => c_ctr(5),
      i4 => hblank);

  n_blank_e <= not blank_e;

  ls11_2 : entity work.ls11             -- generate start of HS
    port map (
      o1 => hsync_s,
      i1 => c_ctr(0),
      i2 => hblank,
      i3 => n_hsync);

  ls11_3 : entity work.ls11             -- generate send of HS
    port map (
      o1 => hsync_e,
      i1 => hsync,
      i2 => c_ctr(2),
      i3 => c_ctr(3));

  jkff_1 : entity work.jkff             -- start HS FF
    port map (
      j     => hsync_s,
      k     => blank_e,
      pre_n => '1',
      clr_n => '1',
      clk_n => clk_n,
      q     => hsync_q0,
      q_n   => open);

  jkff_2 : entity work.jkff             -- end HS FF
    port map (
      j     => hsync_e,
      k     => blank_e,
      pre_n => '1',
      clr_n => '1',
      clk_n => clk_n,
      q     => open,
      q_n   => hsync_q1_n);

  jkff_3 : entity work.jkff             -- blank FF
    port map (
      j     => blank_s,
      k     => blank_e,
      pre_n => '1',
      clr_n => '1',
      clk_n => clk_n,
      q     => hblank,
      q_n   => hblank_n);

  hsync <= hsync_q0 and hsync_q1_n;
  

end architecture arch;
