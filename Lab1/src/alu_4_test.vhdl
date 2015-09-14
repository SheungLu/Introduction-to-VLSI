--
-- Entity: alu_4_test
-- Architecture : vhdl
-- Author: Sheung Lu
-- Created On: 09/11/2015
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity alu_4_test is

end alu_4_test;

architecture test of alu_4_test is

component alu_4

	port(
		A: in std_logic_vector(3 downto 0);
		B: in std_logic_vector(3 downto 0);
		Cin: in std_logic;
		S0: in std_logic;
		S1: in std_logic;
		G: out std_logic_vector(3 downto 0);
		Cout: out std_logic);
end component;

for alu1 : alu_4 use entity work.alu_4(structural);

signal a1,b1,op : std_logic_vector(3 downto 0);
signal cin1,cout1,s0,s1 : std_logic;
signal clock : std_logic;

begin

alu1 : alu_4 port map (a1,b1,cin1,s0,s1,op,cout1);

clk : process
	begin -- process clk
	
		clock <= '0','1' after 5 ns;
		wait for 10 ns;
		
	end process clk;
	
io_process: process

  file infile  : text is in "alu_4_in.txt";
  file outfile : text is out "alu_4_out.txt";
  variable Ain, Bin, o1: std_logic_vector(3 downto 0);
  variable sel1, sel0 : std_logic;
  variable cin, cout : std_logic;
  variable buf : line;

begin

  while not (endfile(infile)) loop

	readline(infile,buf);
    read (buf,Ain);
    a1<=Ain;

	readline(infile,buf);
    read (buf,Bin);
    b1<=Bin;
	
	readline(infile,buf);
    read (buf,cin);
    cin1<=cin;
	
    readline(infile,buf);
    read (buf,sel1);
    s1<=sel1;
	
	readline(infile,buf);
    read (buf,sel0);
    s0<=sel0;
	
    wait until falling_edge(clock);

    o1:=op;
	cout := cout1;

    write(buf,o1);
    writeline(outfile,buf);

	write(buf,cout);
    writeline(outfile,buf);

  end loop;

end process io_process;

end test;