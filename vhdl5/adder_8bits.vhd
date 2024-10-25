library IEEE;
use IEEE.Std_Logic_1164.all;

entity adder_8bits is
port (SW: in std_logic_vector(17 downto 0);
LEDR: out std_logic_vector(17 downto 0));
--LEDG: out std_logic_vector(7 downto 0)); 
end adder_8bits;

architecture circuito_logico of adder_8bits is 

signal Cout: std_logic_vector(8 downto 0); 
signal R,T: std_logic_vector(7 downto 0); 
signal s2: std_logic;

component fulladder is
port (A: in std_logic;
B: in std_logic;
Cin: in std_logic;
S: out std_logic; Cout: out std_logic);
end component;

component mux21 is
port (A: in std_logic;
B: in std_logic;
s: in std_logic;
F: out std_logic
);
end component;

begin


R(0) <= SW(0) or SW(17);
R(1) <= SW(1) or SW(17);
R(2) <= SW(2) and (not SW(17));
s2 <=not(SW(2));


m1: mux21 port map(SW(3),SW(0),SW(17),R(3));
m2: mux21 port map(SW(0),SW(1),SW(17),R(4));
m3: mux21 port map(SW(1),s2,SW(17),R(5));

R(6) <= SW(3) and SW(17);
R(7) <= SW(3) or SW(17);

T(0) <= SW(2);
T(1) <= SW(3);
T(5 downto 2) <= SW(3 downto 0);
T(6) <= SW(2);
T(7) <= SW(17);


Cout(0) <= '0';
cpa_1 : for j in 0 to 7 generate
cpa_j: fulladder port map( A => R(j), B => T(j), Cin => Cout(j), S =>LEDR(j+2) , Cout =>Cout(j+1));
end generate cpa_1; LEDR(10) <= Cout(8);
LEDR(1 downto 0) <= SW(1 downto 0);

end circuito_logico;