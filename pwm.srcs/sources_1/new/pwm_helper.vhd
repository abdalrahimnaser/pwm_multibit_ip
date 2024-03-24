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

entity pwm_helper is
generic(
    R: integer := 8
);
Port (
    clk,reset : in std_logic;
    duty : in std_logic_vector(R downto 0);
    pwm_out : out std_logic;
    tick: in std_logic


 );
end pwm_helper;

architecture Behavioral of pwm_helper is

signal d_reg,d_next : unsigned(R-1 downto 0);
signal d_ext : unsigned(R downto 0);
signal pwm_reg,pwm_next: std_logic;

begin

process(clk,reset)
begin 
    if reset = '1' then
        d_reg <= (others => '0');
        pwm_reg <= '0';


    elsif rising_edge(clk) then
        d_reg <= d_next;
        pwm_reg <= pwm_next;


    end if;
end process;

-- pwm counting logic
d_next <= d_reg + 1 when tick = '1' else d_reg;
d_ext <= '0'&d_reg;


-- output logic
pwm_next <= '1' when d_ext < unsigned(duty) else '0';
pwm_out <= pwm_reg;

end Behavioral;
