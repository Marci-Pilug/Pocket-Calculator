library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity operation_selector is
    Port(
        A      : in signed (7 downto 0);
        B      : in signed (7 downto 0);
        OP     : in std_logic_vector (1 downto 0);
        result : out signed (15 downto 0);
        err    : out std_logic
    );
end operation_selector;

architecture Behavioral of operation_selector is
    signal sum_rez  : signed (8 downto 0);
    signal diff_rez : signed (8 downto 0);
    signal mul_rez  : signed (15 downto 0);
    signal div_Q    : signed (7 downto 0);
    signal div_R    : signed (7 downto 0);

    component adder is
        Port(
            A   : in signed (7 downto 0);
            B   : in signed (7 downto 0);
            Sum : out signed (8 downto 0)
        );
    end component;

    component subtractor is 
        Port(
            A    : in signed (7 downto 0);
            B    : in signed (7 downto 0);
            Diff : out signed (8 downto 0)
        );
    end component;

    component multiplier is
        Port(
            A    : in signed (7 downto 0);
            B    : in signed (7 downto 0);
            Prod : out signed (15 downto 0)
        );
    end component;

    component division is 
        Port(
            A : in signed (7 downto 0);
            B : in signed (7 downto 0);
            Q : out signed (7 downto 0);
            R : out signed (7 downto 0)
        );
    end component;

begin

    ADDER_ET : adder
        port map (
            A   => A,
            B   => B,
            Sum => sum_rez
        );

    SUB_ET : subtractor
        port map (
            A    => A,
            B    => B,
            Diff => diff_rez
        );

    MUL_ET : multiplier
        port map (
            A    => A,
            B    => B,
            Prod => mul_rez
        );

    DIV_ET : division
        port map (
            A => A,
            B => B,
            Q => div_Q,
            R => div_R
        );

    process (A, B, OP, sum_rez, diff_rez, mul_rez, div_Q)
    begin
        err <= '0';
        case OP is
            when "00" => 
                result <= resize(sum_rez, 16);
                if sum_rez > to_signed(127, 9) or sum_rez < to_signed(-128, 9) then
                    err <= '1';
                end if;

            when "01" => 
                result <= resize(diff_rez, 16);
                if diff_rez > to_signed(127, 9) or diff_rez < to_signed(-128, 9) then
                    err <= '1';
                end if;

            when "10" => 
                result <= mul_rez;
                if mul_rez > to_signed(127, 16) or mul_rez < to_signed(-128, 16) then
                    err <= '1';
                end if;

            when "11" => 
                if B = to_signed(0, 8) then
                    result <= (others => '0');
                    err    <= '1';
                else
                    result <= resize(div_Q, 16);
                end if;

            when others =>
                result <= (others => '0');
                err    <= '1';
        end case;
    end process;

end Behavioral;