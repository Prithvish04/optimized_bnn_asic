-- the input weights and images are encoded: 0(-1) and 1(+1)
-- this implementation assumes reading a pixel each clock cycle; can be improved
-- no padding with zero is done
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

library xil_defaultlib;
use xil_defaultlib.custom_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bnn_conv is
  Port ( CLK: in  std_logic;
         rst: in  std_logic;
         --pixels_in: in std_logic_vector (7 downto 0); --pixels arrive 8 at a time
         pixels_in: std_logic;
         weights_in: in std_logic_vector(647 downto 0);
         px_out: out std_logic_vector(7 downto 0); --ach cycle produces a pixel for each out img
         done: out std_logic );
end bnn_conv;

architecture Behavioral of bnn_conv is


component conv_reg is
      Port (CLK:            in  std_logic;
            rst:            in  std_logic;
            addr: in  integer range 0 to 399;
            wr_en: in  std_logic;
            re_en: in  std_logic;
            input: in  std_logic_vector(7 downto 0);
            output: out std_logic_vector(7 downto 0)
      );
end component;

type arr is array (0 to 7) of std_logic_vector(80 downto 0);
--type arr is array (0 to 7, 0 to 8) of std_logic_vector(80 to 0);
signal shift_reg : std_logic_vector(251 downto 0); --latch first 28*9 pixels; 
signal xnor_buf : arr;
signal addr: integer range 0 to 399;
signal counter, idx_out: integer range -1 to 1000;
signal px_val, outp: std_logic_vector(7 downto 0);

signal wr_en, re_en: std_logic;

begin

wr_to_reg: component conv_reg
      port map (CLK => CLK,
            rst => rst,
            addr => addr,
            wr_en => wr_en,
            re_en => re_en,
            input => px_val,
            output => outp
      );

px_shift: process(CLK, rst) is
begin
    if (rst = '1') then 
        shift_reg <= (others => '0');
    elsif (CLK'event and CLK = '1') then
          for x in 0 to 251 loop 
                if x = 0 then
                   shift_reg(0) <= pixels_in; --reg 0 
                else
                   shift_reg(x) <= shift_reg((x-1));	 
                end if;
           end loop;
--        for x in 0 to 28*9/8 loop --  0 to 31 means 32 regs
--	       if x = 0 then
--               shift_reg(7 downto 0) <= pixels_in(7 downto 0); --reg 0 
--           else
--               shift_reg(x*8 + 7 downto x*8) <= shift_reg((x-1)*8 + 7 downto (x-1)*8);	 
--           end if;
--        end loop;
    end if;
end process;  

xnor_proc: process(weights_in, shift_reg) is
begin
    for x in 0 to 7 loop --8 filters
        for y in 0 to 8 loop -- kernel dim1
            for z in 0 to 8 loop --kernel dim2
                xnor_buf(x)(y*9+z) <= weights_in(x*81 + y*9 + z) xnor (shift_reg((28*9-1)-(28*y) - z )); --w(x,y,z) xnor ()(28*9-1)-(28*y) - z (8-y)*28 + (8-z))
        end loop;
    end loop;   
end loop;
end process;


out_val: process(xnor_buf) is
    variable cnt_ones : integer range 0 to 81; 
begin
    for i in 0 to 7 loop
        cnt_ones := 0;
        for x in 0 to 8 loop
            for y in 0 to 8 loop
                if (xnor_buf(i)(x*9+y) = '1') then
                    cnt_ones := cnt_ones + 1;
                end if;
            end loop;
        end loop;
        if (2*cnt_ones - 81) >= 0 then
            px_val(i) <= '1';
        else
            px_val(i) <= '0'; 
        end if;
    end loop;
end process;


counter_proc: process(CLK, rst) is
begin
    if (rst = '1') then 
        counter <= 0;
        --img_out <= (others => (others => '0'));
    elsif (CLK'event and CLK = '1') then
        if (idx_out >= 0 and idx_out < 784 and (idx_out mod 28)< 20) then
           --addr <= idx_out/28*20 + idx_out mod 20;
           px_out <= px_val;
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
        if (((counter - 252) mod 28)< 20) then
            wr_en <= '1';
            addr <= (counter-252)/28*20 + (counter-252) mod 28;
        end if;
    else
        done <= '1';
        idx_out <= counter - 252;
    end if;
end process;

end Behavioral;