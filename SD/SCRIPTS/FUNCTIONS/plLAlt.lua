-- Plays get altitude and plays rounded integer value 

local MaxAltitudeSensorId = 0
local METERS = 9
local startRun = 0

local function init()
  MaxAltitudeSensorId = getFieldInfo("Alt+").id
end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    playFile("LchAlt.wav")
    local launchAltitude = getValue(MaxAltitudeSensorId)
    -- local roundedAltitude = math.floor(altitude)
    playNumber(launchAltitude, METERS, 0)
  end
end

return { run=run, init=init }