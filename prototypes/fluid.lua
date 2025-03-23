for _, pollutant in pairs(data.raw['airborne-pollutant']) do

  data:extend({
    {
      type = "fluid",
      name = pollutant.name,
      subgroup = "fluid",
      localised_name = {"airborne-pollutant-name." .. pollutant.name},
      base_color = {
        r = pollutant.chart_color.r,
        g = pollutant.chart_color.g,
        b = pollutant.chart_color.b,
      },
      flow_color = {
        r = pollutant.chart_color.r,
        g = pollutant.chart_color.g,
        b = pollutant.chart_color.b,
      },
      -- icon = GRAPHICS .. "icons/fluid/polluted-air.png",
      -- icon_size = 64,
      icons = {
        {
          icon = "__base__/graphics/icons/fluid/steam.png",
          icon_size = 64,
          tint = pollutant.chart_color
        }
      },
      order = "a[fluid]-b[airborne-pollutant]-a[" .. pollutant.name .. "]",
      default_temperature = 15,
      gas_temperature = -195,
    }
  })
end


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

-- this should rerun the auto barreling functions
require ("__base__.data-updates")
