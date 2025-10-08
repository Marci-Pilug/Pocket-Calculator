library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity formare_nr is
    Port(
       clk      : in std_logic; 
       reset    : in std_logic;
       load_bit : in std_logic;
       bit_in   : in std_logic;
       num_out  : out signed (7 downto 0);
       ready    : out std_logic
        );
end formare_nr;

architecture Behavioral of formare_nr is
    signal num_temp : signed (7 downto 0) := (others => '0');
    signal cnt      : integer range 0 to 8 := 0;
    
begin
    process(clk, reset)
    begin
        if reset = '1' then 
            num_temp <= (others => '0');
            cnt      <= 0;
            ready    <= '0';
        elsif rising_edge (clk) then 
            if load_bit = '1' then 
                num_temp <= num_temp (6 downto 0) & bit_in;  --shift la stanga si intra bitul nou
                if cnt < 7 then 
                    cnt   <= cnt + 1;
                    ready <= '0';
                else 
                    cnt   <= 0;
                    ready <= '1';  --numarul e complet
                end if;
            end if; 
        end if;
    end process;
    
    num_out <= num_temp;       

end Behavioral;