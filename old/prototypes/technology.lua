require "constants"

data:extend({
  {
    type = "technology",
    name = "pollution-controls",
    icon = GRAPHICS.."icons/pollution-collection.png",
    icon_size = 128,
    prerequisites = {"fluid-handling"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "pollutioncollector"
      },
      {
        type = "unlock-recipe",
        recipe = "dump-site"
      },
      {
        type = "unlock-recipe",
        recipe = "blue-xenomass"
      },
      {
        type = "unlock-recipe",
        recipe = "red-xenomass"
      },
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "incineration",
    icon = GRAPHICS.."icons/incineration.png",
    icon_size = 128,
    prerequisites = {"pollution-controls", "flammables","military-2"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "liquify-pollution"
      },
      {
        type = "unlock-recipe",
        recipe = "toxic-turret"
      },
      {
        type = "unlock-recipe",
        recipe = "hev-armor"
      },
      {
        type = "unlock-recipe",
        recipe = "toxic-waste-treatment"
      },
      {
        type = "unlock-recipe",
        recipe = "toxic-incinerator"
      },
      {
        type = "unlock-recipe",
        recipe = "low-heat-exchanger"
      },
      {
        type = "unlock-recipe",
        recipe = "heat-pipe"
      },
    },
    order = "c-a"
  },
})
