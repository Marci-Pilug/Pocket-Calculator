library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity division is
    Port(
        A : in signed (7 downto 0);
        B : in signed (7 downto 0);
        Q : out signed (7 downto 0);
        R : out signed (7 downto 0)
        );
end division;

architecture Behavioral of division is

    signal A_abs     : signed (7 downto 0);
    signal B_abs     : signed (7 downto 0);
    signal sgn_Q     : std_logic;
    signal sgn_R     : std_logic;
    
begin
    process (A, B)
        variable A_temp      : signed (8 downto 0);
        variable B_temp      : signed (8 downto 0);
        variable i           : integer;
        variable cnt_scaderi : unsigned (7 downto 0);
        
    begin 
        sgn_Q <= A(7) xor B(7);  --detectam semnele
        sgn_R <= A(7);
    
        if A(7) = '1' then  --luam modulul lui A
            A_abs <= -A;
        else 
            A_abs <= A;
        end if;
        if B(7) = '1' then   --luam modulul lui B
            B_abs <= -B;
        else 
            B_abs <= B;
        end if;
            
        A_temp := resize (A_abs, 9);  --extind la 9 biti pentru shift
        B_temp := resize (B_abs, 9);  --extind la 9 biti pentru shift
        
        cnt_scaderi := (others => '0');
        
        for i in 7 downto 0 loop 
            A_temp := shift_left (A_temp, 1);  --shift stanga restul cu 1 si adauga bitul i din A_temp
            A_temp(0) := A_temp(8-i);
                    
            if A_temp >= B_temp then  --verificam daca restul >= divizorul
                A_temp         := A_temp - B_temp;
                cnt_scaderi(i) := '1';   --setam bitul i al catului
            else 
                cnt_scaderi(i) := '0';
            end if;
        end loop;
        
        if sgn_R = '1' then   --punem semnul la rest
            R <= -resize(A_temp(7downto 0), 8);
        else 
            R <= resize(A_temp(7 downto 0), 8);
        end if;
        
        if sgn_Q = '1' then
            Q <= -signed(cnt_scaderi);
        else 
            Q <= signed(cnt_scaderi);
        end if;  
    end process;    
    
end Behavioral;