--
-- Entity: mux3 
-- Architecture : structural 
-- Author: Sheung Lu
-- Created On: 09/11/2015 1:55 PM
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux3 is

	port (
		s1	: in	std_logic;
		s0	: in	std_logic;
		input	: in	std_logic;
		output	: out	std_logic);
end mux3;

architecture structural of mux3 is

component and2
  port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;

component or2

  port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end component;
		
component inverter

  port (
    input    : in  std_logic;
    output   : out std_logic);
end component;

for and2_1, and2_2: and2 use entity work.and2(structural);
for or2_1: or2 use entity work.or2(structural);
for inverter_1: inverter use entity work.inverter(structural);

signal temp1, temp2, temp3: std_logic;

begin

and2_1: 	and2 	port map (s0, input, temp1);
inverter_1: inverter port map (input, temp2);
and2_2: 	and2 	port map (s1, temp2, temp3);
or2_1:		or2		port map (temp1, temp3, output);

end structural;
