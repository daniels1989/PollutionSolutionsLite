local PollutantController = {}

function PollutantController.register()
	script.on_init(function(event) --- When a mod is new to a save
		for _, surface in pairs(game.surfaces) do
			if surface.pollutant_type ~= nil then
				PollutantController.initSurface(surface)
			end
		end
	end)

	script.on_event(defines.events.on_surface_created, function(event)
		local surface = game.get_surface(event.surface_index) --[[@as LuaSurface]]
		PollutantController.initSurface(surface)
	end)

	script.on_event(defines.events.on_chunk_generated, function(event)
		PollutantController.createPollutionResource(event.area, event.surface)
	end)

	script.on_nth_tick(64, function(event)
		for _, surface in pairs(game.surfaces) do
			if surface.pollutant_type ~= nil then
				PollutantController.updateSurfacePollution(surface)
			end
		end
	end)
end

---@param surface LuaSurface
function PollutantController.initSurface(surface)
	if surface.pollutant_type == nil then
		return
	end

	for chunk in surface.get_chunks() do
		PollutantController.createPollutionResource(chunk.area, surface)
	end
end

---@param area BoundingBox
---@param surface LuaSurface
---@return LuaEntity|nil
function PollutantController.createPollutionResource(area, surface)
	if surface.pollutant_type == nil then
		return nil
	end

	local resources = surface.find_entities_filtered{
		area = area,
		type = "resource",
		name = surface.pollutant_type.name
	}

	if #resources > 0 then
		return resources[0]
	end

	return surface.create_entity{
		name = surface.pollutant_type.name,
		force = "neutral",
		position = {
			x = area.left_top.x + 16,
			y = area.left_top.y + 16,
		},
		snap_to_grid = false,
		raise_build = false,
		enable_tree_removal = false,
		enable_cliff_removal = false,
		snap_to_tile_center = false,
		amount = 1,
	} --[[@as LuaEntity]]
end

---@param surface LuaSurface
function PollutantController.updateSurfacePollution(surface)
	if surface.pollutant_type == nil then
		return
	end

	local resources = surface.find_entities_filtered{
		type = "resource",
		name = surface.pollutant_type.name
	}

	for _, resource in pairs(resources) do
		resource.amount = math.max(surface.get_pollution(resource.position), 1)
	end

	-- for chunk in surface.get_chunks() do
	-- 	local resources = surface.find_entities_filtered{
	-- 		area = chunk.area,
	-- 		type = "resource",
	-- 		name = surface.pollutant_type.name
	-- 	}

	-- 	local resource = nil

	-- 	if #resources > 0 then
	-- 		resource = resources[0] --[[@as LuaEntity]]
	-- 	else
	-- 		resource = PollutantController.createPollutionResource(chunk.area, surface)
	-- 	end

	-- 	if resource ~= nil then
	-- 		local pollution = math.max(surface.get_pollution(resource.position), 1)

	-- 		resource.amount = pollution
	-- 	end
	-- end
end

return PollutantController
