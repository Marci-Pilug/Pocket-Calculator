library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity calculator_top is
    Port(
        clk      : in  std_logic;
        reset    : in  std_logic;
        operand1 : in  signed(7 downto 0);
        operand2 : in  signed(7 downto 0);
        B_ADD    : in std_logic; 
        B_SUB    : in std_logic; 
        B_MUL    : in std_logic; 
        B_DIV    : in std_logic; 
        an       : out std_logic_vector(3 downto 0);
        seg      : out std_logic_vector(6 downto 0);
        err_led  : out std_logic
    );
end calculator_top;

architecture Behavioral of calculator_top is

    signal result_selected : signed(15 downto 0);
    signal bcd_result      : unsigned(19 downto 0);
    signal sign_result     : std_logic;
    signal err_signal      : std_logic;

    signal op_code : std_logic_vector(1 downto 0);

begin

    process(B_ADD, B_SUB, B_MUL, B_DIV)
    begin
        if B_ADD = '1' then
            op_code <= "00";
        elsif B_SUB = '1' then
            op_code <= "01";
        elsif B_MUL = '1' then
            op_code <= "10";
        elsif B_DIV = '1' then
            op_code <= "11";
        else
            op_code <= "00"; 
        end if;
    end process;
    
    OPERATION_SELECTOR_INST : entity work.operation_selector
        port map (
            A      => operand1,
            B      => operand2,
            OP     => op_code,
            result => result_selected,
            err    => err_signal
        );

    BINtoBCD_INST : entity work.bin_to_BCD
        port map (
            bin_in   => std_logic_vector(result_selected),
            sgn_out  => sign_result,
            num_out  => bcd_result
        );

    DISPLAY_INST : entity work.display_7seg_4digit
        port map (
            clk     => clk,
            reset   => reset,
            bcd_in  => bcd_result,
            sign_in => sign_result,
            an      => an,
            seg     => seg
        );

    err_led <= err_signal;

end Behavioral;