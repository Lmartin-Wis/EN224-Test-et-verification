----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 17:15:26
-- Design Name: 
-- Module Name: PGCD_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity PGCD_tb is
end;

architecture bench of PGCD_tb is

  component PGCD
  Port ( 
          CLK     : in STD_LOGIC;
          RESET   : in STD_LOGIC;
         idata_a  : in STD_LOGIC_VECTOR (31 downto 0);
         idata_b  : in STD_LOGIC_VECTOR (31 downto 0);
         idata_en : in STD_LOGIC;
         odata    : out STD_LOGIC_VECTOR (31 downto 0);
         odata_en : out STD_LOGIC
  );
  end component;

  signal CLK: STD_LOGIC;
  signal RESET: STD_LOGIC;
  signal idata_a: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_b: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_en: STD_LOGIC;
  signal odata: STD_LOGIC_VECTOR (31 downto 0);
  signal odata_en: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

  signal odata_test : std_logic_vector (31 downto 0);
  file file_A : text;
  file file_B : text;
  file file_C : text;

begin

  

  uut: PGCD port map ( CLK      => CLK,
                       RESET    => RESET,
                       idata_a  => idata_a,
                       idata_b  => idata_b,
                       idata_en => idata_en,
                       odata    => odata,
                       odata_en => odata_en );

  stimulus: process
  
  variable v_line_A    : line;
  variable v_line_B    : line;
  variable v_line_C    : line;
  variable v_val_A : std_logic_vector(31 downto 0);
  variable v_val_B : std_logic_vector(31 downto 0);
  variable v_val_C : std_logic_vector(31 downto 0);
  
  begin
    file_open(file_A, "/net/s/lmartin042/S8/verif/EN224-Test-et-verification/2_Hardware/Etape_4/test_generator/data_a.txt",  read_mode);
    file_open(file_B, "/net/s/lmartin042/S8/verif/EN224-Test-et-verification/2_Hardware/Etape_4/test_generator/data_b.txt",  read_mode);
    file_open(file_C, "/net/s/lmartin042/S8/verif/EN224-Test-et-verification/2_Hardware/Etape_4/test_generator/data_c.txt",  read_mode);
  
    -- Put initialisation code here
    RESET <= '1';
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    idata_en <= '0';
    wait for 4*clock_period;
    
    RESET <= '0';
    wait for 4*clock_period;
    
    while not endfile(file_A) loop
      readline(file_A, v_line_A);
      read(v_line_A, v_val_A);
      
      readline(file_B, v_line_B);
      read(v_line_B, v_val_B);
      
      readline(file_C, v_line_C);
      read(v_line_C, v_val_C);
      
      -- Pass the variable to a signal to allow the ripple-carry to use it
      idata_a <= v_val_A;
      idata_b <= v_val_B;
      odata_test <= v_val_C;
      
      idata_en <= '1';
      wait for clock_period;
      while odata_en = '0' loop
          idata_en <= '0';
          wait for 10 ns;
      end loop;
      ASSERT UNSIGNED(odata) = UNSIGNED(odata_test) SEVERITY ERROR;

    end loop;
    file_close(file_A);
    file_close(file_B);
    file_close(file_C);
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  
