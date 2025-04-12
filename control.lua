
SharedUtils = require 'shared/util'

PollutantController = require 'scripts/pollutant-controller'
PollutantController.register()
-------- Note
---Using a mining drill works, but:
---1: it will only produce fluid once it finishes mining. Because it relies on power, this means it can take
---more than a second to finish
---2: this can be alleviated by decreasing the mining speed of the collector,
---3: we don't know when it has finished mining, there is no event or anything for that. so we don't know how much pollution
---it has mined
---4: there doesn't seem to be a way to ignore mining productivity research, so itll actually produce more occasionally.

--- func desc
-- ---@param area BoundingBox
-- ---@param position ChunkPosition
-- ---@param surface LuaSurface
-- function chunko(area, position, surface)
--   -- log("x: " .. position.x .. ", y: " .. position.y)
--   -- log("area: " .. serpent.line(area))
--   local resources = surface.find_entities_filtered{area = area, type = "resource"}
--   -- log(serpent.line(resources))

--   for _, resource in pairs(resources) do
--     if resource.name == 'pollution' then
--       return
--     end
--   end
--   -- local pos = {x = (position.x * 32) + 15.5, y = (position.y * 32) + 15.5}
--   -- log(serpent.line(pos))

--   local resource = surface.create_entity{
--     name = "pollution",
--     force = "neutral",
--     position = {x = (position.x * 32) + 16, y = (position.y * 32) + 16},
--     snap_to_grid = false,
--   } --[[@as LuaEntity]]

--   resource.amount = 1
-- end


-- script.on_init(function(event)
--   -- for _, surface in pairs(game.surfaces) do
--   --   for chunk in surface.get_chunks() do
--   --     chunko(chunk.area, {x = chunk.x, y = chunk.y},  surface)
--   --   end
--   -- end

--   chunko({left_top = {x = 0, y = 0}, right_bottom = {x = 32, y = 32}}, {x = 0, y = 0}, game.get_surface(1))
-- end)

-- script.on_event(defines.events.on_chunk_generated, function(event)
--   -- chunko(event.area, event.position, event.surface)
-- end)


-- script.on_nth_tick(30, function(event)
--   for _, surface in pairs(game.surfaces) do
--     local resources = surface.find_entities_filtered{name = "pollution"}
--     local collectors = surface.find_entities_filtered{name = "pollution_collector"}

--     for _, resource in pairs(resources) do
--       local pollution = 100 --surface.get_pollution(resource.position)
--       local dimret = math.max(#collectors, 1)^(-0.5) -- Same as sqrt(#collectors) / #collectors
--       local amount = math.max(pollution * dimret, 1)

--       resource.initial_amount = amount
--       resource.amount = amount
--     end


--     for _, collector in pairs(collectors) do
--       -- game.print(string.format("progress: %f", collector.mining_progress))
--     end
--   end
-- end)

-- commands.add_command('set_amount', nil, function (command)
--   local amount = tonumber(command.parameter)
--   if amount == nil then amount = 1000 end

--   for _, resource in pairs(game.player.surface.find_entities_filtered{name="pollution"}) do
--     resource.amount = math.max(amount, 1)
--     resource.initial_amount = math.max(amount * 2, 1)
--   end
-- end)
