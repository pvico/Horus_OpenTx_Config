-- BattMode widget

-- Shows
-- - Flight mode
-- - Motor armed/disarmed
-- - Rx battery remaining capacity

-- TODO: make "ls6" (armed) logical switch input as settable input

-- Philippe Vico 2020

local function round(num)
    local under = math.floor(num)
    local upper = math.floor(num) + 1
    local underV = -(under - num)
    local upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end

local options = {
  { "CapaScrpt", SOURCE }
}

local function create(zone, options)
  local widget = { zone=zone, options=options, capacity=0, flight_mode={} }

  return widget
end

local function update(wgt, options)
  if (wgt == nil) then return end
  wgt.options = options
end


local function background(widget)
  widget.capacity = round(getValue(widget.options.CapaScrpt) / 10.24)
  widget.flight_mode = {getFlightMode()}
end

local function refresh(widget)

  --background is not called automatically in display mode, so do it here if you need it.
  background(widget) 

  if widget.flight_mode[1] ~= 1 then
    lcd.drawText(widget.zone.x, widget.zone.y, widget.flight_mode[2].." mode", LEFT + MIDSIZE + TEXT_COLOR)
  else    -- Calibrate mode
    lcd.setColor(CUSTOM_COLOR, 0xE120)  -- red (5-6-5 format)
    lcd.drawText(widget.zone.x, widget.zone.y, "CALIBRATION", LEFT + DBLSIZE + CUSTOM_COLOR)
  end


  if widget.capacity >= 50 then 
    lcd.setColor(CUSTOM_COLOR, 0x4BC4)  -- green (5-6-5 format)
  elseif widget.capacity >= 25 then
    lcd.setColor(CUSTOM_COLOR, 0xFE20)  -- amber (5-6-5 format)
  else
    lcd.setColor(CUSTOM_COLOR, 0xE120)  -- red (5-6-5 format)
  end

  lcd.drawRectangle(widget.zone.x, widget.zone.y+64, 140, 32, CUSTOM_COLOR, 3)
  lcd.drawRectangle(widget.zone.x+137, widget.zone.y+74, 10, 12, CUSTOM_COLOR, 3)
  lcd.drawFilledRectangle(widget.zone.x, widget.zone.y+64, 140 * widget.capacity / 100, 32, CUSTOM_COLOR, 3)
  lcd.drawText(widget.zone.x + 160, widget.zone.y + 64, "" .. widget.capacity .. "%", LEFT + DBLSIZE + CUSTOM_COLOR)
  lcd.setColor(CUSTOM_COLOR, WHITE) 
end

return { name="BattMod2", options=options, create=create, update=update, refresh=refresh, background=background }