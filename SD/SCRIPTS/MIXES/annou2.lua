-- announ mix script

-- Automatically announces
-- - every 20m while gliding


-- TODO: make timers, altitude and logical switches inputs as settable inputs

-- Philippe Vico 2020

local altimeter_id
local last_reported_alt
local METERS = 9

local input = {}

local output = {}

local function init()
	last_reported_alt = 0
	altimeter_id = getFieldInfo("Alt").id
end

local function run()
    local sensed_alt = getValue(altimeter_id)
    if sensed_alt > 2 then
        local current_alt = math.floor(sensed_alt) 
        if (current_alt % 20) == 0 then
            if last_reported_alt ~= current_alt then
                playNumber(current_alt, METERS)
                last_reported_alt = current_alt
            end
        end                
    end     
end

return { run=run, init=init, input=input, output=output }