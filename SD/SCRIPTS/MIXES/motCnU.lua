local timer3_id = 0
local timer3_value = 0
local SECONDS = 37
local NO_UNIT = 0
local motor_running_ls_id


local input = {}

local output = {}

local function init()
	timer3_value = 0
	timer3_id = getFieldInfo("timer3").id
	motor_running_ls_id = getFieldInfo("ls7").id
end

local function run()
	local motor_running = getValue(motor_running_ls_id)
	if motor_running > 0 then			-- needed to avoid calling seconds when starting motor
		local val =  30 - getValue(timer3_id)
		if val < 30 and val ~= timer3_value then
			timer3_value = val
			if val >= 18 then
				if val%2 == 0 then
					playNumber(val, NO_UNIT)
				end
			elseif val ~= 0 and val % 5 == 0 then
				playNumber(val, SECONDS)
			end
		end
	end
end

return { run=run, init=init, input=input, output=output }