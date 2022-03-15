---------------------------------------------------------------------------------------------------
--
-- Title       : afisor
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : afisor.vhd
-- Generated   : Wed May 12 12:37:49 2021
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
--{entity {afisor} architecture {afisor}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity afisor is  
	port(i:in std_logic_vector(3 downto 0);
	LED_OUT:out std_logic_vector(6 downto 0));
end afisor;								   

--}} End of automatically maintained section

architecture arch_afis of afisor is
begin
  process(i) 
  begin
	case i is
		when "0000"=> LED_OUT<="1111110";
		when "0001"=> LED_OUT<="0110000"; 
		when "0010"=> LED_OUT<="1101101";
		when "0011"=> LED_OUT<="1111001";
		when "0100"=> LED_OUT<="0110011";
		when "0101"=> LED_OUT<="1011010";
		when "0110"=> LED_OUT<="1011111";
		when "0111"=> LED_OUT<="1110000";
		when "1000"=> LED_OUT<="1111111";
		when "1001"=> LED_OUT<="1101111";
 		when others=> LED_OUT<="0000000";
	end case;
	end process;
end arch_afis;
