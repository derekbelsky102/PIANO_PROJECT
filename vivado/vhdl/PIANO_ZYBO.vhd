----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2020 10:22:37 PM
-- Design Name: 
-- Module Name: zybo_proj1_top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Note --      Freq    -- Divide constant
--  C4  --     261.63   -- 477774
--  C#4 --     277.18   -- 450970
--  D4  --     293.66   -- 425662
--  D#4 --     311.13   -- 401761
--  E4  --     329.63   -- 379213
--  F4  --     349.23   -- 357930
--  F#4 --     369.99   -- 337847
--  G4  --     392.00   -- 318878
--  G#4 --     415.63   -- 300987
--  A4  --     440.00   -- 284091
--  A#4 --     466.13   -- 268148
--  B4  --     493.88   -- 253098

entity PIANO_ZYBO is
    Port ( clk_in : in std_logic;
           switches : in std_logic_vector(3 downto 0);
           reset : in std_logic;
           square_wave_tone : out std_logic;
           led : out std_logic_vector(3 downto 0)
          );
end PIANO_ZYBO;

architecture PIANO_ZYBO_ARCH of PIANO_ZYBO is

signal clock_divider_constant : unsigned(18 downto 0);
signal count : unsigned(24 downto 0);
signal square_wave_tone_t : std_logic;

begin
led(3) <= reset;
led(2 downto 0) <= switches(2 downto 0);
clock_divider_constant <=   to_unsigned(238887, 19) when switches = "0000" else
                            to_unsigned(225485, 19) when switches = "0001" else
                            to_unsigned(212831, 19) when switches = "0010" else
                            to_unsigned(200881, 19) when switches = "0011" else
                            to_unsigned(189607, 19) when switches = "0100" else
                            to_unsigned(178965, 19) when switches = "0101" else
                            to_unsigned(168923, 19) when switches = "0110" else
                            to_unsigned(159429, 19) when switches = "0111" else
                            to_unsigned(150494, 19) when switches = "1000" else
                            to_unsigned(142045, 19) when switches = "1001" else
                            to_unsigned(134074, 19) when switches = "1010" else
                            to_unsigned(126549, 19) when switches = "1011" else
                            to_unsigned(1, 19);
process(clk_in)
begin 
        if reset = '1' then
            square_wave_tone_t <= '0';
            count <= (others => '0');
        elsif rising_edge(clk_in) then
            if(count = clock_divider_constant) then
                count <= (others => '0');
                square_wave_tone_t <= not square_wave_tone_t;    
        else
            count <= count + 1;
            square_wave_tone <= square_wave_tone_t;
        end if;
    end if;
end process;



end PIANO_ZYBO_ARCH;
