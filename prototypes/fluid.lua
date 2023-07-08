data:extend({
  {
    type = "fluid",
    name = "polluted-air",
    base_color = {
      r = 0.500,
      g = 0.185,
      b = 0.185,
    },
    flow_color = {
      r = 0.760,
      g = 0.282,
      b = 0.282,
    },
    icon = GRAPHICS .. "icons/fluid/polluted-air.png",
    icon_size = 64,
    order = "a[fluid]-b[pollution]",
    default_temperature = 15,
    gas_temperature = -195,
  },
  {
    type = "fluid",
    name = "toxic-sludge",
    base_color = {
      r = 0.333,
      g = 0.055,
      b = 0.451,
    },
    flow_color = {
      r = 0.744,
      g = 0.275,
      b = 0.867,
    },
    icon = GRAPHICS .. "icons/fluid/toxic-sludge.png",
    icon_size = 64,
    order = "a[fluid]-b[toxicsludge]",
    default_temperature = 15,
  },
})
