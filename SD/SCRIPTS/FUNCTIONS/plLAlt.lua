launch_altitude = 0

-- Plays get altitude and plays rounded integer value 

local METERS = 9
local startRun = 0

local function init()
end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    playFile("LchAlt.wav")
    playNumber(launch_altitude, METERS, 0)
  end
end

return { run=run, init=init }