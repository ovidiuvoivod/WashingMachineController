---------------------------------------------------------------------------------------------------
--
-- Title       : nbits_register
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : nbits_register.vhd
-- Generated   : Mon Apr 12 19:41:34 2021
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
--{entity {nbits_register} architecture {nbits_register}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nbits_register is  
	generic(n: natural:=4);
	port(Shift,Dir,CLK,LD,Reset,SI:in std_logic;
	D_in: in std_logic_vector(n-1 downto 0);
	D_out: out std_logic_vector(n-1 downto 0));
end nbits_register;

--}} End of automatically maintained section

architecture arch_register of nbits_register is
signal aux: std_logic_vector(n-1 downto 0);
begin
	process(CLK,Reset)
	begin
		if(Reset='1') then aux<=(others=>'0');
		elsif(CLK='1' and CLK'EVENT) then
			if(LD='1') then
				aux<=D_in;
			elsif(Shift='1') then
				if(dir='0') then  aux<=SI&aux(n-1 downto 1);
				else
					aux<=aux(n-2 downto 0)&SI;
					
				end if;
				end if;
			end if;
			D_out<=aux;
			end process;
			
					
	 -- enter your statements here --

end arch_register;
