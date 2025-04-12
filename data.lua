require "constants"

require "prototypes/category"
require "prototypes/fluid"
require "prototypes/surface-property"
require "prototypes/pollutant"




local pollution_collector = util.table.deepcopy(data.raw['mining-drill']['pumpjack'])
pollution_collector.name = "pollution_collector"
pollution_collector.resource_categories = {POLLUTANT}
pollution_collector.resource_searching_radius = 15.99
pollution_collector.energy_source = {type = 'void'}
pollution_collector.mining_speed = 1
pollution_collector.minable = {mining_time = 0.1, result = "pollution_collector"}
pollution_collector.perceived_performance = { minimum = 0.25, performance_to_activity_rate = 2.0 }

-- This works!

data:extend({
  pollution_collector,
  {
    type = "item",
    name = "pollution_collector",
    icon = "__base__/graphics/icons/wooden-chest.png",
    subgroup = "storage",
    order = "a[items]-a[wooden-chest]",
    place_result = "pollution_collector",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "pollution_collector",
    ingredients = {{type = "item", name = "wood", amount = 1}},
    results = {{type="item", name="pollution_collector", amount=1}}
  },
  {
    type = "recipe",
    name = "pollution_tank",
    ingredients = {{type = "item", name = "wood", amount = 1}},
    results = {{type="item", name="storage-tank", amount=1}}
  }
})
