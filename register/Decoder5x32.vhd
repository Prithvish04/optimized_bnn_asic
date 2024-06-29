----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:41:14 11/26/2016 
-- Design Name: 
-- Module Name:    Decoder5x32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

 
entity Decoder5x32 is port(
Enable : in std_logic;
Input : in std_logic_vector(4 downto 0);
Output : out std_logic_vector(27 downto 0));
end Decoder5x32;

architecture behavioural of Decoder5x32 is

begin

Output(0) <= (not Input(4))and(not Input(3)) and (not Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(1) <= (not Input(4))and(not Input(3)) and (not Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(2) <= (not Input(4))and(not Input(3)) and (not Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(3) <= (not Input(4))and(not Input(3)) and (not Input(2))and( Input(1)) and ( Input(0)) and Enable;
Output(4) <= (not Input(4))and(not Input(3)) and ( Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(5) <= (not Input(4))and(not Input(3)) and ( Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(6) <= (not Input(4))and(not Input(3)) and ( Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(7) <= (not Input(4))and(not Input(3)) and ( Input(2))and( Input(1)) and ( Input(0)) and Enable;

Output(8) <= (not Input(4))and( Input(3)) and (not Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(9) <= (not Input(4))and( Input(3)) and (not Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(10) <= (not Input(4))and( Input(3)) and (not Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(11) <= (not Input(4))and( Input(3)) and (not Input(2))and( Input(1)) and ( Input(0)) and Enable;
Output(12) <= (not Input(4))and( Input(3)) and ( Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(13) <= (not Input(4))and( Input(3)) and ( Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(14) <= (not Input(4))and( Input(3)) and ( Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(15) <= (not Input(4))and( Input(3)) and ( Input(2))and( Input(1)) and ( Input(0)) and Enable;

Output(16) <= ( Input(4))and(not Input(3)) and (not Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(17) <= ( Input(4))and(not Input(3)) and (not Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(18) <= ( Input(4))and(not Input(3)) and (not Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(19) <= ( Input(4))and(not Input(3)) and (not Input(2))and( Input(1)) and ( Input(0)) and Enable;
Output(20) <= ( Input(4))and(not Input(3)) and ( Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(21) <= ( Input(4))and(not Input(3)) and ( Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(22) <= ( Input(4))and(not Input(3)) and ( Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(23) <= ( Input(4))and(not Input(3)) and ( Input(2))and( Input(1)) and ( Input(0)) and Enable;

Output(24) <= ( Input(4))and( Input(3)) and (not Input(2))and(not Input(1)) and (not Input(0)) and Enable;
Output(25) <= ( Input(4))and( Input(3)) and (not Input(2))and(not Input(1)) and ( Input(0)) and Enable;
Output(26) <= ( Input(4))and( Input(3)) and (not Input(2))and( Input(1)) and (not Input(0)) and Enable;
Output(27) <= ( Input(4))and( Input(3)) and (not Input(2))and( Input(1)) and ( Input(0)) and Enable;
-- Output(28) <= ( Input(4))and( Input(3)) and ( Input(2))and(not Input(1)) and (not Input(0)) and Enable;
-- Output(29) <= ( Input(4))and( Input(3)) and ( Input(2))and(not Input(1)) and ( Input(0)) and Enable;
-- Output(30) <= ( Input(4))and( Input(3)) and ( Input(2))and( Input(1)) and (not Input(0)) and Enable;
-- Output(31) <= ( Input(4))and( Input(3)) and ( Input(2))and( Input(1)) and ( Input(0)) and Enable;

end behavioural ;
