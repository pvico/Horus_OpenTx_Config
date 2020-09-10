-- ModlPict widget
-- Shows the model picture
-- Philippe Vico 2020


local bitmap
local offsetX
local offsetY

local options = {}

local function create(zone, options)

  local widget = { zone=zone, options=options }
  bitmap = Bitmap.open("/IMAGES/" .. model.getInfo().bitmap)
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

  if bitmap ~= nil then
    lcd.drawBitmap(bitmap, widget.zone.x + offsetX, widget.zone.y + offsetY)
  end

end

return { name="ModlPict", options=options, create=create, update=update,
  refresh=refresh, background=background }