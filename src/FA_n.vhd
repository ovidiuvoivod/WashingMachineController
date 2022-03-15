---------------------------------------------------------------------------------------------------
--
-- Title       : FA_n
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : FA_n.vhd
-- Generated   : Sun Apr 11 23:01:25 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {FA_n} architecture {FA_n}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fulladder_n_bits is 
	generic(n:natural:=3);
	port( A,B: in std_logic_vector(n-1 downto 0);
	CIN: in std_logic;
	S: out std_logic_vector(n-1 downto 0);
	COUT: out std_logic);
end fulladder_n_bits;

--}} End of automatically maintained section

architecture FA_n of fulladder_n_bits is

	component fulladder1bit is	 
	port(A,B,CIN: in std_logic;
	S,COUT: out std_logic);
end component;	 
	signal int: std_logic_vector(n-2 downto 0);
begin	 
	L1: for i in 0 to n-1 generate	
	L2:	if i=0 generate
	L3: fulladder1bit port map(A(i),B(i),CIN,S(i),int(i)); 
	end generate;
	L4: if(i>0) and (i<n-1) generate
	L5:	fulladder1bit port map(A(i),B(i),int(i-1),S(i),int(i));
	end generate;
	L6: if i=n-1 generate
	L7: fulladder1bit port map(A(i),B(i),int(i-1),S(i),COUT);
	end generate;
	end generate;
	


end FA_n;
