--
-- Entity: mux3 
-- Architecture : structural 
-- Author: cpatel2
-- Created On: 10/20/00 at 13:32
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux3 is

	port (
		sel			:in		std_logic_vector(1 downto 0);
		input		:in		std_logic_vector(3 downto 0);
		output	:out	std_logic_vector(3 downto 0);
		);
end mux3;

architecture structural of mux3 is

component mux3
	port (
		sel			:in 	std_logic;
		input		:in 	std_logic;
		output	:out 	std_logic;);
end component;
		
for and2_1, and2_2: and2 use work.and2(structural);
for or2_1: or2 use entity work.or2(structural);
for inverter_1: inverter use entity work.inverter(structural);


