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
			}
		})
	end
end
