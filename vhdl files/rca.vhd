-- rca.vhd
-- Ripple Carry Adder with full adder subcomponent

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE,WORK;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity FA is
        port(   A,B,Ci: in std_logic;
                Co,S: out std_logic);
end;

architecture FA_BEHAV of FA is
begin
  Co <= (A and B) or (A and Ci) or (B and Ci)
     -- synthesis_off
     after 8 ns
     -- synthesis_on
  ;
  S <= (A and B and Ci) or (A and not B and not Ci) or (not A and B and not Ci) or (not A and not B and Ci)
     -- synthesis_off
     after 12 ns
     -- synthesis_on
  ;
end;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE,WORK;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity RCA is
        generic(N:integer:=16);
        port(   A,B: in std_logic_vector(N-1 downto 0);
		Ci: in std_logic;
		Co: out std_logic;
                S: out std_logic_vector(N-1 downto 0));
end;

architecture RCA_STRUCT of RCA is

  -- declarative area

  component FA
    port(A,B,Ci:in std_logic;Co,S:out std_logic);
  end component;

  signal C:std_logic_vector(N downto 0);

begin

  -- instantiation area

  C(0) <= Ci;

  GI: for I in 0 to N-1 generate
    GI:FA port map(A => A(I),B => B(I), Ci => C(I),Co => C(I+1),S => S(I));
  end generate;

  Co <= C(N);

end;
