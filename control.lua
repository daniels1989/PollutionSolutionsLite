commands.add_command('set_recipe_2', nil, function (command)
  for _, collector in pairs(game.player.surface.find_entities_filtered{name="pollution-collector"}) do
    collector.set_recipe('pollution-2')
    collector.custom_status = {
      diode = defines.entity_status_diode.green,
      label = {"entity-status.working"}
    }
  end
end)
commands.add_command('set_recipe_1', nil, function (command)
  for _, collector in pairs(game.player.surface.find_entities_filtered{name="pollution-collector"}) do
    collector.set_recipe('pollution-1')
  end
end)
-- set entity operable to false when building it

function place_stuff(event)
  --[[@type LuaEntity]]
  local entity = event.created_entity or event.entity or event.destination
  if not entity.valid or entity.name ~= "pollution-collector" then return end

  entity.operable = false
end

script.on_event(defines.events.on_entity_cloned, place_stuff)
script.on_event(defines.events.on_built_entity, place_stuff)
script.on_event(defines.events.on_robot_built_entity, place_stuff)
script.on_event(defines.events.script_raised_built, place_stuff)
script.on_event(defines.events.script_raised_revive, place_stuff)

script.on_event(defines.events.on_player_dropped_item, function (event)
  game.print(serpent.line(event.player_index))
  game.print(serpent.line(event.entity))
end)
script.on_event(defines.events.on_entity_died, function (event)
  game.print(serpent.line(event.loot.get_contents()))
  game.print(serpent.line(event.entity))
end)
