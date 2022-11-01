require "constants"
require "util"

------------
-- Entity --
------------

local pollutioncollector = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"])
pollutioncollector.name = "pollutioncollector"
pollutioncollector.order = "z"
pollutioncollector.minable.result = "pollutioncollector"
pollutioncollector.crafting_categories = {"pollution"}
pollutioncollector.icon = GRAPHICS.."icons/pollution-collector.png"
pollutioncollector.icon_size = 64
pollutioncollector.pictures.picture.sheets[1].filename = GRAPHICS.."entity/pollution-collector/pollution-collector.png"
pollutioncollector.pictures.picture.sheets[1].hr_version.filename = GRAPHICS.."entity/pollution-collector/hr-pollution-collector.png"
pollutioncollector.fluid_box.filter = "polluted-air"
for i=1, #pollutioncollector.fluid_box.pipe_connections, 1 do
	pollutioncollector.fluid_box.pipe_connections[i].type = "input-output"
end
pollutioncollector.fluid_box.base_area = 10


----------
-- Item --
----------

local pollutioncollector_item = util.table.deepcopy(data.raw['item']['steam-turbine'])
pollutioncollector_item.name = "pollutioncollector"
pollutioncollector_item.place_result = "pollutioncollector"
pollutioncollector_item.stack_size = 50
pollutioncollector_item.icon = GRAPHICS.."icons/pollution-collector.png"
pollutioncollector_item.icon_size = 64



------------
-- Extend --
------------

data:extend({
	pollutioncollector,
	pollutioncollector_item,
	{
		type = "recipe",
		name = "pollutioncollector",
		energy_required = 5,
		enabled = false,
		ingredients =
		{
			{name="red-xenomass",			amount=10},
			{name="electronic-circuit",	amount=5},
			{name="iron-gear-wheel",	amount=50},
			{name="pipe", 				amount=50},
		},
		result= "pollutioncollector"
	},
})
