-- batcap mix script

-- The "cellsens" input must be set to the telemetry source measuring lowest rx cell voltage 
-- The "motrunng" input must be set to the motor running logical switch

-- Computes the remaining battery capacity based on cell voltage

-- Exports the "capa" script value (battery capacity in %)
-- Exports the "motr" script value (motor run time in %)

-- TODO: the motor run export should be moved to another mix script

-- Philippe Vico 2020

-- Global variables
-- This variable is set in this script and used by plycap.lua function script
capa = 0
-- This variable is set in the plymot.lua function script and used by this script to export "motr"
motor_run = 0

local capacity = 0
local capacities = {}
local index = 1

local input = {
  { "cellsens", SOURCE },
  { "motrunng", SOURCE }
}

local output = {"capa", "motr"}

local function init()
	for i=1,10 do
		capacities[i] = 0
	end
end

local function run(cellsens, motrunng)
	-- if cellsens > 3 then playNumber(cellsens, 16, PREC2)
	-- end

	if motrunng < 0 then
    local capacitysum = 0
    if cellsens >= 4.15 then capacity = 95
    elseif cellsens >= 4.105then capacity = 90
    elseif cellsens >= 4.06 then capacity = 85
    elseif cellsens >= 4.02 then capacity = 80
    elseif cellsens >= 3.98 then capacity = 75
    elseif cellsens >= 3.94 then capacity = 70
    elseif cellsens >= 3.905 then capacity = 65
    elseif cellsens >= 3.87 then capacity = 60
    elseif cellsens >= 3.85 then capacity = 55
    elseif cellsens >= 3.83 then capacity = 50
    elseif cellsens >= 3.82 then capacity = 45
    elseif cellsens >= 3.80 then capacity = 40
    elseif cellsens >= 3.79 then capacity = 35
    elseif cellsens >= 3.77 then capacity = 30
    elseif cellsens >= 3.75 then capacity = 25
    elseif cellsens >= 3.73 then capacity = 20
    elseif cellsens >= 3.71 then capacity = 15
    elseif cellsens >= 3.69 then capacity = 10
    elseif cellsens >= 3.61 then capacity = 5
    else capacity = 0
    end

    capacities[index] = capacity

    index = index + 1
    if index > 10
    then index = 1
    end

    capacitysum = 0
    for i=1,10 do
      capacitysum = capacitysum + capacities[i]
    end

    capa = capacitysum / 10.0
  end

  return 10.24 * capa, motor_run
end

return { run=run, init=init, input=input, output=output }