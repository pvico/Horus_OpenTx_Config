-- Widget showing model picture

local bitmap
local offsetX
local offsetY

local options = {
}

local function create(zone, options)

  local widget = { zone=zone, options=options }
  bitmap = Bitmap.open("/IMAGES/" .. model.getInfo().bitmap)
  -- offsetX = (widget.zone.w - 192) / 2
  -- offsetX = (widget.zone.w - 192) / 2
  offsetX = 0
  offsetY = (widget.zone.h - 116)/2
  return widget

end

local function update(widget, newOptions)
  widget.options = newOptions
end

local function background(widget)
end

local function refresh(widget)

  -- if widget.zone.w < 180 or widget.zone.h < 145 then
  --   return
  -- end
  -- lcd.setColor(CUSTOM_COLOR, RED)
  -- lcd.drawRectangle(widget.zone.x, widget.zone.y, widget.zone.w, widget.zone.h, CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y, "X: "..tostring(widget.zone.x), SMLSIZE + CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y+18, "Y: "..tostring(widget.zone.y), SMLSIZE + CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y+36, "Width: "..tostring(widget.zone.w), SMLSIZE + CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y+54, "Height: "..tostring(widget.zone.h), SMLSIZE + CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y, model.getInfo().name, SMLSIZE + CUSTOM_COLOR)
  -- lcd.drawText(widget.zone.x, widget.zone.y + 18, model.getInfo().bitmap, SMLSIZE + CUSTOM_COLOR)


  if bitmap ~= nil then
    lcd.drawBitmap(bitmap, widget.zone.x + offsetX, widget.zone.y + offsetY)
  end


end

return { name="ModlPict", options=options, create=create, update=update,
  refresh=refresh, background=background }