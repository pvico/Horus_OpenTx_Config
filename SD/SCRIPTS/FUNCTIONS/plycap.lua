capa = 0

local PERCENT = 13  -- OpenTx 2.3
local startRun = 0

local function init()

end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    playFile("Batery.wav")
    playNumber(capa, PERCENT, 0)
  end
end

return {init=init, run=run}