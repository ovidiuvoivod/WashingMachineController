---------------------------------------------------------------------------------------------------
--
-- Title       : counter
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : counter.vhd
-- Generated   : Mon Apr 12 16:43:49 2021
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
--{entity {counter} architecture {counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use	IEEE.STD_LOGIC_arith.all; 
use IEEE.STD_LOGIC_unsigned.all; 

entity counter is 
	generic(n:natural);
	port(load,reset,CLK,dir: in std_logic;
	DATA: in std_logic_vector(n-1 downto 0);
	Q: out std_logic_vector(n-1 downto 0));
	
end counter;

--}} End of automatically maintained section

architecture arch_counter of counter is
begin

	process(CLK,reset)
	variable intern: std_logic_vector(n-1 downto 0):=(others=>'0');	 
	variable ok: std_logic:='1';
	begin  
		if reset='1' then intern:=(others=>'0');	
		elsif (CLK='1' and CLK'EVENT) then
			if load='1' then
				intern:=data;
			else
				intern:=intern+1;	 
				end if;
			end if;	
			
			--end if;
			Q<=intern; 
			
			end process;
			
end arch_counter;	 

architecture arch_counter_bidir	of counter is
begin
	process(CLK,reset)   
	variable direction: integer;
	variable count: std_logic_vector(n-1 downto 0);--:=(others=>'0');
	begin
		
		if dir='0' then direction:=1; 
			else direction:=-1;
		end if;
		
		if reset='1' then count:=(others=>'0');
		elsif (CLK='1' and CLK'EVENT) then
			 if load='1' then
				count:=data;
			 else
				 count:= count+direction;
				 
			 end if;
			 end if;
			 
			 Q<=count;
		end process;
		
end arch_counter_bidir;	

architecture down_counter of counter is

begin
	process(CLK,reset)
	variable intern: std_logic_vector(n-1 downto 0):=(others=>'0');	 
	variable ok: std_logic:='1';
	begin  
		if reset='1' then intern:=(others=>'0');	
		elsif (CLK='1' and CLK'EVENT) then
			if load='1' then
				intern:=data;
			else
				intern:=intern-1;	 
				end if;
			end if;	
			--end if;
			Q<=intern; 
			
			end process;
			 
end down_counter; 			
			
	
