require("util")


local function update_pollution_generator(event)
  local generators = game.surfaces[1].find_entities_filtered{name = "pollution-generator"}

  for _, generator in ipairs(generators) do
    local pollution = generator.surface.get_pollution(generator.position)

    generator.set_infinity_pipe_filter({name = "polluted-air", percentage = 1/60, mode = "exactly"})
  end
end

local function set_chunk_pollution(event)
  local generators = game.surfaces[1].find_entities_filtered{name = "pollution-setter"}

  for _, generator in ipairs(generators) do
    local pollution = generator.surface.get_pollution(generator.position)
    local setting = generator.get_infinity_pipe_filter() or nil

    if setting ~= nil then
      generator.surface.pollute(generator.position, (setting.percentage * 1000) - pollution)
    end
  end
end

script.on_nth_tick(60, update_pollution_generator)
-- script.on_nth_tick(60, set_chunk_pollution)
