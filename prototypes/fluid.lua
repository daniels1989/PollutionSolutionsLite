data:extend({
  {
    type = "fluid",
    name = "toxic-sludge",
    subgroup = "fluid",
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
