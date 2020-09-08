local timer1_id
local timer1_value
local timer3_id
local timer3_value
local altimeter_id
local last_reported_alt
local METERS = 9
local MINUTES = 36
local SECONDS = 37
local NO_UNIT = 0
local motor_running_ls_id
local gliding_ls_id


local input = {}

local output = {}

local function init()
	last_reported_alt = 0
    timer1_value = 0
    timer3_value = 0
    timer1_id = getFieldInfo("timer1").id
    timer3_id = getFieldInfo("timer3").id
	altimeter_id = getFieldInfo("Alt").id
	motor_running_ls_id = getFieldInfo("ls7").id
	gliding_ls_id = getFieldInfo("ls8").id
end

local function run()
    local sensed_alt = getValue(altimeter_id)
    local gliding = getValue(gliding_ls_id) > 0
    local motor_running = getValue(motor_running_ls_id) > 0
    if motor_running then
        if sensed_alt > 2 then
            local alt_double = math.floor(sensed_alt/2)     -- we need this if we climb fast, we will detect 50m between 50 & 52m
            if (alt_double % 25) == 0 then
                local current_alt = alt_double*2
                if last_reported_alt ~= current_alt then
                    playNumber(current_alt, METERS)
                    last_reported_alt = current_alt
                end
            end
        end
        local val =  30 - getValue(timer3_id)
		if val < 30 and val ~= timer3_value then
			timer3_value = val
			if val >= 18 then
				if (val % 2) == 0 then
					playNumber(val, NO_UNIT)
				end
			elseif val ~= 0 and (val % 5) == 0 then
				playNumber(val, SECONDS)
			end
		end
    elseif gliding then
        if sensed_alt > 2 then
            local current_alt = math.floor(sensed_alt) 
            if (current_alt % 20) == 0 then
                if last_reported_alt ~= current_alt then
                    playNumber(current_alt, METERS)
                    last_reported_alt = current_alt
                end
            end                
        end
		local timer1_val = getValue(timer1_id)
        if timer1_val == 90 then
            if timer1_val ~= timer1_value then
                playNumber(1, MINUTES)
                playNumber(30, SECONDS)
                timer1_value = timer1_val
            end
        elseif timer1_val > 59 then
            if (timer1_val % 60) == 0 then
                if timer1_val ~= timer1_value then
                    playNumber(timer1_val/60, MINUTES)
                    timer1_value = timer1_val
                end
            end
		elseif timer1_val > 10 then
            if (timer1_val % 10) == 0 or timer1_val == 15 then
                if timer1_val ~= timer1_value then
                    playNumber(timer1_val, SECONDS)
                    timer1_value = timer1_val
                end
            end
        elseif timer1_val > 0 and timer1_val <= 10 then
            if timer1_val ~= timer1_value then
                playNumber(timer1_val, NO_UNIT)
                timer1_value = timer1_val
            end
        end        
    end
end

return { run=run, init=init, input=input, output=output }