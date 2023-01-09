require "constants"

local toxicsludge = {
  type = "fluid",
  name = "toxic-sludge",
  base_color = {r=0.333, g=0.063, b=0.451},
  flow_color = {r=0.744, g=0.275, b=0.867},
  icon = GRAPHICS.."icons/fluid/toxicsludge.png",
  icon_size = 64,
  order = "a[fluid]-b[toxicsludge]",
  default_temperature = 15,
}

local pollution = {
  type = "fluid",
  name = "polluted-air",
  auto_barrel = false,
  base_color = {r=0.500, g=0.000, b=0.000},
  flow_color = {r=1.00, g=0.000, b=0.000},
  icon = GRAPHICS.."icons/fluid/pollution.png",
  icon_size = 64,
  order = "a[fluid]-b[pollution]",
  default_temperature = 15,
  gas_temperature = 15,
}

data:extend({
  toxicsludge,
  pollution,
})