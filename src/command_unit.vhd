---------------------------------------------------------------------------------------------------
--
-- Title       : command_unit
-- Design      : components
-- Author      : ovidiu.voivod6046@gmail.com
-- Company     : UTCN
--
---------------------------------------------------------------------------------------------------
--
-- File        : command_unit.vhd
-- Generated   : Wed Apr 21 13:54:40 2021
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
--{entity {command_unit} architecture {command_unit}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use	IEEE.STD_LOGIC_arith.all; 
use IEEE.STD_LOGIC_unsigned.all; 

entity command_unit is	
	port(M_A: in std_logic ;--manual/auto
	reset: in std_logic;
	temp: in std_logic_vector (1 downto 0); --temperature 
	vit: in std_logic_vector (1 downto 0); -- viteza
	sig1:in std_logic:='0'; -- anulare prespalare	(1=prespalare; 0= anulare)
	sig2:in std_logic:='0'; -- anulare clatire suplimentara	(1=clatire supl.; 0=anulare clatire supl.)
	clk: in std_logic;
	usa: buffer std_logic; --washing machine door 
	start: in std_logic;
	mod_auto: in std_logic_vector(2 downto 0);
	--z1: out std_logic_vector(6 downto 0);
	--z2: out std_logic_vector(6 downto 0);
	timp2: out std_logic_vector(11 downto 0)); 
	
	
end command_unit;

--}} End of automatically maintained section

architecture arch_cu of command_unit is
type state_type is (STANDBY,A,B,C,D,E,F,INTERMEDIAR,G,INCALZIRE,H,I,T20,JA,T10,K,L,M,N,O,P,QQ,R,S,T,U,V);
signal state: state_type;
signal auxsig1: std_logic;
signal auxsig2: std_logic;
signal manauxsig1: std_logic:='0'; 
signal manauxsig2: std_logic:='0';
signal al: std_logic; 
signal evac:std_logic;
signal intclock:std_logic;
signal auxusa: std_logic; -- W.M door lock 
signal incalz:std_logic; 
signal intcnt:std_logic_vector(10 downto 0);	
signal internalTemp: std_logic_vector(6 downto 0);
signal rotatie: std_logic_vector(11 downto 0);
signal auxtime: std_logic_vector(11 downto 0); 
signal enable: bit:='0';


