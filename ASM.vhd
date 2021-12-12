library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; 
entity ASM is  
Port(reloj: in  std_logic; 
	  A: in  std_logic;  
	  L: out std_logic_vector(2 downto 0));  
end ASM;  

architecture Behavioral of ASM is
type estados is (s0,s1,s2,s3);
signal epresente, esiguiente:estados; 
signal segundo : std_logic; 
begin

divisor: process (reloj)
variable cuenta: std_logic_vector (27 downto 0):=X"0000000";
begin
if rising_edge (reloj) then
	if cuenta=x"48009E0" then
		cuenta:= x"0000000";
	else
	cuenta:=cuenta+1;
	end if;
end if;
segundo<= cuenta(24);
end process;

MdE1: process(segundo)
	begin
		if rising_edge(segundo) then
			epresente<=esiguiente;
		end if;
	end process;
	
MdE2: process(epresente)
	begin
	case epresente is
		when s0=>
				L<="000";
				if A='1' then
						esiguiente<=s1;
					else
						esiguiente<=s3;
					end if;
				when s1=>
						L<="111";
						if A='1' then 
								esiguiente<=s2;
						else
								esiguiente<=s0;
						end if;
				when s2=>
						L<="001";
						if A='1' then 
								esiguiente<=s3;
						else
								esiguiente<=s1;
						end if;
				when s3=>
						L<="100";
						if A='1' then 
								esiguiente<=s0;
						else
								esiguiente<=s2;
						end if;
end case;
end process;
end Behavioral;
				
					
					
						
						
	
