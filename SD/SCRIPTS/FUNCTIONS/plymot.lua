-- global variable
motor_run = 0

local SECONDS = 37  -- OpenTx 2.3
local startRun = 0

local function init()

end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    motor_run = 30 - model.getTimer(2).value -- Timer 3
    playFile("Motor.wav")
    playNumber(motor_run, SECONDS, 0)
  end
end

return {init=init, run=run}