require "constants"
require "util"

------------
-- Entity --
------------

local syntheticpollutioncollector = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"])
syntheticpollutioncollector.name = "syntheticpollutioncollector"
syntheticpollutioncollector.order = "z"
syntheticpollutioncollector.minable.result = "syntheticpollutioncollector"
syntheticpollutioncollector.crafting_categories = {"pollution"}
syntheticpollutioncollector.icon = GRAPHICS.."icons/synthetic-pollution-collector.png"
syntheticpollutioncollector.icon_size = 64
syntheticpollutioncollector.pictures.picture.sheets[1].filename = GRAPHICS.."entity/synthetic-pollution-collector/synthetic-pollution-collector.png"
syntheticpollutioncollector.pictures.picture.sheets[1].hr_version.filename = GRAPHICS.."entity/synthetic-pollution-collector/hr-synthetic-pollution-collector.png"
syntheticpollutioncollector.fluid_box.filter = "polluted-air"
for i=1, #syntheticpollutioncollector.fluid_box.pipe_connections, 1 do
  syntheticpollutioncollector.fluid_box.pipe_connections[i].type = "input-output"
end
syntheticpollutioncollector.fluid_box.base_area = 10


----------
-- Item --
----------

local syntheticpollutioncollector_item = util.table.deepcopy(data.raw['item']['steam-turbine'])
syntheticpollutioncollector_item.name = "syntheticpollutioncollector"
syntheticpollutioncollector_item.place_result = "syntheticpollutioncollector"
syntheticpollutioncollector_item.stack_size = 50
syntheticpollutioncollector_item.icon = GRAPHICS.."icons/synthetic-pollution-collector.png"
syntheticpollutioncollector_item.icon_size = 64



------------
-- Extend --
------------

data:extend({
  syntheticpollutioncollector,
  syntheticpollutioncollector_item,
  {
    type = "recipe",
    name = "syntheticpollutioncollector",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {name="stone",			amount=20},
      {name="coal",			amount=10},
      {name="electronic-circuit",	amount=5},
      {name="iron-gear-wheel",	amount=50},
      {name="pipe", 				amount=50},
    },
    result= "syntheticpollutioncollector"
  },
})
