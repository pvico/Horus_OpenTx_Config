-- Plays the motor run time
-- Also sets the motor_run global variable

-- Philippe Vico 2020

-- Global variable
-- This variable is set in this script and used by the batcap.lua mix script
motor_run = 0

local SECONDS = 37  -- OpenTx 2.3
local startRun = 0

local function init()

end

local function run()
  local now = getTime()
  if now > startRun + 200 then    -- will only do this if the last function call was at least 2" ago 
    startRun = now
    motor_run = 30 - model.getTimer(2).value -- Timer 3
    playFile("Motor.wav")
    playNumber(motor_run, SECONDS, 0)
  end
end

return {init=init, run=run}