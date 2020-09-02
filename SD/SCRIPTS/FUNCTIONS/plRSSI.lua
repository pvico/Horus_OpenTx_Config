local RSSISensorId = 0
local DB = 17
local startRun = 0

local function init()
  RSSISensorId = getFieldInfo("RSSI").id
end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now
    playFile("RSSI.wav")
    local rssi = getValue(RSSISensorId)
    -- local roundedAltitude = math.floor(altitude)
    playNumber(rssi, DB, 0)
  end
end

return { run=run, init=init }