---------------------------------------------------------------------------------------------------
--
-- Title       : FA_1
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : FA_1.vhd
-- Generated   : Sun Apr 11 22:48:23 2021
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
--{entity {FA_1} architecture {FA_1}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fulladder1bit is	 
	port(A,B,CIN: in std_logic;
	S,COUT: out std_logic);
end fulladder1bit;

--}} End of automatically maintained section

architecture FA_1 of fulladder1bit is
signal intern: std_logic;
begin
	intern<=A xor B;
	S<=intern xor CIN;
	COUT<=(A and B) or (intern and CIN);
	
	 

end FA_1;
