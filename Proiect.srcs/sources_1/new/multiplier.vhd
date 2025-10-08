library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity multiplier is
    Port(
        A    : in signed (7 downto 0);
        B    : in signed (7 downto 0);
        Prod : out signed (15 downto 0)
        );
end multiplier;

architecture Behavioral of multiplier is
begin
    process (A, B)
        variable A_abs    : signed (15 downto 0);
        variable B_abs    : signed (7 downto 0);
        variable rez_temp : signed (15 downto 0);
        variable sign_rez : std_logic;
    begin 
        sign_rez := A(7) xor B(7);  --determinam semnul rezultatului
        if A(7) = '1' then 
            A_abs := resize (-A, 16);
        else 
            A_abs := resize (A, 16);
        end if;
        
        if B(7) = '1' then 
            B_abs := -B;
        else 
            B_abs := B;
        end if;
        
        rez_temp := (others => '0');
        
        for i in 0 to 7 loop
            if A_abs(i) = '1' then 
                rez_temp := rez_temp + shift_left(A_abs, i);
            end if; 
        end loop; 
        
        if sign_rez = '1' then 
            Prod <= -rez_temp;
        else 
            Prod <= rez_temp;
        end if;
    end process;    

end Behavioral;