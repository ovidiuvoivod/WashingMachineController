---------------------------------------------------------------------------------------------------
--
-- Title       : cnt
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : cnt.vhd
-- Generated   : Wed Apr 21 22:14:27 2021
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
--{entity {cnt} architecture {cnt}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use	IEEE.STD_LOGIC_arith.all; 
use IEEE.STD_LOGIC_unsigned.all; 

entity cnt is 
	generic(n:natural);
	port(reset,CLK: in std_logic;
	--DATA: in std_logic_vector(n-1 downto 0);
	Q: out std_logic_vector(n-1 downto 0));
	
end cnt;

--}} End of automatically maintained section

architecture arch_cnt of cnt is
begin

	process(CLK,reset)
	variable intern: std_logic_vector(n-1 downto 0):=(others=>'0');	 
	--variable ok: std_logic:='1';
	begin  
		if reset='1' then intern:=(others=>'0');	
		elsif (CLK='1' and CLK'EVENT) then
				intern:=intern+1;	 
				
			end if;	
			
			--end if;
			Q<=intern; 
			
			end process;
			
end arch_cnt;	 
