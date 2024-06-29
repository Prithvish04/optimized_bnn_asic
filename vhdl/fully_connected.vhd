----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/22/2021 07:12:18 PM
-- Design Name: 
-- Module Name: fully_connected - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fully_connected is
Port (  CLK: in  std_logic;
        rst: in  std_logic;
        w_fc: in std_logic_vector(7999 downto 0);
        max_pool_in: in std_logic_vector(79 downto 0);
        label_out: out std_logic_vector(3 downto 0) --label binary 0 to 10
        --done: out std_logic 
        ); 
end fully_connected;

architecture Behavioral of fully_connected is

type arr is array (0 to 9, 0 to 79) of std_logic;
type arr2 is array (0 to 9, 0 to 799) of std_logic;
type arr3 is array (0 to 9) of integer range -800 to 800;

signal xnor_buf : arr2; 
signal flatten: std_logic_vector (799 downto 0);
signal shift_reg : arr; --latch first 28*9 pixels; 

signal label_arr: arr3;

signal counter, idx_out: integer range -1 to 1000;
signal lab:  integer range 0 to 9;

signal maxm: integer range -800 to 800;

begin

px_shift: process(CLK, rst) is
begin
    if (rst = '1') then --initializ shift reg with 0
        shift_reg <= (others => (others =>'0'));
        
    elsif (CLK'event and CLK = '1') then
         if ((idx_out - 2) mod 56 = 48 ) then --only buffer if input valid -- -2 is a delay : one for conv and one for max pool
            for x in 0 to 9 loop
                for y in 0 to 79 loop
                   if (x = 9) then
                     shift_reg(x, y) <=  max_pool_in(y);
                   else
                     shift_reg(x, y) <=  shift_reg(x+1, y);
                   end if;
                 end loop;
            end loop;
      end if;
    end if;  
     
end process;  


flatten_proc: process(shift_reg) is
begin
        for x in 0 to 9 loop
            for y in 0 to 79 loop
                flatten(y/10*100 + x*10 + y mod 10) <= shift_reg(x,y);
            end loop;
       end loop;
end process;



xnor_proc: process(flatten) is
begin
   -- if ((idx_out - 2) / 56 = 9 and  (idx_out - 2) mod 56 = 48)  then --here flatten is valid 
        for x in 0 to 9 loop --8 filters
            for y in 0 to 799 loop -- kernel dim1
                xnor_buf(x,y) <= w_fc(x*800 + y) xnor flatten(y); --w(x,y,z) xnor ()(28*9-1)-(28*y) - z (8-y)*28 + (8-z))
               
            end loop;   
        end loop;
   -- end if;
end process;


out_val: process(xnor_buf) is
    variable cnt_ones : integer range 0 to 2000;
    --variable max:  integer range  0 to 800 := 0;    
begin

   -- if (CLK'event and CLK = '1') then
        for i in 0 to 9 loop -- for each label
            cnt_ones := 0;
            for j in 0 to 799 loop
                if (xnor_buf(i, j) = '1') then
                    cnt_ones := cnt_ones + 1; --accumulate
                end if;
            end loop;
            
            label_arr(i) <= 2*cnt_ones - 800;
           -- if max <= (2*cnt_ones - 800) then
              -- max := (2*cnt_ones - 800);
               --lab <= i; 
           -- end if;
        end loop;
  -- end if;
end process;

find_max: process(label_arr) is
    variable max: integer range -800 to 800 := -800;
    variable i_max : integer range 0 to 9;
begin
    for i in 0 to 9 loop
        if i = 0 then
            max := label_arr(i);
        else
            if (max < label_arr(i)) then
            max := label_arr(i);
            i_max := i;
            end if;
        end if;
    end loop;
    maxm <= max;
    lab <= i_max;
end process;

counter_proc: process(CLK, rst) is
begin
    if (rst = '1') then 
        counter <= 0;
    elsif (CLK'event and CLK = '1') then
        if (idx_out =  555)  then --here flatten is valid 
            label_out <= std_logic_vector(TO_UNSIGNED(lab, 4));-- do sth;
        end if;
        counter <= counter + 1; -- count up to 400 * 8
    end if;
end process;  

assign_out: process(counter) is
begin
    if counter < 252 then
        --done <= '0';
        idx_out <= -1;
    elsif counter >= 252 and counter < 812 then
        idx_out <= counter - 252;
        --done <= '0';
    else
        --done <= '1';
        idx_out <= counter - 252;
    end if;
end process;

end Behavioral;
