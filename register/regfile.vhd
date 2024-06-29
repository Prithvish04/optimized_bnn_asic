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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input_regFile is
      Port (CLK:            in  std_logic;
            rst:            in  std_logic;
            wr_en, rd_en: in std_logic;
            addr_X_wr, addr_Y_wr: in  std_logic_vector(4 downto 0);
            addr_X_rd, addr_Y_rd: in std_logic_vector(4 downto 0);
            --wr_enA, wr_enB: in  std_logic;
            re_enA, re_enB: in  std_logic;
            data_in:     in  std_logic_vector(7 downto 0);
            data_out: out std_logic_vector(7 downto 0)
            -- out_A, out_B:   out std_logic_vector(7 downto 0)
      );
end input_regFile;

architecture Behavioral of input_regFile is

component reg_8bit is
     Port (CLK:    in std_logic;
           rst:    in std_logic;
           enx:     in std_logic;
           eny:     in std_logic;
           input:  in std_logic_vector(7 downto 0);
           output: out std_logic_vector(7 downto 0)
     );
end component;

component Decoder5x32 is port(
    Enable : in std_logic;
    Input : in std_logic_vector(4 downto 0);
    Output : out std_logic_vector(27 downto 0));
end component;

-- component MUX32x2 is port(
--     Input0,  Input1,  Input2,  Input3,  Input4 ,  Input5 , Input6 , Input7  : in std_logic_vector(27 downto 0);
--     Input8,  Input9,  Input10, Input11, Input12 , Input13 ,Input14 ,Input15  : in std_logic_vector(27 downto 0);
--     Input16, Input17, Input18, Input19, Input20 , Input21 ,Input22 ,Input23  : in std_logic_vector(27 downto 0);
--     Input24, Input25, Input26, Input27 : in std_logic_vector(27 downto 0);
--     SelA : in std_logic_vector(27 downto 0);
--     A : out std_logic_vector(27 downto 0);
-- end component;






type m_elem is array (0 to 28, 0 to 28) of std_logic_vector(7 downto 0);
signal image : m_elem;
signal s_img : std_logic_vector(7 downto 0);
signal xsel, ysel : std_logic_vector(27 downto 0);



-- signal elem_A: m_elem;
-- signal elem_B: m_elem;

-- signal tmp_A, tmp_B: unsigned(7 downto 0);

begin
    process (CLK, rst)
	 begin
        if rst = '1' then
            s_img <= (others =>'0');
        end if;
        if rising_edge(CLK) then
            if rd_en = '1' then
                s_img <= image(TO_INTEGER(unsigned(addr_X_rd)), TO_INTEGER(unsigned(addr_Y_rd)));
            end if;
        end if;
	 end process;
    
    data_out <= s_img;


    Xwr   :Decoder5x32 port map(Enable=>wr_en , Input =>addr_x_wr, Output =>xsel);
    Ywr   :Decoder5x32 port map(Enable=>wr_en , Input =>addr_y_wr, Output =>ysel);

    -- Xrd   :Decoder5x32 port map(Enable=>en , Input =>addr_y_wr, Output =>ysel);
    -- Yrd   :Decoder5x32 port map(Enable=>en , Input =>addr_y_wr, Output =>ysel);
    R0_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(0), Input => data_in, Output => image(0,0));
    R0_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(1), Input => data_in, Output => image(0,1));
    R0_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(2), Input => data_in, Output => image(0,2));
    R0_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(3), Input => data_in, Output => image(0,3));
    R0_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(4), Input => data_in, Output => image(0,4));
    R0_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(5), Input => data_in, Output => image(0,5));
    R0_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(6), Input => data_in, Output => image(0,6));
    R0_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(7), Input => data_in, Output => image(0,7));
    R0_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(8), Input => data_in, Output => image(0,8));
    R0_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(9), Input => data_in, Output => image(0,9));
    R0_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(10), Input => data_in, Output => image(0,10));
    R0_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(11), Input => data_in, Output => image(0,11));
    R0_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(12), Input => data_in, Output => image(0,12));
    R0_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(13), Input => data_in, Output => image(0,13));
    R0_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(14), Input => data_in, Output => image(0,14));
    R0_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(15), Input => data_in, Output => image(0,15));
    R0_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(16), Input => data_in, Output => image(0,16));
    R0_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(17), Input => data_in, Output => image(0,17));
    R0_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(18), Input => data_in, Output => image(0,18));
    R0_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(19), Input => data_in, Output => image(0,19));
    R0_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(20), Input => data_in, Output => image(0,20));
    R0_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(21), Input => data_in, Output => image(0,21));
    R0_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(22), Input => data_in, Output => image(0,22));
    R0_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(23), Input => data_in, Output => image(0,23));
    R0_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(24), Input => data_in, Output => image(0,24));
    R0_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(25), Input => data_in, Output => image(0,25));
    R0_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(26), Input => data_in, Output => image(0,26));
    R0_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(0), eny => ysel(27), Input => data_in, Output => image(0,27));
    
    
    R1_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(0), Input => data_in, Output => image(1,0));
    R1_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(1), Input => data_in, Output => image(1,1));
    R1_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(2), Input => data_in, Output => image(1,2));
    R1_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(3), Input => data_in, Output => image(1,3));
    R1_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(4), Input => data_in, Output => image(1,4));
    R1_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(5), Input => data_in, Output => image(1,5));
    R1_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(6), Input => data_in, Output => image(1,6));
    R1_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(7), Input => data_in, Output => image(1,7));
    R1_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(8), Input => data_in, Output => image(1,8));
    R1_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(9), Input => data_in, Output => image(1,9));
    R1_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(10), Input => data_in, Output => image(1,10));
    R1_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(11), Input => data_in, Output => image(1,11));
    R1_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(12), Input => data_in, Output => image(1,12));
    R1_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(13), Input => data_in, Output => image(1,13));
    R1_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(14), Input => data_in, Output => image(1,14));
    R1_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(15), Input => data_in, Output => image(1,15));
    R1_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(16), Input => data_in, Output => image(1,16));
    R1_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(17), Input => data_in, Output => image(1,17));
    R1_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(18), Input => data_in, Output => image(1,18));
    R1_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(19), Input => data_in, Output => image(1,19));
    R1_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(20), Input => data_in, Output => image(1,20));
    R1_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(21), Input => data_in, Output => image(1,21));
    R1_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(22), Input => data_in, Output => image(1,22));
    R1_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(23), Input => data_in, Output => image(1,23));
    R1_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(24), Input => data_in, Output => image(1,24));
    R1_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(25), Input => data_in, Output => image(1,25));
    R1_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(26), Input => data_in, Output => image(1,26));
    R1_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(1), eny => ysel(27), Input => data_in, Output => image(1,27));
    
    
    R2_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(0), Input => data_in, Output => image(2,0));
    R2_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(1), Input => data_in, Output => image(2,1));
    R2_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(2), Input => data_in, Output => image(2,2));
    R2_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(3), Input => data_in, Output => image(2,3));
    R2_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(4), Input => data_in, Output => image(2,4));
    R2_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(5), Input => data_in, Output => image(2,5));
    R2_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(6), Input => data_in, Output => image(2,6));
    R2_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(7), Input => data_in, Output => image(2,7));
    R2_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(8), Input => data_in, Output => image(2,8));
    R2_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(9), Input => data_in, Output => image(2,9));
    R2_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(10), Input => data_in, Output => image(2,10));
    R2_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(11), Input => data_in, Output => image(2,11));
    R2_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(12), Input => data_in, Output => image(2,12));
    R2_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(13), Input => data_in, Output => image(2,13));
    R2_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(14), Input => data_in, Output => image(2,14));
    R2_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(15), Input => data_in, Output => image(2,15));
    R2_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(16), Input => data_in, Output => image(2,16));
    R2_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(17), Input => data_in, Output => image(2,17));
    R2_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(18), Input => data_in, Output => image(2,18));
    R2_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(19), Input => data_in, Output => image(2,19));
    R2_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(20), Input => data_in, Output => image(2,20));
    R2_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(21), Input => data_in, Output => image(2,21));
    R2_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(22), Input => data_in, Output => image(2,22));
    R2_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(23), Input => data_in, Output => image(2,23));
    R2_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(24), Input => data_in, Output => image(2,24));
    R2_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(25), Input => data_in, Output => image(2,25));
    R2_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(26), Input => data_in, Output => image(2,26));
    R2_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(2), eny => ysel(27), Input => data_in, Output => image(2,27));
    
    
    R3_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(0), Input => data_in, Output => image(3,0));
    R3_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(1), Input => data_in, Output => image(3,1));
    R3_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(2), Input => data_in, Output => image(3,2));
    R3_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(3), Input => data_in, Output => image(3,3));
    R3_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(4), Input => data_in, Output => image(3,4));
    R3_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(5), Input => data_in, Output => image(3,5));
    R3_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(6), Input => data_in, Output => image(3,6));
    R3_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(7), Input => data_in, Output => image(3,7));
    R3_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(8), Input => data_in, Output => image(3,8));
    R3_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(9), Input => data_in, Output => image(3,9));
    R3_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(10), Input => data_in, Output => image(3,10));
    R3_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(11), Input => data_in, Output => image(3,11));
    R3_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(12), Input => data_in, Output => image(3,12));
    R3_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(13), Input => data_in, Output => image(3,13));
    R3_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(14), Input => data_in, Output => image(3,14));
    R3_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(15), Input => data_in, Output => image(3,15));
    R3_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(16), Input => data_in, Output => image(3,16));
    R3_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(17), Input => data_in, Output => image(3,17));
    R3_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(18), Input => data_in, Output => image(3,18));
    R3_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(19), Input => data_in, Output => image(3,19));
    R3_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(20), Input => data_in, Output => image(3,20));
    R3_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(21), Input => data_in, Output => image(3,21));
    R3_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(22), Input => data_in, Output => image(3,22));
    R3_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(23), Input => data_in, Output => image(3,23));
    R3_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(24), Input => data_in, Output => image(3,24));
    R3_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(25), Input => data_in, Output => image(3,25));
    R3_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(26), Input => data_in, Output => image(3,26));
    R3_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(3), eny => ysel(27), Input => data_in, Output => image(3,27));
    
    
    R4_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(0), Input => data_in, Output => image(4,0));
    R4_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(1), Input => data_in, Output => image(4,1));
    R4_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(2), Input => data_in, Output => image(4,2));
    R4_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(3), Input => data_in, Output => image(4,3));
    R4_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(4), Input => data_in, Output => image(4,4));
    R4_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(5), Input => data_in, Output => image(4,5));
    R4_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(6), Input => data_in, Output => image(4,6));
    R4_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(7), Input => data_in, Output => image(4,7));
    R4_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(8), Input => data_in, Output => image(4,8));
    R4_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(9), Input => data_in, Output => image(4,9));
    R4_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(10), Input => data_in, Output => image(4,10));
    R4_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(11), Input => data_in, Output => image(4,11));
    R4_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(12), Input => data_in, Output => image(4,12));
    R4_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(13), Input => data_in, Output => image(4,13));
    R4_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(14), Input => data_in, Output => image(4,14));
    R4_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(15), Input => data_in, Output => image(4,15));
    R4_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(16), Input => data_in, Output => image(4,16));
    R4_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(17), Input => data_in, Output => image(4,17));
    R4_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(18), Input => data_in, Output => image(4,18));
    R4_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(19), Input => data_in, Output => image(4,19));
    R4_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(20), Input => data_in, Output => image(4,20));
    R4_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(21), Input => data_in, Output => image(4,21));
    R4_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(22), Input => data_in, Output => image(4,22));
    R4_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(23), Input => data_in, Output => image(4,23));
    R4_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(24), Input => data_in, Output => image(4,24));
    R4_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(25), Input => data_in, Output => image(4,25));
    R4_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(26), Input => data_in, Output => image(4,26));
    R4_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(4), eny => ysel(27), Input => data_in, Output => image(4,27));
    
    
    R5_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(0), Input => data_in, Output => image(5,0));
    R5_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(1), Input => data_in, Output => image(5,1));
    R5_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(2), Input => data_in, Output => image(5,2));
    R5_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(3), Input => data_in, Output => image(5,3));
    R5_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(4), Input => data_in, Output => image(5,4));
    R5_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(5), Input => data_in, Output => image(5,5));
    R5_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(6), Input => data_in, Output => image(5,6));
    R5_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(7), Input => data_in, Output => image(5,7));
    R5_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(8), Input => data_in, Output => image(5,8));
    R5_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(9), Input => data_in, Output => image(5,9));
    R5_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(10), Input => data_in, Output => image(5,10));
    R5_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(11), Input => data_in, Output => image(5,11));
    R5_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(12), Input => data_in, Output => image(5,12));
    R5_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(13), Input => data_in, Output => image(5,13));
    R5_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(14), Input => data_in, Output => image(5,14));
    R5_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(15), Input => data_in, Output => image(5,15));
    R5_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(16), Input => data_in, Output => image(5,16));
    R5_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(17), Input => data_in, Output => image(5,17));
    R5_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(18), Input => data_in, Output => image(5,18));
    R5_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(19), Input => data_in, Output => image(5,19));
    R5_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(20), Input => data_in, Output => image(5,20));
    R5_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(21), Input => data_in, Output => image(5,21));
    R5_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(22), Input => data_in, Output => image(5,22));
    R5_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(23), Input => data_in, Output => image(5,23));
    R5_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(24), Input => data_in, Output => image(5,24));
    R5_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(25), Input => data_in, Output => image(5,25));
    R5_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(26), Input => data_in, Output => image(5,26));
    R5_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(5), eny => ysel(27), Input => data_in, Output => image(5,27));
    
    
    R6_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(0), Input => data_in, Output => image(6,0));
    R6_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(1), Input => data_in, Output => image(6,1));
    R6_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(2), Input => data_in, Output => image(6,2));
    R6_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(3), Input => data_in, Output => image(6,3));
    R6_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(4), Input => data_in, Output => image(6,4));
    R6_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(5), Input => data_in, Output => image(6,5));
    R6_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(6), Input => data_in, Output => image(6,6));
    R6_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(7), Input => data_in, Output => image(6,7));
    R6_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(8), Input => data_in, Output => image(6,8));
    R6_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(9), Input => data_in, Output => image(6,9));
    R6_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(10), Input => data_in, Output => image(6,10));
    R6_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(11), Input => data_in, Output => image(6,11));
    R6_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(12), Input => data_in, Output => image(6,12));
    R6_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(13), Input => data_in, Output => image(6,13));
    R6_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(14), Input => data_in, Output => image(6,14));
    R6_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(15), Input => data_in, Output => image(6,15));
    R6_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(16), Input => data_in, Output => image(6,16));
    R6_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(17), Input => data_in, Output => image(6,17));
    R6_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(18), Input => data_in, Output => image(6,18));
    R6_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(19), Input => data_in, Output => image(6,19));
    R6_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(20), Input => data_in, Output => image(6,20));
    R6_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(21), Input => data_in, Output => image(6,21));
    R6_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(22), Input => data_in, Output => image(6,22));
    R6_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(23), Input => data_in, Output => image(6,23));
    R6_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(24), Input => data_in, Output => image(6,24));
    R6_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(25), Input => data_in, Output => image(6,25));
    R6_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(26), Input => data_in, Output => image(6,26));
    R6_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(6), eny => ysel(27), Input => data_in, Output => image(6,27));
    
    
    R7_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(0), Input => data_in, Output => image(7,0));
    R7_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(1), Input => data_in, Output => image(7,1));
    R7_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(2), Input => data_in, Output => image(7,2));
    R7_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(3), Input => data_in, Output => image(7,3));
    R7_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(4), Input => data_in, Output => image(7,4));
    R7_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(5), Input => data_in, Output => image(7,5));
    R7_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(6), Input => data_in, Output => image(7,6));
    R7_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(7), Input => data_in, Output => image(7,7));
    R7_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(8), Input => data_in, Output => image(7,8));
    R7_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(9), Input => data_in, Output => image(7,9));
    R7_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(10), Input => data_in, Output => image(7,10));
    R7_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(11), Input => data_in, Output => image(7,11));
    R7_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(12), Input => data_in, Output => image(7,12));
    R7_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(13), Input => data_in, Output => image(7,13));
    R7_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(14), Input => data_in, Output => image(7,14));
    R7_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(15), Input => data_in, Output => image(7,15));
    R7_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(16), Input => data_in, Output => image(7,16));
    R7_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(17), Input => data_in, Output => image(7,17));
    R7_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(18), Input => data_in, Output => image(7,18));
    R7_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(19), Input => data_in, Output => image(7,19));
    R7_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(20), Input => data_in, Output => image(7,20));
    R7_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(21), Input => data_in, Output => image(7,21));
    R7_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(22), Input => data_in, Output => image(7,22));
    R7_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(23), Input => data_in, Output => image(7,23));
    R7_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(24), Input => data_in, Output => image(7,24));
    R7_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(25), Input => data_in, Output => image(7,25));
    R7_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(26), Input => data_in, Output => image(7,26));
    R7_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(7), eny => ysel(27), Input => data_in, Output => image(7,27));
    
    
    R8_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(0), Input => data_in, Output => image(8,0));
    R8_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(1), Input => data_in, Output => image(8,1));
    R8_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(2), Input => data_in, Output => image(8,2));
    R8_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(3), Input => data_in, Output => image(8,3));
    R8_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(4), Input => data_in, Output => image(8,4));
    R8_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(5), Input => data_in, Output => image(8,5));
    R8_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(6), Input => data_in, Output => image(8,6));
    R8_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(7), Input => data_in, Output => image(8,7));
    R8_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(8), Input => data_in, Output => image(8,8));
    R8_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(9), Input => data_in, Output => image(8,9));
    R8_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(10), Input => data_in, Output => image(8,10));
    R8_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(11), Input => data_in, Output => image(8,11));
    R8_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(12), Input => data_in, Output => image(8,12));
    R8_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(13), Input => data_in, Output => image(8,13));
    R8_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(14), Input => data_in, Output => image(8,14));
    R8_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(15), Input => data_in, Output => image(8,15));
    R8_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(16), Input => data_in, Output => image(8,16));
    R8_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(17), Input => data_in, Output => image(8,17));
    R8_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(18), Input => data_in, Output => image(8,18));
    R8_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(19), Input => data_in, Output => image(8,19));
    R8_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(20), Input => data_in, Output => image(8,20));
    R8_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(21), Input => data_in, Output => image(8,21));
    R8_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(22), Input => data_in, Output => image(8,22));
    R8_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(23), Input => data_in, Output => image(8,23));
    R8_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(24), Input => data_in, Output => image(8,24));
    R8_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(25), Input => data_in, Output => image(8,25));
    R8_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(26), Input => data_in, Output => image(8,26));
    R8_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(8), eny => ysel(27), Input => data_in, Output => image(8,27));
    
    
    R9_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(0), Input => data_in, Output => image(9,0));
    R9_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(1), Input => data_in, Output => image(9,1));
    R9_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(2), Input => data_in, Output => image(9,2));
    R9_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(3), Input => data_in, Output => image(9,3));
    R9_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(4), Input => data_in, Output => image(9,4));
    R9_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(5), Input => data_in, Output => image(9,5));
    R9_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(6), Input => data_in, Output => image(9,6));
    R9_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(7), Input => data_in, Output => image(9,7));
    R9_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(8), Input => data_in, Output => image(9,8));
    R9_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(9), Input => data_in, Output => image(9,9));
    R9_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(10), Input => data_in, Output => image(9,10));
    R9_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(11), Input => data_in, Output => image(9,11));
    R9_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(12), Input => data_in, Output => image(9,12));
    R9_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(13), Input => data_in, Output => image(9,13));
    R9_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(14), Input => data_in, Output => image(9,14));
    R9_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(15), Input => data_in, Output => image(9,15));
    R9_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(16), Input => data_in, Output => image(9,16));
    R9_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(17), Input => data_in, Output => image(9,17));
    R9_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(18), Input => data_in, Output => image(9,18));
    R9_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(19), Input => data_in, Output => image(9,19));
    R9_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(20), Input => data_in, Output => image(9,20));
    R9_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(21), Input => data_in, Output => image(9,21));
    R9_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(22), Input => data_in, Output => image(9,22));
    R9_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(23), Input => data_in, Output => image(9,23));
    R9_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(24), Input => data_in, Output => image(9,24));
    R9_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(25), Input => data_in, Output => image(9,25));
    R9_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(26), Input => data_in, Output => image(9,26));
    R9_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(9), eny => ysel(27), Input => data_in, Output => image(9,27));
    
    
    R10_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(0), Input => data_in, Output => image(10,0));
    R10_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(1), Input => data_in, Output => image(10,1));
    R10_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(2), Input => data_in, Output => image(10,2));
    R10_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(3), Input => data_in, Output => image(10,3));
    R10_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(4), Input => data_in, Output => image(10,4));
    R10_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(5), Input => data_in, Output => image(10,5));
    R10_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(6), Input => data_in, Output => image(10,6));
    R10_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(7), Input => data_in, Output => image(10,7));
    R10_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(8), Input => data_in, Output => image(10,8));
    R10_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(9), Input => data_in, Output => image(10,9));
    R10_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(10), Input => data_in, Output => image(10,10));
    R10_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(11), Input => data_in, Output => image(10,11));
    R10_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(12), Input => data_in, Output => image(10,12));
    R10_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(13), Input => data_in, Output => image(10,13));
    R10_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(14), Input => data_in, Output => image(10,14));
    R10_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(15), Input => data_in, Output => image(10,15));
    R10_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(16), Input => data_in, Output => image(10,16));
    R10_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(17), Input => data_in, Output => image(10,17));
    R10_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(18), Input => data_in, Output => image(10,18));
    R10_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(19), Input => data_in, Output => image(10,19));
    R10_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(20), Input => data_in, Output => image(10,20));
    R10_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(21), Input => data_in, Output => image(10,21));
    R10_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(22), Input => data_in, Output => image(10,22));
    R10_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(23), Input => data_in, Output => image(10,23));
    R10_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(24), Input => data_in, Output => image(10,24));
    R10_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(25), Input => data_in, Output => image(10,25));
    R10_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(26), Input => data_in, Output => image(10,26));
    R10_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(10), eny => ysel(27), Input => data_in, Output => image(10,27));
    
    
    R11_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(0), Input => data_in, Output => image(11,0));
    R11_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(1), Input => data_in, Output => image(11,1));
    R11_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(2), Input => data_in, Output => image(11,2));
    R11_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(3), Input => data_in, Output => image(11,3));
    R11_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(4), Input => data_in, Output => image(11,4));
    R11_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(5), Input => data_in, Output => image(11,5));
    R11_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(6), Input => data_in, Output => image(11,6));
    R11_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(7), Input => data_in, Output => image(11,7));
    R11_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(8), Input => data_in, Output => image(11,8));
    R11_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(9), Input => data_in, Output => image(11,9));
    R11_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(10), Input => data_in, Output => image(11,10));
    R11_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(11), Input => data_in, Output => image(11,11));
    R11_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(12), Input => data_in, Output => image(11,12));
    R11_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(13), Input => data_in, Output => image(11,13));
    R11_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(14), Input => data_in, Output => image(11,14));
    R11_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(15), Input => data_in, Output => image(11,15));
    R11_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(16), Input => data_in, Output => image(11,16));
    R11_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(17), Input => data_in, Output => image(11,17));
    R11_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(18), Input => data_in, Output => image(11,18));
    R11_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(19), Input => data_in, Output => image(11,19));
    R11_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(20), Input => data_in, Output => image(11,20));
    R11_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(21), Input => data_in, Output => image(11,21));
    R11_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(22), Input => data_in, Output => image(11,22));
    R11_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(23), Input => data_in, Output => image(11,23));
    R11_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(24), Input => data_in, Output => image(11,24));
    R11_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(25), Input => data_in, Output => image(11,25));
    R11_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(26), Input => data_in, Output => image(11,26));
    R11_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(11), eny => ysel(27), Input => data_in, Output => image(11,27));
    
    
    R12_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(0), Input => data_in, Output => image(12,0));
    R12_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(1), Input => data_in, Output => image(12,1));
    R12_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(2), Input => data_in, Output => image(12,2));
    R12_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(3), Input => data_in, Output => image(12,3));
    R12_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(4), Input => data_in, Output => image(12,4));
    R12_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(5), Input => data_in, Output => image(12,5));
    R12_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(6), Input => data_in, Output => image(12,6));
    R12_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(7), Input => data_in, Output => image(12,7));
    R12_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(8), Input => data_in, Output => image(12,8));
    R12_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(9), Input => data_in, Output => image(12,9));
    R12_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(10), Input => data_in, Output => image(12,10));
    R12_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(11), Input => data_in, Output => image(12,11));
    R12_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(12), Input => data_in, Output => image(12,12));
    R12_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(13), Input => data_in, Output => image(12,13));
    R12_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(14), Input => data_in, Output => image(12,14));
    R12_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(15), Input => data_in, Output => image(12,15));
    R12_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(16), Input => data_in, Output => image(12,16));
    R12_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(17), Input => data_in, Output => image(12,17));
    R12_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(18), Input => data_in, Output => image(12,18));
    R12_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(19), Input => data_in, Output => image(12,19));
    R12_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(20), Input => data_in, Output => image(12,20));
    R12_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(21), Input => data_in, Output => image(12,21));
    R12_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(22), Input => data_in, Output => image(12,22));
    R12_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(23), Input => data_in, Output => image(12,23));
    R12_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(24), Input => data_in, Output => image(12,24));
    R12_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(25), Input => data_in, Output => image(12,25));
    R12_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(26), Input => data_in, Output => image(12,26));
    R12_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(12), eny => ysel(27), Input => data_in, Output => image(12,27));
    
    
    R13_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(0), Input => data_in, Output => image(13,0));
    R13_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(1), Input => data_in, Output => image(13,1));
    R13_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(2), Input => data_in, Output => image(13,2));
    R13_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(3), Input => data_in, Output => image(13,3));
    R13_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(4), Input => data_in, Output => image(13,4));
    R13_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(5), Input => data_in, Output => image(13,5));
    R13_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(6), Input => data_in, Output => image(13,6));
    R13_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(7), Input => data_in, Output => image(13,7));
    R13_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(8), Input => data_in, Output => image(13,8));
    R13_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(9), Input => data_in, Output => image(13,9));
    R13_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(10), Input => data_in, Output => image(13,10));
    R13_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(11), Input => data_in, Output => image(13,11));
    R13_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(12), Input => data_in, Output => image(13,12));
    R13_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(13), Input => data_in, Output => image(13,13));
    R13_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(14), Input => data_in, Output => image(13,14));
    R13_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(15), Input => data_in, Output => image(13,15));
    R13_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(16), Input => data_in, Output => image(13,16));
    R13_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(17), Input => data_in, Output => image(13,17));
    R13_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(18), Input => data_in, Output => image(13,18));
    R13_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(19), Input => data_in, Output => image(13,19));
    R13_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(20), Input => data_in, Output => image(13,20));
    R13_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(21), Input => data_in, Output => image(13,21));
    R13_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(22), Input => data_in, Output => image(13,22));
    R13_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(23), Input => data_in, Output => image(13,23));
    R13_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(24), Input => data_in, Output => image(13,24));
    R13_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(25), Input => data_in, Output => image(13,25));
    R13_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(26), Input => data_in, Output => image(13,26));
    R13_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(13), eny => ysel(27), Input => data_in, Output => image(13,27));
    
    
    R14_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(0), Input => data_in, Output => image(14,0));
    R14_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(1), Input => data_in, Output => image(14,1));
    R14_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(2), Input => data_in, Output => image(14,2));
    R14_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(3), Input => data_in, Output => image(14,3));
    R14_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(4), Input => data_in, Output => image(14,4));
    R14_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(5), Input => data_in, Output => image(14,5));
    R14_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(6), Input => data_in, Output => image(14,6));
    R14_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(7), Input => data_in, Output => image(14,7));
    R14_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(8), Input => data_in, Output => image(14,8));
    R14_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(9), Input => data_in, Output => image(14,9));
    R14_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(10), Input => data_in, Output => image(14,10));
    R14_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(11), Input => data_in, Output => image(14,11));
    R14_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(12), Input => data_in, Output => image(14,12));
    R14_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(13), Input => data_in, Output => image(14,13));
    R14_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(14), Input => data_in, Output => image(14,14));
    R14_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(15), Input => data_in, Output => image(14,15));
    R14_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(16), Input => data_in, Output => image(14,16));
    R14_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(17), Input => data_in, Output => image(14,17));
    R14_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(18), Input => data_in, Output => image(14,18));
    R14_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(19), Input => data_in, Output => image(14,19));
    R14_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(20), Input => data_in, Output => image(14,20));
    R14_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(21), Input => data_in, Output => image(14,21));
    R14_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(22), Input => data_in, Output => image(14,22));
    R14_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(23), Input => data_in, Output => image(14,23));
    R14_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(24), Input => data_in, Output => image(14,24));
    R14_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(25), Input => data_in, Output => image(14,25));
    R14_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(26), Input => data_in, Output => image(14,26));
    R14_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(14), eny => ysel(27), Input => data_in, Output => image(14,27));
    
    
    R15_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(0), Input => data_in, Output => image(15,0));
    R15_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(1), Input => data_in, Output => image(15,1));
    R15_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(2), Input => data_in, Output => image(15,2));
    R15_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(3), Input => data_in, Output => image(15,3));
    R15_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(4), Input => data_in, Output => image(15,4));
    R15_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(5), Input => data_in, Output => image(15,5));
    R15_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(6), Input => data_in, Output => image(15,6));
    R15_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(7), Input => data_in, Output => image(15,7));
    R15_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(8), Input => data_in, Output => image(15,8));
    R15_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(9), Input => data_in, Output => image(15,9));
    R15_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(10), Input => data_in, Output => image(15,10));
    R15_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(11), Input => data_in, Output => image(15,11));
    R15_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(12), Input => data_in, Output => image(15,12));
    R15_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(13), Input => data_in, Output => image(15,13));
    R15_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(14), Input => data_in, Output => image(15,14));
    R15_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(15), Input => data_in, Output => image(15,15));
    R15_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(16), Input => data_in, Output => image(15,16));
    R15_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(17), Input => data_in, Output => image(15,17));
    R15_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(18), Input => data_in, Output => image(15,18));
    R15_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(19), Input => data_in, Output => image(15,19));
    R15_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(20), Input => data_in, Output => image(15,20));
    R15_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(21), Input => data_in, Output => image(15,21));
    R15_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(22), Input => data_in, Output => image(15,22));
    R15_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(23), Input => data_in, Output => image(15,23));
    R15_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(24), Input => data_in, Output => image(15,24));
    R15_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(25), Input => data_in, Output => image(15,25));
    R15_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(26), Input => data_in, Output => image(15,26));
    R15_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(15), eny => ysel(27), Input => data_in, Output => image(15,27));
    
    
    R16_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(0), Input => data_in, Output => image(16,0));
    R16_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(1), Input => data_in, Output => image(16,1));
    R16_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(2), Input => data_in, Output => image(16,2));
    R16_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(3), Input => data_in, Output => image(16,3));
    R16_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(4), Input => data_in, Output => image(16,4));
    R16_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(5), Input => data_in, Output => image(16,5));
    R16_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(6), Input => data_in, Output => image(16,6));
    R16_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(7), Input => data_in, Output => image(16,7));
    R16_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(8), Input => data_in, Output => image(16,8));
    R16_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(9), Input => data_in, Output => image(16,9));
    R16_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(10), Input => data_in, Output => image(16,10));
    R16_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(11), Input => data_in, Output => image(16,11));
    R16_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(12), Input => data_in, Output => image(16,12));
    R16_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(13), Input => data_in, Output => image(16,13));
    R16_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(14), Input => data_in, Output => image(16,14));
    R16_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(15), Input => data_in, Output => image(16,15));
    R16_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(16), Input => data_in, Output => image(16,16));
    R16_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(17), Input => data_in, Output => image(16,17));
    R16_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(18), Input => data_in, Output => image(16,18));
    R16_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(19), Input => data_in, Output => image(16,19));
    R16_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(20), Input => data_in, Output => image(16,20));
    R16_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(21), Input => data_in, Output => image(16,21));
    R16_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(22), Input => data_in, Output => image(16,22));
    R16_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(23), Input => data_in, Output => image(16,23));
    R16_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(24), Input => data_in, Output => image(16,24));
    R16_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(25), Input => data_in, Output => image(16,25));
    R16_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(26), Input => data_in, Output => image(16,26));
    R16_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(16), eny => ysel(27), Input => data_in, Output => image(16,27));
    
    
    R17_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(0), Input => data_in, Output => image(17,0));
    R17_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(1), Input => data_in, Output => image(17,1));
    R17_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(2), Input => data_in, Output => image(17,2));
    R17_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(3), Input => data_in, Output => image(17,3));
    R17_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(4), Input => data_in, Output => image(17,4));
    R17_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(5), Input => data_in, Output => image(17,5));
    R17_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(6), Input => data_in, Output => image(17,6));
    R17_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(7), Input => data_in, Output => image(17,7));
    R17_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(8), Input => data_in, Output => image(17,8));
    R17_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(9), Input => data_in, Output => image(17,9));
    R17_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(10), Input => data_in, Output => image(17,10));
    R17_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(11), Input => data_in, Output => image(17,11));
    R17_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(12), Input => data_in, Output => image(17,12));
    R17_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(13), Input => data_in, Output => image(17,13));
    R17_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(14), Input => data_in, Output => image(17,14));
    R17_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(15), Input => data_in, Output => image(17,15));
    R17_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(16), Input => data_in, Output => image(17,16));
    R17_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(17), Input => data_in, Output => image(17,17));
    R17_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(18), Input => data_in, Output => image(17,18));
    R17_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(19), Input => data_in, Output => image(17,19));
    R17_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(20), Input => data_in, Output => image(17,20));
    R17_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(21), Input => data_in, Output => image(17,21));
    R17_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(22), Input => data_in, Output => image(17,22));
    R17_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(23), Input => data_in, Output => image(17,23));
    R17_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(24), Input => data_in, Output => image(17,24));
    R17_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(25), Input => data_in, Output => image(17,25));
    R17_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(26), Input => data_in, Output => image(17,26));
    R17_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(17), eny => ysel(27), Input => data_in, Output => image(17,27));
    
    
    R18_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(0), Input => data_in, Output => image(18,0));
    R18_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(1), Input => data_in, Output => image(18,1));
    R18_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(2), Input => data_in, Output => image(18,2));
    R18_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(3), Input => data_in, Output => image(18,3));
    R18_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(4), Input => data_in, Output => image(18,4));
    R18_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(5), Input => data_in, Output => image(18,5));
    R18_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(6), Input => data_in, Output => image(18,6));
    R18_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(7), Input => data_in, Output => image(18,7));
    R18_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(8), Input => data_in, Output => image(18,8));
    R18_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(9), Input => data_in, Output => image(18,9));
    R18_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(10), Input => data_in, Output => image(18,10));
    R18_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(11), Input => data_in, Output => image(18,11));
    R18_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(12), Input => data_in, Output => image(18,12));
    R18_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(13), Input => data_in, Output => image(18,13));
    R18_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(14), Input => data_in, Output => image(18,14));
    R18_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(15), Input => data_in, Output => image(18,15));
    R18_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(16), Input => data_in, Output => image(18,16));
    R18_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(17), Input => data_in, Output => image(18,17));
    R18_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(18), Input => data_in, Output => image(18,18));
    R18_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(19), Input => data_in, Output => image(18,19));
    R18_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(20), Input => data_in, Output => image(18,20));
    R18_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(21), Input => data_in, Output => image(18,21));
    R18_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(22), Input => data_in, Output => image(18,22));
    R18_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(23), Input => data_in, Output => image(18,23));
    R18_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(24), Input => data_in, Output => image(18,24));
    R18_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(25), Input => data_in, Output => image(18,25));
    R18_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(26), Input => data_in, Output => image(18,26));
    R18_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(18), eny => ysel(27), Input => data_in, Output => image(18,27));
    
    
    R19_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(0), Input => data_in, Output => image(19,0));
    R19_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(1), Input => data_in, Output => image(19,1));
    R19_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(2), Input => data_in, Output => image(19,2));
    R19_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(3), Input => data_in, Output => image(19,3));
    R19_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(4), Input => data_in, Output => image(19,4));
    R19_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(5), Input => data_in, Output => image(19,5));
    R19_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(6), Input => data_in, Output => image(19,6));
    R19_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(7), Input => data_in, Output => image(19,7));
    R19_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(8), Input => data_in, Output => image(19,8));
    R19_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(9), Input => data_in, Output => image(19,9));
    R19_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(10), Input => data_in, Output => image(19,10));
    R19_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(11), Input => data_in, Output => image(19,11));
    R19_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(12), Input => data_in, Output => image(19,12));
    R19_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(13), Input => data_in, Output => image(19,13));
    R19_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(14), Input => data_in, Output => image(19,14));
    R19_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(15), Input => data_in, Output => image(19,15));
    R19_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(16), Input => data_in, Output => image(19,16));
    R19_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(17), Input => data_in, Output => image(19,17));
    R19_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(18), Input => data_in, Output => image(19,18));
    R19_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(19), Input => data_in, Output => image(19,19));
    R19_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(20), Input => data_in, Output => image(19,20));
    R19_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(21), Input => data_in, Output => image(19,21));
    R19_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(22), Input => data_in, Output => image(19,22));
    R19_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(23), Input => data_in, Output => image(19,23));
    R19_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(24), Input => data_in, Output => image(19,24));
    R19_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(25), Input => data_in, Output => image(19,25));
    R19_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(26), Input => data_in, Output => image(19,26));
    R19_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(19), eny => ysel(27), Input => data_in, Output => image(19,27));
    
    
    R20_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(0), Input => data_in, Output => image(20,0));
    R20_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(1), Input => data_in, Output => image(20,1));
    R20_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(2), Input => data_in, Output => image(20,2));
    R20_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(3), Input => data_in, Output => image(20,3));
    R20_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(4), Input => data_in, Output => image(20,4));
    R20_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(5), Input => data_in, Output => image(20,5));
    R20_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(6), Input => data_in, Output => image(20,6));
    R20_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(7), Input => data_in, Output => image(20,7));
    R20_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(8), Input => data_in, Output => image(20,8));
    R20_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(9), Input => data_in, Output => image(20,9));
    R20_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(10), Input => data_in, Output => image(20,10));
    R20_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(11), Input => data_in, Output => image(20,11));
    R20_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(12), Input => data_in, Output => image(20,12));
    R20_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(13), Input => data_in, Output => image(20,13));
    R20_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(14), Input => data_in, Output => image(20,14));
    R20_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(15), Input => data_in, Output => image(20,15));
    R20_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(16), Input => data_in, Output => image(20,16));
    R20_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(17), Input => data_in, Output => image(20,17));
    R20_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(18), Input => data_in, Output => image(20,18));
    R20_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(19), Input => data_in, Output => image(20,19));
    R20_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(20), Input => data_in, Output => image(20,20));
    R20_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(21), Input => data_in, Output => image(20,21));
    R20_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(22), Input => data_in, Output => image(20,22));
    R20_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(23), Input => data_in, Output => image(20,23));
    R20_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(24), Input => data_in, Output => image(20,24));
    R20_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(25), Input => data_in, Output => image(20,25));
    R20_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(26), Input => data_in, Output => image(20,26));
    R20_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(20), eny => ysel(27), Input => data_in, Output => image(20,27));
    
    
    R21_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(0), Input => data_in, Output => image(21,0));
    R21_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(1), Input => data_in, Output => image(21,1));
    R21_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(2), Input => data_in, Output => image(21,2));
    R21_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(3), Input => data_in, Output => image(21,3));
    R21_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(4), Input => data_in, Output => image(21,4));
    R21_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(5), Input => data_in, Output => image(21,5));
    R21_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(6), Input => data_in, Output => image(21,6));
    R21_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(7), Input => data_in, Output => image(21,7));
    R21_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(8), Input => data_in, Output => image(21,8));
    R21_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(9), Input => data_in, Output => image(21,9));
    R21_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(10), Input => data_in, Output => image(21,10));
    R21_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(11), Input => data_in, Output => image(21,11));
    R21_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(12), Input => data_in, Output => image(21,12));
    R21_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(13), Input => data_in, Output => image(21,13));
    R21_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(14), Input => data_in, Output => image(21,14));
    R21_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(15), Input => data_in, Output => image(21,15));
    R21_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(16), Input => data_in, Output => image(21,16));
    R21_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(17), Input => data_in, Output => image(21,17));
    R21_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(18), Input => data_in, Output => image(21,18));
    R21_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(19), Input => data_in, Output => image(21,19));
    R21_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(20), Input => data_in, Output => image(21,20));
    R21_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(21), Input => data_in, Output => image(21,21));
    R21_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(22), Input => data_in, Output => image(21,22));
    R21_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(23), Input => data_in, Output => image(21,23));
    R21_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(24), Input => data_in, Output => image(21,24));
    R21_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(25), Input => data_in, Output => image(21,25));
    R21_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(26), Input => data_in, Output => image(21,26));
    R21_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(21), eny => ysel(27), Input => data_in, Output => image(21,27));
    
    
    R22_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(0), Input => data_in, Output => image(22,0));
    R22_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(1), Input => data_in, Output => image(22,1));
    R22_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(2), Input => data_in, Output => image(22,2));
    R22_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(3), Input => data_in, Output => image(22,3));
    R22_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(4), Input => data_in, Output => image(22,4));
    R22_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(5), Input => data_in, Output => image(22,5));
    R22_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(6), Input => data_in, Output => image(22,6));
    R22_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(7), Input => data_in, Output => image(22,7));
    R22_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(8), Input => data_in, Output => image(22,8));
    R22_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(9), Input => data_in, Output => image(22,9));
    R22_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(10), Input => data_in, Output => image(22,10));
    R22_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(11), Input => data_in, Output => image(22,11));
    R22_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(12), Input => data_in, Output => image(22,12));
    R22_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(13), Input => data_in, Output => image(22,13));
    R22_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(14), Input => data_in, Output => image(22,14));
    R22_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(15), Input => data_in, Output => image(22,15));
    R22_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(16), Input => data_in, Output => image(22,16));
    R22_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(17), Input => data_in, Output => image(22,17));
    R22_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(18), Input => data_in, Output => image(22,18));
    R22_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(19), Input => data_in, Output => image(22,19));
    R22_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(20), Input => data_in, Output => image(22,20));
    R22_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(21), Input => data_in, Output => image(22,21));
    R22_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(22), Input => data_in, Output => image(22,22));
    R22_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(23), Input => data_in, Output => image(22,23));
    R22_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(24), Input => data_in, Output => image(22,24));
    R22_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(25), Input => data_in, Output => image(22,25));
    R22_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(26), Input => data_in, Output => image(22,26));
    R22_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(22), eny => ysel(27), Input => data_in, Output => image(22,27));
    
    
    R23_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(0), Input => data_in, Output => image(23,0));
    R23_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(1), Input => data_in, Output => image(23,1));
    R23_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(2), Input => data_in, Output => image(23,2));
    R23_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(3), Input => data_in, Output => image(23,3));
    R23_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(4), Input => data_in, Output => image(23,4));
    R23_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(5), Input => data_in, Output => image(23,5));
    R23_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(6), Input => data_in, Output => image(23,6));
    R23_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(7), Input => data_in, Output => image(23,7));
    R23_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(8), Input => data_in, Output => image(23,8));
    R23_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(9), Input => data_in, Output => image(23,9));
    R23_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(10), Input => data_in, Output => image(23,10));
    R23_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(11), Input => data_in, Output => image(23,11));
    R23_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(12), Input => data_in, Output => image(23,12));
    R23_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(13), Input => data_in, Output => image(23,13));
    R23_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(14), Input => data_in, Output => image(23,14));
    R23_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(15), Input => data_in, Output => image(23,15));
    R23_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(16), Input => data_in, Output => image(23,16));
    R23_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(17), Input => data_in, Output => image(23,17));
    R23_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(18), Input => data_in, Output => image(23,18));
    R23_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(19), Input => data_in, Output => image(23,19));
    R23_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(20), Input => data_in, Output => image(23,20));
    R23_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(21), Input => data_in, Output => image(23,21));
    R23_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(22), Input => data_in, Output => image(23,22));
    R23_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(23), Input => data_in, Output => image(23,23));
    R23_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(24), Input => data_in, Output => image(23,24));
    R23_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(25), Input => data_in, Output => image(23,25));
    R23_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(26), Input => data_in, Output => image(23,26));
    R23_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(23), eny => ysel(27), Input => data_in, Output => image(23,27));
    
    
    R24_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(0), Input => data_in, Output => image(24,0));
    R24_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(1), Input => data_in, Output => image(24,1));
    R24_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(2), Input => data_in, Output => image(24,2));
    R24_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(3), Input => data_in, Output => image(24,3));
    R24_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(4), Input => data_in, Output => image(24,4));
    R24_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(5), Input => data_in, Output => image(24,5));
    R24_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(6), Input => data_in, Output => image(24,6));
    R24_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(7), Input => data_in, Output => image(24,7));
    R24_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(8), Input => data_in, Output => image(24,8));
    R24_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(9), Input => data_in, Output => image(24,9));
    R24_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(10), Input => data_in, Output => image(24,10));
    R24_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(11), Input => data_in, Output => image(24,11));
    R24_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(12), Input => data_in, Output => image(24,12));
    R24_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(13), Input => data_in, Output => image(24,13));
    R24_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(14), Input => data_in, Output => image(24,14));
    R24_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(15), Input => data_in, Output => image(24,15));
    R24_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(16), Input => data_in, Output => image(24,16));
    R24_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(17), Input => data_in, Output => image(24,17));
    R24_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(18), Input => data_in, Output => image(24,18));
    R24_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(19), Input => data_in, Output => image(24,19));
    R24_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(20), Input => data_in, Output => image(24,20));
    R24_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(21), Input => data_in, Output => image(24,21));
    R24_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(22), Input => data_in, Output => image(24,22));
    R24_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(23), Input => data_in, Output => image(24,23));
    R24_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(24), Input => data_in, Output => image(24,24));
    R24_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(25), Input => data_in, Output => image(24,25));
    R24_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(26), Input => data_in, Output => image(24,26));
    R24_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(24), eny => ysel(27), Input => data_in, Output => image(24,27));
    
    
    R25_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(0), Input => data_in, Output => image(25,0));
    R25_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(1), Input => data_in, Output => image(25,1));
    R25_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(2), Input => data_in, Output => image(25,2));
    R25_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(3), Input => data_in, Output => image(25,3));
    R25_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(4), Input => data_in, Output => image(25,4));
    R25_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(5), Input => data_in, Output => image(25,5));
    R25_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(6), Input => data_in, Output => image(25,6));
    R25_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(7), Input => data_in, Output => image(25,7));
    R25_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(8), Input => data_in, Output => image(25,8));
    R25_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(9), Input => data_in, Output => image(25,9));
    R25_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(10), Input => data_in, Output => image(25,10));
    R25_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(11), Input => data_in, Output => image(25,11));
    R25_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(12), Input => data_in, Output => image(25,12));
    R25_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(13), Input => data_in, Output => image(25,13));
    R25_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(14), Input => data_in, Output => image(25,14));
    R25_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(15), Input => data_in, Output => image(25,15));
    R25_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(16), Input => data_in, Output => image(25,16));
    R25_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(17), Input => data_in, Output => image(25,17));
    R25_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(18), Input => data_in, Output => image(25,18));
    R25_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(19), Input => data_in, Output => image(25,19));
    R25_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(20), Input => data_in, Output => image(25,20));
    R25_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(21), Input => data_in, Output => image(25,21));
    R25_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(22), Input => data_in, Output => image(25,22));
    R25_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(23), Input => data_in, Output => image(25,23));
    R25_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(24), Input => data_in, Output => image(25,24));
    R25_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(25), Input => data_in, Output => image(25,25));
    R25_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(26), Input => data_in, Output => image(25,26));
    R25_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(25), eny => ysel(27), Input => data_in, Output => image(25,27));
    
    
    R26_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(0), Input => data_in, Output => image(26,0));
    R26_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(1), Input => data_in, Output => image(26,1));
    R26_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(2), Input => data_in, Output => image(26,2));
    R26_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(3), Input => data_in, Output => image(26,3));
    R26_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(4), Input => data_in, Output => image(26,4));
    R26_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(5), Input => data_in, Output => image(26,5));
    R26_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(6), Input => data_in, Output => image(26,6));
    R26_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(7), Input => data_in, Output => image(26,7));
    R26_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(8), Input => data_in, Output => image(26,8));
    R26_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(9), Input => data_in, Output => image(26,9));
    R26_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(10), Input => data_in, Output => image(26,10));
    R26_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(11), Input => data_in, Output => image(26,11));
    R26_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(12), Input => data_in, Output => image(26,12));
    R26_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(13), Input => data_in, Output => image(26,13));
    R26_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(14), Input => data_in, Output => image(26,14));
    R26_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(15), Input => data_in, Output => image(26,15));
    R26_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(16), Input => data_in, Output => image(26,16));
    R26_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(17), Input => data_in, Output => image(26,17));
    R26_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(18), Input => data_in, Output => image(26,18));
    R26_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(19), Input => data_in, Output => image(26,19));
    R26_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(20), Input => data_in, Output => image(26,20));
    R26_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(21), Input => data_in, Output => image(26,21));
    R26_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(22), Input => data_in, Output => image(26,22));
    R26_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(23), Input => data_in, Output => image(26,23));
    R26_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(24), Input => data_in, Output => image(26,24));
    R26_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(25), Input => data_in, Output => image(26,25));
    R26_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(26), Input => data_in, Output => image(26,26));
    R26_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(26), eny => ysel(27), Input => data_in, Output => image(26,27));
    
    
    R27_0	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(0), Input => data_in, Output => image(27,0));
    R27_1	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(1), Input => data_in, Output => image(27,1));
    R27_2	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(2), Input => data_in, Output => image(27,2));
    R27_3	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(3), Input => data_in, Output => image(27,3));
    R27_4	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(4), Input => data_in, Output => image(27,4));
    R27_5	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(5), Input => data_in, Output => image(27,5));
    R27_6	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(6), Input => data_in, Output => image(27,6));
    R27_7	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(7), Input => data_in, Output => image(27,7));
    R27_8	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(8), Input => data_in, Output => image(27,8));
    R27_9	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(9), Input => data_in, Output => image(27,9));
    R27_10	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(10), Input => data_in, Output => image(27,10));
    R27_11	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(11), Input => data_in, Output => image(27,11));
    R27_12	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(12), Input => data_in, Output => image(27,12));
    R27_13	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(13), Input => data_in, Output => image(27,13));
    R27_14	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(14), Input => data_in, Output => image(27,14));
    R27_15	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(15), Input => data_in, Output => image(27,15));
    R27_16	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(16), Input => data_in, Output => image(27,16));
    R27_17	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(17), Input => data_in, Output => image(27,17));
    R27_18	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(18), Input => data_in, Output => image(27,18));
    R27_19	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(19), Input => data_in, Output => image(27,19));
    R27_20	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(20), Input => data_in, Output => image(27,20));
    R27_21	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(21), Input => data_in, Output => image(27,21));
    R27_22	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(22), Input => data_in, Output => image(27,22));
    R27_23	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(23), Input => data_in, Output => image(27,23));
    R27_24	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(24), Input => data_in, Output => image(27,24));
    R27_25	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(25), Input => data_in, Output => image(27,25));
    R27_26	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(26), Input => data_in, Output => image(27,26));
    R27_27	: reg_8bit port map(CLK => CLK, rst => rst, enx => xsel(27), eny => ysel(27), Input => data_in, Output => image(27,27));
    

    -- process (rst, CLK)
	-- begin
    --     if (rst = '1') then
    --         out_A <= "00000000";
    --         out_B <= "00000000";
    --     elsif (CLK'event and CLK = '1') then
    --         out_A <= tmp_A;
    --         out_B <= tmp_B;
    --        -- if (re_enA = '1') then
    --            -- out_A <= elem_A(TO_INTEGER(addr_A));
    --         --elsif (wr_enA = '1') then
    --         --    elem_A(TO_INTEGER(addr_A)) <= in_A;
    --        -- end if;

    --        -- if (re_enB = '1') then
    --             --out_B <= elem_B(TO_INTEGER(addr_B));
    --        -- elsif (wr_enB = '1')  then
    --            -- elem_B(TO_INTEGER(addr_B)) <= in_B;
    --     end if;
	-- end process;

	 


end Behavioral;
