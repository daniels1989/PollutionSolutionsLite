require "constants"

require "prototypes/category"
require "prototypes/fluid"
require "prototypes/surface-property"


local pollution = util.table.deepcopy(data.raw['resource']['crude-oil'])
pollution.name = "pollution"
pollution.flags = {
  "placeable-neutral", -- default for resource
  "placeable-off-grid", -- needs to be off center
  "not-on-map" -- to not show it on the map
}
pollution.collision_box = {{-0.49, -0.49}, {0.49, 0.49}}
pollution.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
-- pollution.selectable_in_game = false
pollution.resource_patch_search_radius = 0 -- needed to not be highlighted on the map

pollution.infinite = true
pollution.highlight = false
pollution.minimum = 1000
pollution.normal = 1000
pollution.infinite_depletion_amount = 100000
pollution.minable =
{
  mining_time = 1,
  results =
  {
    {
      type = "fluid",
      name = "crude-oil",
      amount_min = 100,
      amount_max = 100,
      probability = 1
    }
  }
}


local pollution_collector = util.table.deepcopy(data.raw['mining-drill']['pumpjack'])
pollution_collector.name = "pollution_collector"
pollution_collector.resource_searching_radius = 15.99
pollution_collector.energy_source = {type = 'void'}
pollution_collector.mining_speed = 5 / 60 -- Every 5 ticks
pollution_collector.minable = {mining_time = 0.1, result = "pollution_collector"}
pollution_collector.perceived_performance = { minimum = 0.25, performance_to_activity_rate = 2.0 }

-- This works!

data:extend({
  pollution,
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
