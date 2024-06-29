

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity DNA_Extractor is
    Port ( clk : in STD_LOGIC;
           Valid : out std_logic;
           DNA_Val : out unsigned (56 downto 0));
end DNA_Extractor;

architecture Behavioral of DNA_Extractor is

signal DNA_val_int : unsigned(56 downto 0);
signal read : std_logic;
signal din : std_logic;
signal dout : std_logic;
signal shift : std_logic;
signal state : integer range 0 to 4 :=0 ;

signal cnt : integer range 0 to 57 :=0;


begin

DNA_PORT_inst : DNA_PORT
    generic map (
        SIM_DNA_VALUE => X"010F4406A704854" -- Specifies a sample 57-bit DNA value for simulation
    )
    port map (
        DOUT => dout, -- 1-bit output: DNA output data.
        CLK => CLK, -- 1-bit input: Clock input.
        DIN => DIN, -- 1-bit input: User data input pin.
        READ => READ, -- 1-bit input: Active high load DNA, active low read input.
        SHIFT => SHIFT -- 1-bit input: Active high shift enable input.
);


process(clk)
begin
    if (clk'event and clk='1') then
        case state is
            when 0 => 
                read <= '1';
                cnt <= 0;
                state <= 1;
                valid <= '0';
            when 1 =>
                read <= '0';
                shift <= '1';
                state <= 2;               
            when 2 =>
                if (cnt < 57) then
                    cnt <= cnt + 1;
                    state <= 2;
                    DNA_Val_int(56-cnt) <= dout;
                    din <= dout;
                    valid <= '0';
                else 
                    DNA_Val <= DNA_Val_int;
                    cnt <= 0;
                    valid <= '1';
                end if;  
            when others =>
                state <= 0;
        end case;
    end if;
end process;

end Behavioral;
