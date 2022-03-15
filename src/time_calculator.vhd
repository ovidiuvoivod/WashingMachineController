---------------------------------------------------------------------------------------------------
--
-- Title       : time_calculator
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : time_calculator.vhd
-- Generated   : Wed May 12 13:29:42 2021
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
--{entity {time_calculator} architecture {time_calculator}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use	IEEE.STD_LOGIC_arith.all; 
use IEEE.STD_LOGIC_unsigned.all;

entity time_calculator is 
	port(timpul:in std_logic_vector (11 downto 0);
	M1,M2,S1,S2:out std_logic_vector(3 downto 0));
end time_calculator;

--}} End of automatically maintained section

architecture TC_arch of time_calculator is
signal min: integer;
signal sec: integer;
signal timpaux:integer;
begin	   	 
	
	process(timpaux)
	begin
		timpaux<=conv_integer(timpul);
		min<=timpaux/60;
		sec<=timpaux mod 60;
	end process; 
	
	process(min,sec)
	variable x:integer;
	variable minut: integer;
	variable secunda: integer;
	begin
		minut:=min;
		secunda:=sec;
		x:=minut mod 10; 
		M1<=conv_std_logic_vector(x, 4);
		minut:=minut/10;
		x:=minut mod 10; 
		M2<=conv_std_logic_vector(x, 4); 
		
		x:=secunda mod 10; 
		S1<=conv_std_logic_vector(x, 4);
		secunda:=secunda/10;
		x:=secunda mod 10; 
		S2<=conv_std_logic_vector(x, 4);
	end process;	 
	 

end TC_arch;
