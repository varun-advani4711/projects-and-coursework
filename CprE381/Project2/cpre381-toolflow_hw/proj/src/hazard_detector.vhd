
library IEEE;
use IEEE.std_logic_1164.all;

entity hazard_detector is
port(   i_jump_ID          : in std_logic; 
        i_jump_EX          : in std_logic;
        i_jump_MEM         : in std_logic;
        i_jump_WB          : in std_logic;
        i_branch_ID        : in std_logic;
        i_branch_EX        : in std_logic;
        i_branch_MEM       : in std_logic;
        i_branch_WB        : in std_logic;

        i_readAddr1  	  	: in std_logic_vector(4 downto 0); 
        i_readAddr2	  	    : in std_logic_vector(4 downto 0);
        i_writeAddr_ID      : in std_logic_vector(4 downto 0);
        i_writeAddr_EX      : in std_logic_vector(4 downto 0); 
        i_writeEnable_ID    : in std_logic;
        i_writeEnable_EX    : in std_logic;

        o_stall    		: out std_logic); 
end hazard_detector;


architecture mixed of hazard_detector is
begin
    process (
        i_jump_ID,
        i_jump_EX,
        i_jump_MEM,
        i_jump_WB,
        i_branch_ID,
        i_branch_EX,
        i_branch_MEM,
        i_branch_WB,
        i_readAddr1,
        i_readAddr2,
        i_writeAddr_ID,
        i_writeAddr_EX,
        i_writeEnable_ID,
        i_writeEnable_EX)
    begin
        if ((i_writeEnable_ID = '1' AND i_readAddr1 = i_writeAddr_ID AND i_readAddr1 /= "00000")   --Data Hazard on RegRead 1
        OR  (i_writeEnable_EX = '1' AND i_readAddr1 = i_writeAddr_EX AND i_readAddr1 /= "00000")) then
            o_stall <= '1';
        elsif ((i_writeEnable_ID = '1' AND i_readAddr2 = i_writeAddr_ID AND i_readAddr2 /= "00000")  --Data Hazard on RegRead 2
           OR  (i_writeEnable_EX = '1' AND i_readAddr2 = i_writeAddr_EX AND i_readAddr2 /= "00000")) then
               o_stall <= '1';
        elsif(
            i_jump_ID   = '1' OR
            i_jump_EX   = '1' OR
            i_jump_MEM  = '1' OR
            i_jump_WB   = '1' OR
            i_branch_ID = '1' OR
            i_branch_EX = '1' OR
            i_branch_MEM= '1' OR
            i_branch_WB = '1') then
                o_stall <= '1';  
        else
            o_stall <= '0';
        end if;
    end process;
end mixed;
