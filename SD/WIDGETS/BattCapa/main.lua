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
  { "CapaScript", SOURCE }
}

local function create(zone, options)

  local widget = { zone=zone, options=options, capacity=0 }

  return widget

end

local function update(widget, newOptions)
  widget.options = newOptions
end

local function background(widget)

    widget.capacity = round(getValue(widget.options.CapaScript) / 10.24)

end

local function refresh(widget)

  --background is not called automatically in display mode, so do it here if you need it.
  background(widget) 

  if widget.capacity >= 50 then 
    lcd.setColor(CUSTOM_COLOR, 0x4BC4)  -- green (5-6-5 format)
  elseif widget.capacity >= 25 then
    lcd.setColor(CUSTOM_COLOR, 0xFE20)  -- amber (5-6-5 format)
  else
    lcd.setColor(CUSTOM_COLOR, 0xE120)  -- red (5-6-5 format)
  end

  lcd.drawText(widget.zone.x, widget.zone.y, "Rx Battery", LEFT + CUSTOM_COLOR)
  lcd.drawText(widget.zone.x, widget.zone.y + 18, widget.capacity .. "%", LEFT + DBLSIZE + CUSTOM_COLOR)
  lcd.setColor(CUSTOM_COLOR, WHITE) 

end

return { name="BattCapa", options=options, create=create, update=update,
  refresh=refresh, background=background }