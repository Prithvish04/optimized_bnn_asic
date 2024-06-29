----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05/17/2021 11:39:54 AM
-- Design Name:
-- Module Name: reg_8bit - Behavioral
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

entity reg_8bit is
     Port (CLK:    in std_logic;
           rst:    in std_logic;
           enx: in std_logic;
           eny: in std_logic;
           input:  in std_logic_vector(7 downto 0);
           output: out std_logic_vector(7 downto 0)
     );
end reg_8bit;

architecture Behavioral of reg_8bit is
  signal D, Q : std_logic_vector(7 downto 0);

begin
    process (rst, CLK)
	begin
        if (rst = '1') then
            Q <= (others => '0');
        elsif rising_edge(CLK) then
            if enx = '1' and eny = '1' then
              Q	<= D;
            else 
              Q <= Q;
            end if;
        end if;
	end process;

D <= input;
output <= Q;


end Behavioral;
