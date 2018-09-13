----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2018 08:47:27 PM
-- Design Name: 
-- Module Name: barrel_shifter - Behavioral
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
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity barrel_shifter is
    generic(WIDTH : natural := 8);
    port(
        clk : in std_logic;
        shift_amount : in std_logic_vector(integer(ceil(log2(real(WIDTH)))) - 1 downto 0);
        input : in std_logic_vector(WIDTH - 1 downto 0);
        output : out std_logic_vector(WIDTH - 1 downto 0)
    );
end barrel_shifter;

architecture main of barrel_shifter is

-- Since signals are just wires, I'm using a single large signal in place of multiple smaller signals to allow me to use for loops
signal intermediate : std_logic_vector(shift_amount'length * WIDTH - 1 downto 0);

begin

    output_reg : process(clk) begin
        if rising_edge(clk) then
            output <= intermediate(intermediate'length - 1 downto intermediate'length - WIDTH); -- number of most significant bits equal to WIDTH
        end if;
    end process;
    
    intermediates : process(intermediate, shift_amount, input) begin
        -- the first few rows of each column pull '0' when they are shifting. this # of rows depends on which column
        -- i.e. on column 3, the first 3 rows multiplex '0' and the output from column 2
        -- Handle i=0 (first column)
        if shift_amount(0) = '1' then
            intermediate(0) <= '0';
        else
            intermediate(0) <= input(0);
        end if;
        
        for j in 1 to WIDTH - 1 loop -- row
            if shift_amount(0) = '1' then
                intermediate(j) <= input(j - 1);
            else
                intermediate(j) <= input(j);
            end if;
        end loop;
                
        -- Handle i>0 (all other columns)
        for i in 1 to shift_amount'length - 1 loop -- column
            for j in 0 to 2**i - 1 loop -- row
                if shift_amount(i) = '1' then
                    intermediate(WIDTH*i + j) <= '0';
                else
                    intermediate(WIDTH*i + j) <= intermediate(WIDTH*(i-1) + j);
                end if;
            end loop;
        end loop;
        
        for i in 1 to shift_amount'length - 1 loop -- column
            for j in 2**i to WIDTH - 1 loop -- row
                if shift_amount(i) = '1' then
                    intermediate(WIDTH*i + j) <= intermediate(WIDTH*(i-1) + j - 2**i);
                else
                    intermediate(WIDTH*i + j) <= intermediate(WIDTH*(i-1) + j);
                end if;
            end loop;
        end loop;
    end process;

end main;
