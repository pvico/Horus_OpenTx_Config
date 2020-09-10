-- Plays the launch altitude

-- Philippe Vico 2020

-- Global variable
-- This variable is set in the announ.lua mix script and used by this script
launch_altitude = 0


local METERS = 9
local startRun = 0

local function init()
end

local function run()
  local now = getTime()
  if now > startRun + 200 then    -- will only do this if the last function call was at least 2" ago 
    startRun = now
    playFile("LchAlt.wav")
    playNumber(launch_altitude, METERS, 0)
  end
end

return { run=run, init=init }