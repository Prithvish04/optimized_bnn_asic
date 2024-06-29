----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/18/2021 08:53:23 PM
-- Design Name: 
-- Module Name: max_pool - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity max_pool is
Port (  CLK: in  std_logic;
        rst: in  std_logic;
        max_pool_in: in std_logic_vector(7 downto 0);
        max_pool_out: out std_logic_vector(79 downto 0); --compute 8 x 10 elements per clk cycle --each row is a kernel
        done: out std_logic ); 
end max_pool;

architecture Behavioral of max_pool is

type arr is array (0 to 7, 0 to 39) of std_logic;
type arr2 is array (0 to 7, 0 to 9) of std_logic;

signal shift_reg : arr; --latch first 28*9 pixels; 
signal out_reg: arr2;

--0 01010100010101010010101 ...
--1 010101010010101001010100...
--2
--3
--4
--5
--6
--7

signal counter, idx_out, idx_out_mxp: integer range -1 to 1000;

signal valid:  std_logic;

begin

px_shift: process(CLK, rst) is
begin
    if (rst = '1') then --initializ shift reg with 0
        for x in 0 to 7 loop 
            for y in 0 to 39 loop 
                shift_reg(x,y) <= '0';
            end loop; 
        end loop;
        
    elsif (CLK'event and CLK = '1') then
        if ((idx_out - 1) >= 0 and (idx_out - 1) < 784 and ((idx_out - 1) mod 28)< 20) then --only buffer if input valid --maybe need to delay 1 cycle 
            for y in 0 to 7 loop
              for x in 0 to 39 loop
                   if (x = 39) then
                       -- for y in 0 to 7 loop
                            shift_reg(y,x) <=  max_pool_in(y);
                        --end loop;
                   else
                        --for y in 0 to 7 loop
                            shift_reg(y,x) <=  shift_reg(y,x+1);
                       -- end loop;                 
                   end if;
               end loop;
             end loop;    
       end if;
    end if;  
     
end process;  


or_proc: process(shift_reg) is
begin
        for x in 0 to 7 loop 
            for y in 0 to 9 loop
                out_reg(x,y) <= shift_reg( x, 2*y ) or shift_reg( x, 2*y+1 ) or shift_reg( x, 2*y + 20 ) or shift_reg( x , 2*y+21);
            end loop;
        end loop;
end process;

counter_proc: process(CLK, rst) is
begin
    if (rst = '1') then 
        counter <= 0;
    elsif (CLK'event and CLK = '1') then
        if ((idx_out - 1) mod 56 = 48 ) then --it means 20 values have been loaded in the reg and the output is valid -- or 48
            for x in 0 to 7 loop
                for y in 0 to 9 loop 
                max_pool_out(x * 10 + y) <= out_reg(x,y);
                end loop;
            end loop;
         end if;
        counter <= counter + 1; -- count up to 400 * 8
    end if;
end process;  

assign_out: process(counter) is
begin
    if counter < 252 then
        done <= '0';
        idx_out <= -1;
    elsif counter >= 252 and counter < 812 then
        idx_out <= counter - 252;
        done <= '0';
    else
        done <= '1'; --done is wrong
        idx_out <= counter - 252;
    end if;
end process;

end Behavioral;
