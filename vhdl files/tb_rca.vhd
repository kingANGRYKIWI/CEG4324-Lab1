-- tb_rca.vhd
library IEEE,STD,WORK;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.STD_LOGIC_ARITH.ALL;
  --use IEEE.STD_LOGIC_SIGNED.ALL;
  use IEEE.STD_LOGIC_UNSIGNED.ALL;
  use IEEE.STD_LOGIC_TEXTIO.ALL;
  use STD.TEXTIO.ALL;
  use IEEE.MATH_REAL.ALL;

entity TB_RCA is
  generic (
    N:integer:= 12;     -- number of input bits for adder
    WPD: time:= 24 ns   -- Make necessary changes
  );
end ;

architecture TB of TB_RCA is

  file OUT_FILE: text is out "sim_RCA.txt";  -- simulation output file name

  component RCA
    generic(N:integer);
    port(A,B: in std_logic_vector(N-1 downto 0);
         Ci: in std_logic;
         Co: out std_logic;
         S: out std_logic_vector(N-1 downto 0));
  end component ;

  signal A,B: std_logic_vector(N-1 downto 0);
  signal S: std_logic_vector(N downto 0);
  signal Ci: std_logic;

begin

  CUT:RCA                           -- Circuit Under Test
    generic map(N=>N) port map (A=>A,B=>B,Ci=>Ci,Co=>S(N),S=>S(N-1 downto 0));

  test_VECTOR : process
    variable I,J : integer;
  begin
    -- exhuastive test for unsigned numbers
    I := 0; WH_LOOPI : while I < 2**N loop      -- 0 to 2^N-1 => loop 2^N times
      J := 0; WH_LOOPJ : while J < 2**N loop    -- 0 to 2^N-1 => loop 2^N times
        ----------------------------------
        A <= conv_std_logic_vector(I,N);
        B <= conv_std_logic_vector(J,N);
        Ci <= '0';
        wait for WPD;  -- worst case propgation delay for 12 bit RCA
        ----------------------------------
        A <= conv_std_logic_vector(0,N);
        B <= conv_std_logic_vector(0,N);
        Ci <= '0';
        wait for 200 ns;  -- clear out inputs
        ----------------------------------
        A <= conv_std_logic_vector(I,N);
        B <= conv_std_logic_vector(J,N);
        Ci <= '1';
        wait for WPD;  -- worst case propgation delay for 12 bit RCA
        ----------------------------------
        A <= conv_std_logic_vector(0,N);
        B <= conv_std_logic_vector(0,N);
        Ci <= '0';
        wait for 200 ns;  -- clear out inputs
        ----------------------------------
        J := J+1;
      end loop WH_LOOPJ;
      I := I+1;
    end loop WH_LOOPI;
  end process;

  test_ADDER : process
    variable OUTLINE : LINE;
    variable BLANK3 : string(1 to 3):= "   ";
    variable I,J : integer;
    variable S_INTEGER: integer;
    variable minterm: std_logic_vector(2*N downto 0);
    variable Cin: integer;
  begin
    -- exhuastive test for unsigned numbers
    I := 0; WH_LOOPI : while I < 2**N loop      -- 0 to 2^N-1 => loop 2^N times
      J := 0; WH_LOOPJ : while J < 2**N loop    -- 0 to 2^N-1 => loop 2^N times
        Cin := 0; WH_LOOPC : while Cin < 2 loop -- 0 to 1
          ----------------------------------
          wait for WPD;
          S_INTEGER := conv_integer(I) + conv_integer(J) + conv_integer(Cin);
          if conv_integer(S) /= S_INTEGER then    -- check to see if HW output is correct
            WRITE(OUTLINE, I);
            WRITE(OUTLINE, '+');
            WRITE(OUTLINE, J);
            WRITE(OUTLINE, '=');
            WRITE(OUTLINE, S_INTEGER);
            WRITE(OUTLINE, '=');
            WRITE(OUTLINE, conv_std_logic_vector(S_INTEGER,N+1));
            WRITE(OUTLINE, BLANK3);
            WRITE(OUTLINE, '=');
            WRITE(OUTLINE, S);
            WRITE(OUTLINE, '=');
            WRITE(OUTLINE, conv_integer(S));
            WRITELINE(OUT_FILE, OUTLINE);
            assert (false) report "error -- answer wrong!  :(" severity FAILURE;
          end if;
          ----------------------------------
          wait for 200 ns; -- clearing out inputs
          ----------------------------------
          Cin := Cin + 1;
        end loop WH_LOOPC;
        J := J+1;
      end loop WH_LOOPJ;
      I := I+1;
    end loop WH_LOOPI;
    assert (false) report "sim done -- no errors!  :)" severity FAILURE;
  end process;

end ;

configuration CFG_TB of TB_RCA is
for TB
end for;
end ;
