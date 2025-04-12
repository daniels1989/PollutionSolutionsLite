require "constants"

-- Require utils
SharedUtils = require "shared/util"

-- base game
local pollutants = { "pollution" }

-- If mods add pollutants then add them here if needed to be supported
if mods["space-age"] then
	table.insert(pollutants, "spores")
end

-- Adds all other pollutants to the support list
-- TODO: Should probably make configurable or not enable at all
for _, pollutant in pairs(data.raw[POLLUTANT]) do
	if not SharedUtils.table.contains(pollutants, pollutant.name) then
		table.insert(pollutants, pollutant.name)
	end
end

-- TODO: Should probably add a way to explicitly remove support for pollutants

-- Add pollutants as surface property
for _, planet in pairs(data.raw["planet"]) do
	if planet.pollutant_type ~= nil and SharedUtils.table.contains(pollutants, planet.pollutant_type) then
		local type = SharedUtils.table.search(pollutants, planet.pollutant_type)
		data.raw["planet"][planet.name].surface_properties[POLLUTANT] = type or 0
	end
end

-- Add supported pollutants as fluid and resource
for _, pollutant in pairs(data.raw[POLLUTANT]) do
	if SharedUtils.table.contains(pollutants, pollutant.name) then
		data:extend({
			{
				type = "fluid",
				name = pollutant.name,
				subgroup = "fluid",
				localised_name = { POLLUTANT .. "-name." .. pollutant.name },
				base_color = {
					r = pollutant.chart_color.r,
					g = pollutant.chart_color.g,
					b = pollutant.chart_color.b,
				},
				flow_color = {
					r = pollutant.chart_color.r,
					g = pollutant.chart_color.g,
					b = pollutant.chart_color.b,
					a = pollutant.chart_color.a * 0.6
				},
				icons = {
					{
						icon = "__base__/graphics/icons/fluid/steam.png",
						icon_size = 64,
						tint = {
							r = pollutant.chart_color.r,
							g = pollutant.chart_color.g,
							b = pollutant.chart_color.b,
							a = pollutant.chart_color.a * 0.6
						}
					}
				},
				order = "a[fluid]-b[" .. POLLUTANT .. "]-a[" .. pollutant.name .. "]",
				default_temperature = 15,
				gas_temperature = -195,
			},
			{
				type = "resource",
				name = pollutant.name,
				icons = {
					{
						icon = "__base__/graphics/icons/fluid/steam.png",
						icon_size = 64,
						tint = {
							r = pollutant.chart_color.r,
							g = pollutant.chart_color.g,
							b = pollutant.chart_color.b,
							a = pollutant.chart_color.a * 0.6
						}
					}
				},
				flags = {
					"placeable-neutral", -- default for resource
					"placeable-off-grid", -- needs to be off center
					-- "not-on-map"     -- to not show it on the map
				},
				stage_counts = {0},
    stages =
    {
      sheet = util.sprite_load("__base__/graphics/entity/crude-oil/crude-oil",
      {
        priority = "extra-high",
        scale = 0.5,
        variation_count = 1,
        frame_count = 4,
      })
    },
				category = POLLUTANT,
				subgroup = "mineable-fluids",
				order = "a-b-a",
				infinite = true,
				highlight = true,
				minimum = 100,
				normal = 100,
				infinite_depletion_amount = 0,
				resource_patch_search_radius = 14, -- needed to not be highlighted on the map
				minable =
				{
					mining_time = 1,
					results =
					{
						{
							type = "fluid",
							name = pollutant.name,
							amount_min = 100,
							amount_max = 100,
							probability = 1
						}
					}
				},
				collision_box = { { -0.49, -0.49 }, { 0.49, 0.49 } },
				selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
				selectable_in_game = true,
				map_color = { 0.78, 0.2, 0.77 },
				map_grid = false
			}
		})
	end
end
