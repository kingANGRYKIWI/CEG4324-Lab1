-- rca__w_add2.vhd
-- ripple carry adder with 1-bit full adder and 2-bit full adder subcomponent
-- case 2

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
     -- pragma synthesis_off
     after 6 ns
     -- pragma synthesis_on
  ;
  S <= (A xor B) xor Ci
     -- pragma synthesis_off
     after 5 ns
     -- pragma synthesis_on
  ;
end;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE,WORK;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- ADD2 is a two-level logic (ignoring inverters) circuit that adds two, 2-bit numbers
-- you must design this block
entity ADD2 is
        generic(N:integer:=2);
        port(   A,B: in std_logic_vector(N-1 downto 0);
                Ci: in std_logic;
                Co: out std_logic;
                S: out std_logic_vector(N-1 downto 0));
end;

architecture ADD2_BEHAV of ADD2 is
begin
Co <= 
((A(1) and B(1)) or 
  (A(0) and B(1) and B(0)) or 
  (A(1) and A(0) and B(0))) or 
((Ci and B(1) and B(0)) or 
  (Ci and A(0) and B(1)) or 
  (Ci and A(1) and B(0)) or 
  (Ci and A(1) and A(0)))  
   -- pragma synthesis_off
   after 12 ns
   -- pragma synthesis_on
;
S(0) <= 
(NOT(Ci) and NOT(A(0)) and B(0)) or 
(NOT(Ci) and A(0) and NOT(B(0))) or 
(Ci and NOT(A(0)) and NOT(B(0))) or 
(Ci and A(0) and B(0))
   -- pragma synthesis_off
   after 11 ns
   -- pragma synthesis_on
;
S(1) <= 
((NOT(Ci) and NOT(A(1)) and NOT(A(0)) and B(1)) or 
  (NOT(Ci) and NOT(A(1)) and B(1) and NOT(B(0))) or 
  (NOT(A(1)) and NOT(A(0)) and B(1) and NOT(B(0))) or 
  (NOT(A(1)) and A(0) and NOT(B(1)) and B(0))) or 
((NOT(Ci) and A(1) and NOT(A(0)) and NOT(B(1))) or 
  (NOT(Ci) and A(1) and NOT(B(1)) and NOT(B(0))) or 
  (A(1) and NOT(A(0)) and NOT(B(1)) and NOT(B(0))) or 
  (A(1) and A(0) and B(1) and B(0))) or 
((Ci and NOT(A(1)) and NOT(B(1)) and B(0)) or 
  (Ci and NOT(A(1)) and A(0) and NOT(B(1))) or 
  (Ci and A(1) and B(1) and B(0)) or 
  (Ci and A(1) and A(0) and B(1)))
   -- pragma synthesis_off
   after 16 ns
   -- pragma synthesis_on
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

  component ADD2
    generic(N:integer:=2);
    port(A,B:in std_logic_vector(N-1 downto 0);Ci:in std_logic;Co:out std_logic;S:out std_logic_vector(N-1 downto 0));
  end component;

  signal C:std_logic_vector(N-4 downto 0);

begin

  -- it helps to draw this out and label the signal lines
  -- instantiation area

  C(0) <= Ci;

  GI: for I in 0 to ((N/2)-1) generate
    GI:FA port map(A => A(I), B => B(I), Ci => C(I),Co => C(I+1),S => S(I));
  end generate;
--N = 12   
  GJ: for I in (N/2) to (N - 1) generate
    GJ:ADD2
      generic map(N=>2)
      port map(A(1)=> A(I),A(0)=> A(I),B(1)=> B(I),B(0)=> B(I),Ci=> C(I),Co=> C(I+1),S(1)=> S(I+1),S(0)=> S(I));
  end generate;

  Co <= C(N);

end;
