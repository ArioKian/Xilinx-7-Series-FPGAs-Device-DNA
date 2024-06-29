
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DNA_Detector is
    Port ( clk : in STD_LOGIC;
           enable : out STD_LOGIC);
end DNA_Detector;

architecture Behavioral of DNA_Detector is

component DNA_Extractor
    Port ( clk : in STD_LOGIC;
         valid : out std_logic;
         DNA_Val : out unsigned (56 downto 0));
end component;

signal dnaVal : unsigned(56 downto 0); 
signal dnaVal_t : unsigned(56 downto 0);
signal if_valid : std_logic:='0';

type ourDNAs is array ( 0 to 3 ) of unsigned(56 downto 0);		-- your previously extracted and valid FPGA DNAs 
																-- you need to change the size and values of this array according to your own devices
signal DNAs : ourDNAs := (
                          '0' & x"78F4406A70485C",   			-- replace these values with DNAs extracted in a previous stage 
                          '0' & x"00000000000000",   
                          '0' & x"5CF4406A70485C",        
                          '0' & x"2CF4406A704854"                                   
                          ); 

begin

devDNA : DNA_Extractor port map( clk => clk , valid => if_valid , DNA_val => dnaVal );

process(clk)
begin

    if(clk'event and clk='1')then
    
        if( if_valid = '1') then
            dnaVal_t <= dnaVal;
        end if;
        

        if (  dnaVal_t = DNAs(0) or
              dnaVal_t = DNAs(1) or
              dnaVal_t = DNAs(2) or
              dnaVal_t = DNAs(3) 
        ) then
            enable <= '1';
        else
            enable <= '0';
        end if;
        
    end if;
    
end process;

end Behavioral;
