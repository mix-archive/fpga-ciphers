----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:42 04/22/2013 
-- Design Name: 
-- Module Name:    keccak_round_constants_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library work;
	use work.keccak_globals.all;
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ARS_keccak_round_constants_gen is
port(

    round_number: in unsigned(4 downto 0);
    round_constant_signal_out    : out std_logic_vector(63 downto 0));

end ARS_keccak_round_constants_gen;

architecture Behavioral of keccak_round_constants_gen is
 signal round_constant_signal: std_logic_vector(63 downto 0);
 
  
begin  -- Rtl




round_constants : process (round_number)
begin
	case round_number is
            when "00000" => round_constant_signal <= X"0000000000000001" ;
	    when "00001" => round_constant_signal <= X"0000000000008082" ;
	    when "00010" => round_constant_signal <= X"800000000000808A" ;
	    when "00011" => round_constant_signal <= X"8000000080008000" ;
	    when "00100" => round_constant_signal <= X"000000000000808B" ;
	    when "00101" => round_constant_signal <= X"0000000080000001" ;
	    when "00110" => round_constant_signal <= X"8000000080008081" ;
	    when "00111" => round_constant_signal <= X"8000000000008009" ;
	    when "01000" => round_constant_signal <= X"000000000000008A" ;
	    when "01001" => round_constant_signal <= X"0000000000000088" ;
	    when "01010" => round_constant_signal <= X"0000000080008009" ;
	    when "01011" => round_constant_signal <= X"000000008000000A" ;
	    when "01100" => round_constant_signal <= X"000000008000808B" ;
	    when "01101" => round_constant_signal <= X"800000000000008B" ;
	    when "01110" => round_constant_signal <= X"8000000000008089" ;
	    when "01111" => round_constant_signal <= X"8000000000008003" ;
	    when "10000" => round_constant_signal <= X"8000000000008002" ;
	    when "10001" => round_constant_signal <= X"8000000000000080" ;
	    when "10010" => round_constant_signal <= X"000000000000800A" ;
	    when "10011" => round_constant_signal <= X"800000008000000A" ;
	    when "10100" => round_constant_signal <= X"8000000080008081" ;
	    when "10101" => round_constant_signal <= X"8000000000008080" ;
	    when "10110" => round_constant_signal <= X"0000000080000001" ;
	    when "10111" => round_constant_signal <= X"8000000080008008" ;	    	    
	    when others => round_constant_signal <=(others => '0');
        end case;
end process round_constants;

round_constant_signal_out<=round_constant_signal;
end Behavioral;

