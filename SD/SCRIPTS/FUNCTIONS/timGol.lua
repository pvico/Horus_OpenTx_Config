local MINUTES = 36  -- OpenTx 2.3
local startRun = 0
local SB_id = 0

local function init()
	SB_id = getFieldInfo("sb").id
end

local function run()
  local now = getTime()
  if now > startRun + 200 then
    startRun = now

    playFile("TimGol.wav")

    local SB_value = getValue(SB_id)
    local timeGoal = 0
    local timeGoalMinutes = 0

    if SB_value == 1024 then
        timeGoal = 300
        timeGoalMinutes = 5
    elseif SB_value == -1024 then
        timeGoal = 900
        timeGoalMinutes = 15
    else        -- SB_value == 0
        timeGoal = 600
        timeGoalMinutes = 10
    end

    local timer1 = model.getTimer(0)
    timer1.start = timeGoal
    timer1.value = timeGoal
    model.setTimer(0, timer1)

    playNumber(timeGoalMinutes, MINUTES, 0)
  end
end

return {init=init, run=run}