require "constants"

require "prototypes/category"
-- require "prototypes/fluid"
require "prototypes/surface-property"




require ("__base__.prototypes.entity.pipecovers")
require ("__base__.prototypes.entity.assemblerpipes")


local collector = table.deepcopy(data.raw['assembling-machine']['assembling-machine-1'])
collector.name = "pollution-collector"
collector.crafting_speed = 1
collector.minable = {mining_time = 0.2, result = "pollution-collector"}
-- collector.energy_source = {type = "void"}
collector.allowed_effects = {}
collector.effect_receiver = {uses_module_effects = false, uses_beacon_effects = false, uses_surface_effects = false}
collector.crafting_categories = {"airborne-pollutant"}
collector.ignore_output_full = false
collector.loot = {
  {
    count_max = 10,
    count_min = 2,
    item = "stone",
    probability = 1
  }
}
collector.fluid_boxes =
{
  {
    production_type = "output",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    pipe_connections = {{ flow_direction="output", direction = defines.direction.north, position = {0, -1} }},
    secondary_draw_orders = { north = -1 }
  }
}
collector.fluid_boxes_off_when_no_fluid_recipe = true
if mods['space-age'] then
  collector.surface_conditions = {
    {
      property = 'airborne-pollutant',
      min = 1,
    }
  }
end

data:extend({
  collector,
  {
    type = "item",
    name = "pollution-collector",
    icon = "__base__/graphics/icons/wooden-chest.png",
    subgroup = "storage",
    order = "a[items]-a[wooden-chest]",
    place_result = "pollution-collector",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "pollution-collector",
    ingredients = {{type = "item", name = "wood", amount = 1}},
    results = {{type="item", name="pollution-collector", amount=1}},
    surface_conditions = {
      {
        property = 'airborne-pollutant',
        min = 1,
      }
    }
  },
  {
    type = "recipe",
    name = "pollution-1",
    category = "airborne-pollutant",
    ingredients = {},
    energy_required = 1/60,
    results = {{type="fluid", name="pollution", amount=(1/60)+0.0001}},
    hidden = true,
    surface_conditions = {
      {
        property = 'airborne-pollutant',
        min = 1,
      }
    }
  },
  {
    type = "recipe",
    name = "pollution-2",
    category = "airborne-pollutant",
    ingredients = {},
    energy_required = 1/60,
    results = {{type="fluid", name="pollution", amount=(2/60)+0.0001}},
    hidden = true,
    surface_conditions = {
      {
        property = 'airborne-pollutant',
        min = 1,
      }
    }
  },
  {
    type = "recipe",
    name = "pollution_tank",
    ingredients = {{type = "item", name = "wood", amount = 1}},
    results = {{type="item", name="storage-tank", amount=1}}
  }
})
