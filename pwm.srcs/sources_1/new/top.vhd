----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2024 16:09:39
-- Design Name: 
-- Module Name: top - Behavioral
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


entity top is
Port ( 
    -- INPUT
    clk,reset : in std_logic;
    push      : in std_logic;
    sw        : in std_logic_vector(15 downto 0);
    -- OUTPUT
    led : out std_logic_vector(15 downto 0)
);
end top;

architecture Behavioral of top is

signal addr : std_logic_vector(3 downto 0);
signal wr_data : std_logic_vector(8 downto 0);

begin

    addr  <= sw(15 downto 12);
    wr_data <= sw(8 downto 0);

    pwm_unit :entity work.pwm_core(Behavioral)
            generic map(W => 16,
                        R=> 8,
                        DVSR => 7812 
            )
            port map(
                clk          => clk,
                reset        => reset,
                wr_en        => push,
                addr         => addr,
                wr_data      => wr_data,
                pwm_out   => led
            );


end Behavioral;
