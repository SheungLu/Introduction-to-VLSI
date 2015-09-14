--
-- Entity: mux3 
-- Architecture : structural 
-- Author: Sheung Lu
-- Created On: 09/11/2015 9:48 PM
--
library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity alu_4 is
	port(
		A: in std_logic_vector(3 downto 0);
		B: in std_logic_vector(3 downto 0);
		Cin: in std_logic;
		S0: in std_logic;
		S1: in std_logic;
		G: out std_logic_vector(3 downto 0);
		Cout: out std_logic);
		
end alu_4;

architecture structural of alu_4 is

component mux3

	port (
		s1	: in	std_logic;
		s0	: in	std_logic;
		input	: in	std_logic;
		output	: out	std_logic);
end component;

component adder4
  port (
    input1   : in  std_logic_vector(3 downto 0);
    input2   : in  std_logic_vector(3 downto 0);
    carryin  : in  std_logic;
    sum      : out std_logic_vector(3 downto 0);
    carryout : out std_logic);
end component;

for mux3_0, mux3_1, mux3_2, mux3_3 : mux3 use entity work.mux3(structural);
for adder4_1 : adder4 use entity work.adder4(structural);

signal temp1 : std_logic_vector(3 downto 0);

begin

mux3_0 : mux3 port map (S1, S0, B(0), temp1(0));
mux3_1 : mux3 port map (S1, S0, B(1), temp1(1));
mux3_2 : mux3 port map (S1, S0, B(2), temp1(2));
mux3_3 : mux3 port map (S1, S0, B(3), temp1(3));

adder4_1 : adder4 port map (A,temp1,Cin,G,Cout);

end structural;


