-- FxJ Timer Widget
-- Shows
-- - Flight time goal
-- - Counting up flight timer
-- - Motor run time
-- - Launch altitude
-- - Total motor run time since motor armed
-- This widget has to be placed in an upper zone as it expands lower than the upper quarter

-- Philippe Vico 2020

local options = {
    { "MotorRun", SOURCE },
    { "LaunchAlt", SOURCE }
}

local function create(zone, options)
    local widget  = { zone=zone, options=options, goal=0, overrun=0, motor_run=0, total_motor_run=0, launch_alt=0, timer }

    return widget
end

local function update(widget, options)
    if (widget == nil) then return end
    widget.options = options
end

local function background(widget)
    local timer1 = model.getTimer(0)
    widget.goal = timer1.start / 60
    widget.timer = timer1.start - timer1.value
    widget.overrun = timer1.value < 0
    widget.motor_run = getValue(widget.options.MotorRun)
    widget.total_motor_run = model.getTimer(1).value
    widget.launch_alt = getValue(widget.options.LaunchAlt)
    return    
end


function refresh(widget)

    background(widget) 

    lcd.drawText(widget.zone.x + 32, widget.zone.y, "Flight Time Goal ", TEXT_COLOR)
    lcd.drawText(widget.zone.x + 193, widget.zone.y, widget.goal.."'", RIGHT + TEXT_COLOR)
    if widget.overrun then
        lcd.setColor(CUSTOM_COLOR, 0xE120)  -- red (5-6-5 format)
    else
        lcd.setColor(CUSTOM_COLOR, WHITE)
    end
    lcd.drawTimer(widget.zone.x + 24, widget.zone.y+17, widget.timer, XXLSIZE + CUSTOM_COLOR)

    lcd.drawText(widget.zone.x + 14, widget.zone.y+90, "Motor Run", MIDSIZE + TEXT_COLOR)
    if widget.motor_run > 30 then 
        lcd.setColor(CUSTOM_COLOR, 0xE120)
    else
        lcd.setColor(CUSTOM_COLOR, 0x4BC4)
    end
    lcd.drawTimer(widget.zone.x + 210, widget.zone.y+90, widget.motor_run, RIGHT + MIDSIZE + CUSTOM_COLOR)

    lcd.drawText(widget.zone.x + 14, widget.zone.y+122, "Launch Alt.", MIDSIZE + TEXT_COLOR)
    if widget.launch_alt > 200 then 
        lcd.setColor(CUSTOM_COLOR, 0xE120)
    else
        lcd.setColor(CUSTOM_COLOR, 0x4BC4)
    end
    lcd.drawText(widget.zone.x + 210, widget.zone.y+122, widget.launch_alt, RIGHT + MIDSIZE + CUSTOM_COLOR)

    lcd.drawText(widget.zone.x + 14, widget.zone.y+156, "Tot. Motor Run", TEXT_COLOR)
    lcd.drawTimer(widget.zone.x + 210, widget.zone.y+156, widget.total_motor_run, RIGHT + TEXT_COLOR)

end

return { name="FxJReprt", options=options, create=create, update=update, background=background, refresh=refresh }
