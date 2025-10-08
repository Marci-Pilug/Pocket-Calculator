library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_7seg_4digit is
    Port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        bcd_in    : in  unsigned(19 downto 0); 
        sign_in   : in  std_logic;            
        an        : out std_logic_vector(3 downto 0); 
        seg       : out std_logic_vector(6 downto 0)  
    );
end display_7seg_4digit;

architecture Behavioral of display_7seg_4digit is
    signal digit_index      : integer range 0 to 3  := 0;
    signal refresh_counter  : unsigned(15 downto 0) := (others => '0');
    signal digit_val        : unsigned(3 downto 0);
begin

    process(clk, reset)
    begin
        if reset = '1' then
            refresh_counter <= (others => '0');
            digit_index <= 0;
        elsif rising_edge(clk) then
            refresh_counter <= refresh_counter + 1;
            if refresh_counter = 0 then
                if digit_index = 3 then
                    digit_index <= 0;
                else
                    digit_index <= digit_index + 1;
                end if;
            end if;
        end if;
    end process;

    process(bcd_in, digit_index)
    begin
        case digit_index is
            when 0 => digit_val <= bcd_in(3 downto 0);     
            when 1 => digit_val <= bcd_in(7 downto 4);     
            when 2 => digit_val <= bcd_in(11 downto 8);    
            when 3 => digit_val <= bcd_in(15 downto 12);   
            when others => digit_val <= "0000";
        end case;
    end process;

        with digit_index select
        an <= "1110" when 0,
              "1101" when 1,
              "1011" when 2,
              "0111" when 3,
              "1111" when others;

        process(digit_val, sign_in, digit_index)
    begin
        if digit_index = 3 and sign_in = '1' then
            seg <= "1111110";  
        else
            case digit_val is
                when "0000" => seg <= "0000001"; 
                when "0001" => seg <= "1001111";  
                when "0010" => seg <= "0010010";  
                when "0011" => seg <= "0000110";  
                when "0100" => seg <= "1001100";  
                when "0101" => seg <= "0100100";  
                when "0110" => seg <= "0100000";  
                when "0111" => seg <= "0001111";  
                when "1000" => seg <= "0000000";  
                when "1001" => seg <= "0000100";  
                when others => seg <= "1111111";  
            end case;
        end if;
    end process;

end Behavioral;