----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2021 11:54:56 AM
-- Design Name: 
-- Module Name: input_regFile - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_reg is
      Port (CLK:            in  std_logic;
            rst:            in  std_logic;
            addr: in  integer range 0 to 399;
            wr_en: in  std_logic;
            re_en: in  std_logic;
            input: in  std_logic_vector(7 downto 0);
            output: out std_logic_vector(7 downto 0)
      );
end conv_reg;

architecture Behavioral of conv_reg is

type arr is array (0 to 399) of std_logic_vector(7 downto 0);
signal elem_C: arr  := ((others => (others => '0')));
--signal elem_B: m_elem;

--signal tmp_A, tmp_B: unsigned(7 downto 0);

begin

    process (rst, CLK, addr) is
	begin
        if (rst = '1') then
            output <= (others => '0');          
        elsif (CLK'event and CLK = '1') then
            if (wr_en = '1') then
                elem_C(addr) <=  input;
                output <= input;
            elsif (re_en = '1') then
                output <= elem_C(addr);
            end if;
        end if;
	end process;
                     
end Behavioral;
