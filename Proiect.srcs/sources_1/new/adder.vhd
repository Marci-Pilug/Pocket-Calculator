library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity adder is  
    Port( 
        A : in signed (7 downto 0);
        B : in signed (7 downto 0);
        Sum : out signed (8 downto 0)
        );
end adder;

architecture Behavioral of adder is 
    signal extendedA, extendedB : signed (8 downto 0);
    
begin 
    extendedA <= resize (A, 9);
    extendedB <= resize (B, 9);
    Sum       <= extendedA + extendedB;
end Behavioral;