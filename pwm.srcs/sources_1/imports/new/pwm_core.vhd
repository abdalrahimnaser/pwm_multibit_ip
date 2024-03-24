----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 10:37:25
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm_core is
   generic(W : integer := 16; -- Width      (W):no of analogue output bits
           R: integer := 8 ;   -- Resolution (R): duty goes from 0/(2**R) (0%) up to (2**R)/(2**R) (100%)
            DVSR :integer := 7812
           );  
   port(
      clk     : in  std_logic;
      reset   : in  std_logic;
      -- slot interface 
      addr : in std_logic_vector(3 downto 0);
      wr_en : in std_logic;
      wr_data : in  std_logic_vector(R downto 0);
      -- external signal
      pwm_out   : out std_logic_vector(W - 1 downto 0)
   );

end pwm_core;

architecture Behavioral of pwm_core is
signal output_reg : std_logic_vector(W - 1 downto 0);
type resolution_type is array (W-1 downto 0) of std_logic_vector(R downto 0);
signal resolution_regs : resolution_type;
signal q_reg,q_next: unsigned(31 downto 0);
signal tick: std_logic;

begin

process(clk,reset)
begin
    if reset = '1' then
        resolution_regs <= (others => (others => '0'));
        q_reg <= (others => '0');
    elsif rising_edge(clk) then
        q_reg <= q_next;
        if wr_en = '1'  then
            resolution_regs(to_integer(unsigned(addr(3 downto 0)))) <= wr_data;
        end if;
    end if;

end process;



-- mod-dvsr counter
q_next <= (others => '0') when q_reg = DVSR else q_reg + 1;
tick <= '1' when q_reg = 0 else '0';


gen: for i in 0 to W-1 generate
    pwm_helper :entity work.pwm_helper(Behavioral)
    generic map(R=> R)
    port map(
        clk          => clk,
        reset        => reset,
        duty         => resolution_regs(i),
        tick       => tick,
        pwm_out => output_reg(i)
    );



end generate gen;

pwm_out <= output_reg;

end Behavioral;






