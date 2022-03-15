---------------------------------------------------------------------------------------------------
--
-- Title       : dcd3_8
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : dcd3_8.vhd
-- Generated   : Thu Apr 15 10:11:02 2021
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
--{entity {dcd3_8} architecture {dcd3_8}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dec1_8 is
port
(sel : in std_logic_vector(2 downto 0);
	res : out std_logic_vector(7 downto 0));
end dec1_8;

--}} End of automatically maintained section

architecture comb of dec1_8 is
begin
res <= "00000001" when sel = "000" else
"00000010" when sel = "001" else
"00000100" when sel = "010" else
"00001000" when sel = "011" else
"00010000" when sel = "100" else
"00100000" when sel = "101" else
"01000000" when sel = "110" else
"10000000";
end comb;
