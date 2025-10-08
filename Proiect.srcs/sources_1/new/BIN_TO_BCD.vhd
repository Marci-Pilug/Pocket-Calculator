library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin_to_BCD is
    Port (
        bin_in  : in  STD_LOGIC_VECTOR(15 downto 0); 
        sgn_out : out STD_LOGIC;                     
        num_out : out unsigned(19 downto 0)    
    );
end bin_to_BCD;

architecture Behavioral of bin_to_BCD is
begin
    process(bin_in)
        variable num     : integer;  
        variable abs_num : natural; 
        variable digit   : natural;
    begin
        num := to_integer(signed(bin_in));
        
        if num < 0 then 
            sgn_out <= '1';
        else 
            sgn_out <= '0';
        end if;
       
        if num < 0 then
            abs_num := -num;
        else 
            abs_num := num;
        end if;

        
        digit := abs_num / 10000;  -- zeci de mii
        num_out(19 downto 16) <= (to_unsigned(digit, 4));
        
        digit := (abs_num / 1000) mod 10;  -- mii
        num_out(15 downto 12) <= (to_unsigned(digit, 4));
        
        digit := (abs_num / 100) mod 10;   -- sute
        num_out(11 downto 8) <= (to_unsigned(digit, 4));
        
        digit := (abs_num / 10) mod 10;    -- zeci
        num_out(7 downto 4) <= (to_unsigned(digit, 4));
        
        digit := abs_num mod 10;           -- unitati
        num_out(3 downto 0) <= (to_unsigned(digit, 4));
    end process;
end Behavioral;