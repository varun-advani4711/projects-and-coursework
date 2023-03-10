
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
	port(i_D0	: in std_logic;
	     i_D1	: in std_logic;
	     i_S	: in std_logic;
	     o_O	: out std_logic);
end mux2t1;

architecture structural of mux2t1 is

	
	component andg2 is
	  port( i_A,i_B : in std_logic;
		o_F	: out std_logic);
	end component;

	
	component org2 is
	  port( i_A,i_B : in std_logic;
		o_F	: out std_logic);
	end component;

	
	component invg is
	  port( i_A	: in std_logic;
		o_F	: out std_logic);
	end component;

	
	signal s_S,s_D0,s_D1 : std_logic;

begin
	x1: invg
	  port map(i_A => i_S,
		   o_F => s_S);

	x2: andg2
	  port map(i_A => s_S,
		   i_B => i_D0,
		   o_F => s_D0);

	x3: andg2
	  port map(i_A => i_S,
		   i_B => i_D1,
		   o_F => s_D1);

	x4: org2
	  port map(i_A => s_D0,
		   i_B => s_D1,
		   o_F => o_O);
end structural;
