print("Check state of DIO8 & DIO9 to toggle relays appropriately") 
local mbRead=MB.R			--local functions for faster processing
local mbWrite=MB.W

local FIO4 = 2004 --toggles the 'everything' relay 
local FIO5 = 2005 --toggles the cradlepoint relay 

local DIO8 = 2008 -- If HIGH, AE engineer wants to toggle 'everything' relay 
local DIO9 = 2009 -- If HIGH, AE engineer wants to toggle 'cradlepoint' relay 

function sleep(time_ms)
    LJ.IntervalConfig(7, time_ms)  
    while( LJ.CheckInterval(7) ~= 1 )do
    end
end

LJ.IntervalConfig(0, 10000)                   -- 15 seconds per interval
local checkInterval=LJ.CheckInterval

while true do
  if checkInterval(0) then               --interval completed
    DIO8_state = mbRead(2008, 0)               --reads DIO8 state. Address is 2008, type is 0
    DIO9_state = mbRead(2009, 0)               --reads DIO9 state. Address is 2009, type is 0
    print("DIO8 State: ", DIO9_state)         -- prints state of DIO8
    print("DIO9 State: ", DIO10_state)         -- prints state of DIO9
    
    if DIO8_state == 1 then --if DIO8 is high 
      mbWrite(FIO4, 0, 1)                    --write 1 to FIO4. Address is 2004, type is 0, value is 1 (output HIGH)
      print(1, "FIO4 high")
      wait(10)                            
      mbWrite(FIO4, 0, 0)                    --write 0 to FIO4. Address is 2004, type is 0, value is 0 (output LOW)
      print(0, "FIO4 low")
      mbWrite(DIO8, 0, 0)
    end 
    
    if DIO9_state == 1 then -- if DIO9 is high 
      mbWrite(FIO5, 0, 1)                    --write 1 to FIO5. Address is 2005, type is 0, value is 1 (output HIGH)
      print(1, "FIO5 high")
      wait(10)                            
      mbWrite(FIO5, 0, 0)                    --write 0 to FIO5. Address is 2005, type is 0, value is 0 (output LOW)
      print(0, "FIO5 low")
      mbWrite(DIO9, 0, 0)
    end
  end 
end 
