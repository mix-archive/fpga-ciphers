----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:01 05/03/2013 
-- Design Name: 
-- Module Name:    modmult - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ARS_modmult is
	Generic (MPWID: integer := 1024);
    Port ( mpand : in std_logic_vector(MPWID-1 downto 0);
           mplier : in std_logic_vector(MPWID-1 downto 0);
           modulus : in std_logic_vector(MPWID-1 downto 0);
           product : out std_logic_vector(MPWID-1 downto 0);
           clk : in std_logic;
			  ds : in std_logic;
			  reset : in std_logic;
			  ready : out std_logic);
end ARS_modmult;

architecture Behavioral of ARS_modmult is
signal mpreg: std_logic_vector(MPWID-1 downto 0);
signal mcreg, mcreg1, mcreg2: std_logic_vector(MPWID+1 downto 0);
signal modreg1, modreg2: std_logic_vector(MPWID+1 downto 0);
signal prodreg, prodreg1, prodreg2, prodreg3, prodreg4: std_logic_vector(MPWID+1 downto 0);

--signal count: integer;
signal modstate: std_logic_vector(1 downto 0);
signal first: std_logic;

begin

	-- final result...
	product <= prodreg4(MPWID-1 downto 0);

	-- add shifted value if place bit is '1', copy original if place bit is '0'
	with mpreg(0) select
		prodreg1 <= prodreg + mcreg when '1',
						prodreg when others;

	-- subtract modulus and subtract modulus * 2.
	prodreg2 <= prodreg1 - modreg1;
	prodreg3 <= prodreg1 - modreg2;

	-- negative results mean that we subtracted too much...
	modstate <= prodreg3(mpwid+1) & prodreg2(mpwid+1);
	
	-- select the correct modular result and copy it....
	with modstate select
		prodreg4 <= prodreg1 when "11",
						prodreg2 when "10",
						prodreg3 when others;

	-- meanwhile, subtract the modulus from the shifted multiplicand...
	mcreg1 <= mcreg - modreg1;
	
	-- select the correct modular value and copy it.
	with mcreg1(MPWID) select
		mcreg2 <= mcreg when '1',
					 mcreg1 when others;

	ready <= first;

	combine: process (clk, first, ds, mpreg, reset) is

	begin
	
		if reset = '1' then
			first <= '1';
		elsif rising_edge(clk) then
			if first = '1' then
			-- First time through, set up registers to start multiplication procedure
			-- Input values are sampled only once
				if ds = '1' then
					mpreg <= mplier;
					mcreg <= "00" & mpand;
					modreg1 <= "00" & modulus;
					modreg2 <= '0' & modulus & '0';
					prodreg <= (others => '0');
					first <= '0';
				end if;
			else
			-- when all bits have been shifted out of the multiplicand, operation is over
			-- Note: this leads to at least one waste cycle per multiplication
				if mpreg = 0 then
					first <= '1';
				else
				-- shift the multiplicand left one bit
					mcreg <= mcreg2(MPWID downto 0) & '0';
				-- shift the multiplier right one bit
					mpreg <= '0' & mpreg(MPWID-1 downto 1);
				-- copy intermediate product
					prodreg <= prodreg4;
				end if;
			end if;
		end if;

	end process combine;
end Behavioral;

