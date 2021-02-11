----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 15:24:36
-- Design Name: 
-- Module Name: PGCD - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PGCD is
Port ( 
        CLK     : in STD_LOGIC;
        RESET   : in STD_LOGIC;
        
       idata_a  : in STD_LOGIC_VECTOR (31 downto 0);
       idata_b  : in STD_LOGIC_VECTOR (31 downto 0);
       idata_en : in STD_LOGIC;
        
       odata    : out STD_LOGIC_VECTOR (31 downto 0);
       odata_en : out STD_LOGIC
);
end PGCD;

architecture Behavioral of PGCD is

type Etat is (Etat_Init, Etat_Calcul, Etat_Out);
signal pr_state, nx_state : Etat := Etat_Init;
signal copy_a, copy_b, copy_assert_A, copy_assert_B : unsigned(31 downto 0);

begin

maj_etat : process (CLK, RESET)
    begin
    
        if(RESET = '1') then
            pr_state <= Etat_Init;
        
        elsif(clk'event and CLK = '1') then
            pr_state <= nx_state;
        end if;
    
end process maj_etat;

cal_nx_state : process (CLK, RESET)
    begin
        case pr_state is
        
            when Etat_Init => 
                if (idata_en = '1') then
                    nx_state <= Etat_Calcul;
                else 
                    nx_state <= Etat_Init;
                end if;
            
            when Etat_Calcul => 
                if (copy_a = copy_b) then
                    nx_state <= Etat_Out;
                else
                    nx_state <= Etat_Calcul;
                end if;
                
            when Etat_Out => 
                -- if (idata_en = '1') then
                nx_state <= Etat_Init;
                -- end if;
            
            when OTHERS => nx_state <= Etat_Init;
  
  end case;  

end process cal_nx_state;

cal_output : process ( CLK, RESET )
    begin
        
        if(RESET = '1') then
            copy_a <= to_unsigned(0,32);
            copy_b <= to_unsigned(0,32);
            odata_en <= '0';
        
        elsif(clk'event and CLK = '1') then
            
        
            case pr_state is
                when Etat_Init =>
                    
                    copy_a   <= unsigned (idata_a);
                    copy_b   <= unsigned (idata_b);
                    copy_assert_A <= unsigned (idata_a); 
                    copy_assert_B   <= unsigned (idata_b);
                    odata_en <= '0';
                    assert(copy_a >= 0) report "A negative";
                    assert(copy_b >= 0) report "B negative";
                    assert(copy_a <= 65535) report "A not on 32 bits";
                    assert(copy_b <= 65535) report "B not on 32 bits";

                 when Etat_Calcul =>
                    if (copy_a = 0) then
                        copy_a <= copy_b;
                    elsif(copy_b = 0) then
                        copy_b <= copy_a;
                    elsif(copy_a > copy_b) then
                        copy_a <= copy_a - copy_b;
                        copy_b <= copy_b;
                    elsif (copy_b > copy_a) then
                        copy_a <= copy_a;
                        copy_b <= copy_b - copy_a;
                    else 
                        copy_a <= copy_a;
                        copy_b <= copy_b;
                    end if; 
        
                 when Etat_Out =>
                     if (copy_a = 0 AND copy_b = 0) then
                        assert(copy_a = copy_b) report "A != B";  
                         odata <= STD_LOGIC_VECTOR(copy_a);                         
                     else
                        assert(copy_a > 0) report " A > 0";
                        assert(copy_a = copy_b) report "A != B";
                        assert((copy_a mod unsigned(copy_assert_A)) = 0) report "Result not divide A";
                        assert((copy_b mod unsigned(copy_assert_b)) = 0) report "Resimt not divide B";
                        odata <= STD_LOGIC_VECTOR(copy_a);
                        odata_en <= '1';
                     end if;
                 when OTHERS => odata_en <= '0';
        
            end case;
        end if;
    
end process cal_output;
    
end Behavioral;
