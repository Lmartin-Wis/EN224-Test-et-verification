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

begin

  uut: PGCD port map ( CLK      => CLK,
                       RESET    => RESET,
                       idata_a  => idata_a,
                       idata_b  => idata_b,
                       idata_en => idata_en,
                       odata    => odata,
                       odata_en => odata_en );

  stimulus: process
  begin
  
    -- Put initialisation code here


    RESET <= '1';
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    idata_en <= '0';
    wait for 4*clock_period;
    
    RESET <= '0';
    wait for 4*clock_period;
    
    idata_a <= x"00000001";
    idata_b <= x"00000008";
    idata_en <= '1';
    wait for clock_period;
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    idata_en <= '0';
    wait for 120*clock_period;
    
    idata_a <= x"00000007";
    idata_b <= x"00000042";
    idata_en <= '1';
    wait for clock_period;
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    idata_en <= '0';
    wait for 100*clock_period;
    
    -- Put test bench stimulus code here
    wait for 1000 ns;
    stop_the_clock <= true;
    wait;
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
  
