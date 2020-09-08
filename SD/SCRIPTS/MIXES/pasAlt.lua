local altimeter_id
local last_reported_alt
local METERS = 9
local motor_running_ls_id
local gliding_ls_id


local input = {}

local output = {}

local function init()
	last_reported_alt = 0
	altimeter_id = getFieldInfo("Alt").id
	motor_running_ls_id = getFieldInfo("ls7").id
	gliding_ls_id = getFieldInfo("ls8").id
end

local function run()
    local sensed_alt = getValue(altimeter_id)
    if sensed_alt > 2 then
        local motor_running = getValue(motor_running_ls_id)
        if motor_running > 0 then
            local alt_double = math.floor(sensed_alt/2)     -- we need this if we climb fast, we will detect 50m between 50 & 52m
            if alt_double % 25 == 0 then
                local current_alt = alt_double*2
                if last_reported_alt ~= current_alt then
                    playNumber(current_alt, METERS)
                    last_reported_alt = current_alt
                end
            end
        elseif getValue(gliding_ls_id) > 0 then
            local current_alt = math.floor(sensed_alt) 
            if current_alt % 20 == 0 then
                if last_reported_alt ~= current_alt then
                    playNumber(current_alt, METERS)
                    last_reported_alt = current_alt
                end
            end                
        end
    end
end

return { run=run, init=init, input=input, output=output }