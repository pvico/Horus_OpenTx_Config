local SECONDS = 37  -- OpenTx 2.3
local startRun = 0

local function init()

end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    playFile("Motor.wav")
    local seconds = 30 - model.getTimer(2).value -- Timer 3
    playNumber(seconds, SECONDS, 0)
  end
end

return {init=init, run=run}