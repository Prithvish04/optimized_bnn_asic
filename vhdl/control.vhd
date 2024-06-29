----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/22/2021 06:38:24 PM
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
 Port (CLK: in  std_logic;
         rst: in  std_logic;
         pixels_in: in std_logic;
         w_fc: in std_logic_vector(7999 downto 0);
         weights_in: in std_logic_vector(647 downto 0);
         label_out: out std_logic_vector(3 downto 0)
);
end control;

architecture Behavioral of control is

component bnn_conv is
  Port ( CLK: in  std_logic;
         rst: in  std_logic;
         pixels_in: in std_logic;
         weights_in: in std_logic_vector(647 downto 0);
         px_out: out std_logic_vector (7 downto 0);
         done: out std_logic );
end component;

component max_pool is
Port (  CLK: in  std_logic;
        rst: in  std_logic;
        max_pool_in: in std_logic_vector(7 downto 0);
        max_pool_out: out std_logic_vector(79 downto 0); 
        done: out std_logic ); 
end component;



component fully_connected is 
Port ( CLK: in  std_logic;
        rst: in  std_logic;
        w_fc: in std_logic_vector(7999 downto 0);
        max_pool_in: in std_logic_vector(79 downto 0);
        label_out: out std_logic_vector(3 downto 0)); --label binary 0 to 10
        --done: out std_logic );
end component;

signal px_out: std_logic_vector (7 downto 0);
signal done_conv, done_max : std_logic;
signal max_pool_out: std_logic_vector(79 downto 0);

begin



 conv: component bnn_conv port map( 
   CLK => CLK,
   rst => rst,
   pixels_in => pixels_in,
   weights_in => weights_in,
   px_out => px_out,
   done => done_conv
   );
   
max_pool_map: component max_pool
    Port map (  CLK => CLK,
        rst => rst,
         --pixels_in: in std_logic_vector (7 downto 0); --pixels arrive 8 at a time
        max_pool_in => px_out,
        max_pool_out => max_pool_out,
        done => done_max
 ); 

fc_map: component fully_connected
    Port map ( CLK => CLK,
        rst => rst,
        w_fc => w_fc,
        max_pool_in => max_pool_out,
        label_out => label_out
 ); 



end Behavioral;
