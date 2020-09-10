-- Plays the RSSI value

-- Philippe Vico 2020

local RSSISensorId = 0
local DB = 17
local startRun = 0

local function init()
  RSSISensorId = getFieldInfo("RSSI").id
end

local function run()
  local now = getTime()
  if now > startRun + 200 then    -- will only do this if the last function call was at least 2" ago 
    startRun = now
    playFile("RSSI.wav")
    local rssi = getValue(RSSISensorId)
    playNumber(rssi, DB, 0)
  end
end

return { run=run, init=init }