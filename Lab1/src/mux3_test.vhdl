--
-- Entity: mux3_test
-- Architecture : vhdl
-- Author: Sheung Lu
-- Created On: 09/11/2015
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity mux3_test is

end mux3_test;

architecture test of mux3_test is

component mux3

	port (
		s1	: in	std_logic;
		s0	: in	std_logic;
		input	: in	std_logic;
		output	: out	std_logic);
end component;

for m1 : mux3 use entity work.mux3(structural);

signal s1,s0 : std_logic;
signal ip,op : std_logic;
signal clock : std_logic;

begin

m1 : mux3 port map (s1,s0, ip, op);

clk : process
	begin -- process clk
	
		clock <= '0','1' after 5 ns;
		wait for 10 ns;
		
	end process clk;
	
io_process: process

  file infile  : text is in "mux3_in.txt";
  file outfile : text is out "mux3_out.txt";
  variable sel1 : std_logic_vector(1 downto 0);
  variable i1,o1 : std_logic;
  variable buf : line;

begin

  while not (endfile(infile)) loop


    readline(infile,buf);
    read (buf,sel1);
    s1<=sel1(1);
	s0<=sel1(0);

    readline(infile,buf);
    read (buf,i1);
    ip<=i1;

		wait until falling_edge(clock);

    o1:=op;

    write(buf,o1);
    writeline(outfile,buf);

  end loop;

end process io_process;



end test;
