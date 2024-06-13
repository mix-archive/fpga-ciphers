--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:12:48 04/22/2013
-- Design Name:   
-- Module Name:   E:/LIZI/sha3/keccak_tb.vhd
-- Project Name:  sha3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sha_3
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library work;
	use work.keccak_globals.all;
library std;
	use std.textio.all;
	
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_misc.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_textio.all;
	use ieee.std_logic_unsigned."+"; 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY keccak_tb IS
END keccak_tb;
 
ARCHITECTURE behavior OF keccak_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   component ARS_keccak
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    start : in std_logic;
    din     : in  std_logic_vector(63 downto 0);
    load: in std_logic;
    buffer_full: out std_logic;
    last_block: in std_logic;    
    ready : out std_logic;
    dout    : out std_logic_vector(63 downto 0);
    dout_valid : out std_logic);
end component;



  -- signal declarations

	signal clk : std_logic;
	signal reset : std_logic;


  signal dout,din: std_logic_vector(63 downto 0);
  
 signal start,load,buffer_full,last_block,ready,dout_valid : std_logic;
  
 
 type st_type is (INIT,read_first_input,st0,st1,END_HASH1,END_HASH2,STOP);
 signal st : st_type;
   
begin  -- Rtl

-- port map

sha_3_map : ARS_keccak port map(clk,reset,start,din,load,buffer_full,last_block,ready,dout,dout_valid);


reset <= '0', '1' after 19 ns;
--start <='0', '1' after 400 ns, '0' after 420 ns;
--start <='0';

--din_val<='0', '1' after 60 ns, '0' after 400 ns, '1' after 800 ns, '0' after 1120 ns;
--din (63 downto 0) <= (others =>'0');
--din(63)<='1';
--din(62)<='0', '1' after 780 ns;


--main process
p_main: process (clk,reset)
variable counter,count_hash,num_test: integer;
variable line_in,line_out : line;
variable temp: std_logic_vector(63 downto 0);	
file filein : text open read_mode is "../test_vectors/keccak_in.txt";
file fileout : text open write_mode is "../test_vectors/keccak_out_high_speed_vhdl.txt";
begin
	if reset = '0' then                 -- asynchronous rst_n (active low)
		st <= INIT;
		counter:=0;
		din<=(others=>'0');
		load <='0';
		last_block<='0';
		count_hash:=0;
	
	elsif clk'event and clk = '1' then  -- rising clk edge
		case st is
			when INIT =>
				readline(filein,line_in);
				read(line_in,num_test);
				st<=read_first_input;
				start<='1';
				load<='0';
				
						
					
			
			when read_first_input =>
				start<='0';
					
				readline(filein,line_in);
				if(line_in(1)='.') then
					FILE_CLOSE(filein);
					FILE_CLOSE(fileout);
					assert false report "Simulation completed" severity failure;
					st <= STOP;
				else
					if(line_in(1)='-') then						
						st<= END_HASH1;
						
					else
						load<='1';
						hread(line_in,temp);
						din<=temp;	
						
						st<=st0;
						counter:=0;						
					end if;
								
				end if;
			
			when st0 =>

				if(counter<16) then
					if(counter<15) then
						readline(filein,line_in);
						hread(line_in,temp);
						din<= temp;
					end if;
					counter:=counter+1;
					st<=st0;
					load<='1';
				else
					st <= st1;
					load<='0';
				end if;
			when st1 =>
				if(buffer_full='1') then
				
					st <= st1;
				else
					st <= read_first_input;
					--din_val<='1';
				end if;
			when END_HASH1 =>
				if(ready='0') then
					st<=END_HASH1;
				else
					last_block<='1';
					st<=END_HASH2;
					counter:=0;
				end if;
			when END_HASH2 =>
				last_block<='0';
				if(dout_valid='1') then

					temp:=dout;
					hwrite(line_out,temp);
					writeline(fileout,line_out);
					if(counter<3) then
						counter:=counter+1;
					else
						st<=read_first_input;
						start<='1';
						write(line_out, string'("-"));
						writeline(fileout,line_out);
					end if;
				end if;
			when STOP =>
				null;
			end case;

	end if;
end process;

-- clock generation
clkgen : process
	begin
		clk <= '1';
		loop
				wait for 10 ns;
				clk<=not clk;
		end loop;
	end process;
END;