begin
	
	
		
	process(reset,clk) 
	variable viteza: std_logic_vector(11 downto 0);
	variable temperatura: natural; 
	variable Q: std_logic_vector(4 downto 0);
	variable intRotation:std_logic_vector(11 downto 0); 
	variable intTemp: std_logic_vector(6 downto 0):="0001111";
	variable count: std_logic_vector (3 downto 0):="0000";
	variable internalcnt:std_logic_vector(10 downto 0):=(others=>'0');
	variable timp: natural;
	begin  
		if reset='1' then
			state<=STANDBY;
		elsif(clk='1' and clk'event) then
			case state is
				
				when STANDBY=> 
				intTemp:=(others=>'0');
				intRotation:=(others=>'0');

				if M_A='1' then 
					state<=A;
				else
					state<=B;
				end if;
				
				when A=>
				if(mod_auto="000") then	
					temperatura:=30;
					viteza:=x"4B0"; --1200 
				elsif(mod_auto="001") then
					temperatura:=60;
					viteza:=x"320"; --800 
				elsif(mod_auto="010") then
					temperatura:=40;
					viteza:=x"3E8"; --1000
					manauxsig2<='1';
				elsif(mod_auto="011") then
					temperatura:=40;
					viteza:=x"3E8"; --1000
					manauxsig1<='1';
				elsif(mod_auto="100") then
					temperatura:=90;
					viteza:=x"4B0"; --1200 
					manauxsig2<='1';
				end if;	
			state<=D;
			when B=>
			if temp="00" then
				temperatura:=30;
			elsif temp="01" then
				temperatura:=40;
				
			elsif temp="10"	then
				temperatura:=60;
			else
				temperatura:=90;
			end if;
			state<=C;
				
			
			when C=> 
			if vit="00" then
				viteza:=x"320"; --800
			elsif vit="01" then
				viteza:=x"3E8"; --1000
			elsif vit="10" then
				viteza:=x"4B0"; --1200 
			else
			viteza:=x"3E8"; --1000 take it as default value
			end if;		
			state<=D;
			when D=>
			if M_A='0' then
				auxsig1<=sig1;
				auxsig2<=sig2;
			else
				auxsig1<=manauxsig1;
				auxsig2<=manauxsig2;  
			end if;
			if(start='0' or usa='0' ) then
				state<=D;
			else
				state<=E;--state separat pentru usa??
				
				auxusa<='1'; --washing machine is locked
			end if;
		
			when E=> 
			if auxsig1='1' then
				timp:=((temperatura-15)*2+1220)*2;
			else
				timp:=(temperatura-15)*2+1220;
			end if;	
			enable<='1';
			
			if auxsig2='1' then
				timp:=timp+1240;
			else
				timp:=timp+620;
			end if;
			timp:=timp+600;
				internalcnt:="00000000000";
				state<=F; 
				when F=>
				enable<='0';
				state<=INTERMEDIAR;
				when INTERMEDIAR=>
				if internalcnt="1010" then	--trebuie data val buna!!
					state<=G;
					intTemp:="0001111";
					--internalcnt:="0000"; --dupa ce trece timpul destinat alimentarii 
										 --resetam counterul si trecem in starea imediat urmatoare
				else
					internalcnt:=internalcnt+1;
					state<=INTERMEDIAR;
				end if;
					
				      
				-- folosim timerul!!!!	
				-- verificam daca a trecut timpul destinat alimentarii cu apa
				-- dupa care trecem la starea urmatoare	 
				--if(al='0') then
				--	state<=F;
				--else
				--	state<=G;	
				--end if;	
				when G=> 
				state<=INCALZIRE;
				
				when INCALZIRE=>
				if intTemp=temperatura then 	   --incazlirea dureaza o perioada de timp
					state<=H;
					intRotation:=X"03C"; --60 rotatii
				else
					intTemp:=intTemp+1;	 --temperatura creste 1 grad/2secunde
					if intTemp=temperatura then		--atentie cand temp ajunge la final!!
						state<=H;
					end if;
					state<=G;
				end if;	
				when H=>  
				internalcnt:="00000000000";
				if  auxsig1='1' then  --evit loop la K  !!! atentie la auxsig
					state<=JA;
					--auxsig1<='0';
				else
					state<=I; 
				end if;	
				when I=> 
				state<=T20;
				internalcnt:="00000000000";
				when T20=>
				if internalcnt="10010110000" then --20 minutes
					state<=L; 
					internalcnt:="00000000000";
				else
					state<=T20; 
					internalcnt:=internalcnt+1;
				end if;
				when JA=> 
				auxsig1<='0';
				state<=T10;
				when T10=>
				if internalcnt="01001011000" then --10 minutes
					state<=K;
					internalcnt:="00000000000";
				else
					state<=T10; 
					internalcnt:=internalcnt+1;
				end if;	
				
				when K=> 
				  if internalcnt="1010" then 	--10 seconds for water evacuation
					state<=F;
					internalcnt:="00000000000"; --reset the counter
				  else
					  internalcnt:=internalcnt+1;
					  state<=K;	 
				  end if;
				  
					  
				
				when L=>
				 if internalcnt="1010" then 	--10 seconds for water evacuation
					state<=M;
					internalcnt:="00000000000"; --reset the counter
				 else
					  internalcnt:=internalcnt+1;
					  state<=L;	 
				  end if;
				when M=>
				if internalcnt="1010" then 	--10 seconds for water supply
					state<=N;
					internalcnt:="00000000000"; --reset the counter
				else
					internalcnt:=internalcnt+1;
					state<=M;	 
				 end if;
				when N=> 
				intRotation:=x"078";  --120 rotatii
				state<=O;
					--avoid loop at sig2
				when O=>
				if  auxsig2='1' then 
					state<=P;
					internalcnt:="00000000000";
				else
					state<=R;
					
				end if;
				when P=>
				if internalcnt="01001011000" then
					state<=QQ;
					auxsig2<='0';  --decrementez pt a evita loop la clatire suplimentara
					internalcnt:="00000000000";
				else
					internalcnt:=internalcnt+1;			  --:)
					state<=P;
				end if;
				when QQ=> 
				if internalcnt="1010" then 	--10 seconds for water evacuation
					state<=M;
					internalcnt:="00000000000"; --reset the counter
				else
					internalcnt:=internalcnt+1;
					state<=QQ;	 
				  end if;
				
				when R=>
				if internalcnt="01001011000" then  --10 minutes
					state<=S;
					internalcnt:="00000000000";
				else
					internalcnt:=internalcnt+1;
					state<=R;
				end if;
				when S=>										-- =)
				if internalcnt="1010" then 	--10 seconds for water evacuation
					state<=T;
					internalcnt:="00000000000"; --reset the counter
				else
					  internalcnt:=internalcnt+1;
					  state<=S;	 
				end if;
				
				when T=>
				intRotation:=viteza;
				if internalcnt="01001011000" then  --10 minutes
					state<=U; 
					internalcnt:="00000000000";
				else
					internalcnt:=internalcnt+1;
					state<=T; 
				end if;
				when U=>
				if internalcnt=x"3C" then --after 60 seconds door is unlocked
					state<=V; 
					internalcnt:="00000000000";
					
				else
					internalcnt:=internalcnt+1;
					state<=U;
				end if;
				when V=>
				auxusa<='0';--washing machine door unlocked	 
				usa<='0';
				state<=STANDBY;
				
				
				when others=> state<=STANDBY;
			end case; 
			end if;
			intcnt<=internalcnt;
			internalTemp<=intTemp;
			rotatie<=intRotation;
			--timp2<=conv_std_logic_vector(timp, 12);
			auxtime<=conv_std_logic_vector(timp, 12);
			end process;
	
	
	process(CLK,reset)
	variable intern: std_logic_vector(11 downto 0):=(others=>'0');	 
	--variable ok: std_logic:='1';
	begin  
		if reset='1' then intern:=(others=>'0');	
		elsif (CLK='1' and CLK'EVENT) then
			if enable='1' then
				intern:=auxtime;
			else
				intern:=intern-1;	 
				end if;
			end if;	
			--end if;
			timp2<=intern; 
			
		end process;
			
	
				
			
end arch_cu;
