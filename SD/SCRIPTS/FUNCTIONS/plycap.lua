-- Plays the remaining battery capacity

-- Philippe Vico 2020

-- Global variable
-- This variable is set in the batcap.lua mix script and used by this script
capa = 0

local PERCENT = 13  -- OpenTx 2.3
local startRun = 0

local function init()
end

local function run()
  local now = getTime()
  if now > startRun + 200 then    -- will only do this if the last function call was at least 2" ago 
    startRun = now
    playFile("Batery.wav")
    playNumber(capa, PERCENT, 0)
  end
end

return {init=init, run=run}