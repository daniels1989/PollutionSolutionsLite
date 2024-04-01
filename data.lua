require("constants")

require("prototypes.category")
require("prototypes.fluid")





data:extend({
  {
    type = "damage-type",
    name = "toxic",
  },
  {
    type = "recipe-category",
    name = "pollution"
  },
})











require ("__base__.prototypes.entity.pipecovers")

util = require("util")
local sounds = require("__base__.prototypes.entity.sounds")


local pollution_pipe = util.table.deepcopy(data.raw['pipe']['pipe']);
pollution_pipe.name = "pollution-pipe"
pollution_pipe.fluid_box.base_area = 0.1;
pollution_pipe.fluid_box.height = 0.1;
data:extend({pollution_pipe})

local pollution_generator = util.table.deepcopy(data.raw['infinity-pipe']['infinity-pipe']);
pollution_generator.name = "pollution-generator"
pollution_generator.gui_mode = "none";
pollution_generator.fluid_box.base_level = 25;
pollution_generator.icons =
{{
  icon = "__base__/graphics/icons/pipe.png",
  tint = {r = 1, g = 0.5, b = 0}
}}

for name, picture in pairs(pollution_generator.pictures) do
  if name ~= "high_temperature_flow" and name ~= "middle_temperature_flow" and name ~= "low_temperature_flow" and name ~= "gas_flow" then
    picture.tint = {r = 1, g = 0.5, b = 0}
    if picture.hr_version then
      picture.hr_version.tint = {r = 1, g = 0.5, b = 0}
    end
  end
end


local pollution_setter = util.table.deepcopy(pollution_generator);
pollution_setter.name = "pollution-setter"
pollution_setter.icons =
{{
  icon = "__base__/graphics/icons/pipe.png",
  tint = {r = 1, g = 0, b = 0}
}}

for name, picture in pairs(pollution_setter.pictures) do
  if name ~= "high_temperature_flow" and name ~= "middle_temperature_flow" and name ~= "low_temperature_flow" and name ~= "gas_flow" then
    picture.tint = {r = 1, g = 0, b = 0}
    if picture.hr_version then
      picture.hr_version.tint = {r = 1, g = 0, b = 0}
    end
  end
end

data:extend({
  pollution_generator,
  pollution_setter
})

data:extend({
  {
    type = "recipe",
    name = "test-fluid-recipe-burning",
    category = "pollution",
    enabled = true,
    energy_required = 500,
    ingredients =
    {
      {type="fluid", name="toxic-sludge", amount=50},
    },
    results=
    {
      {type="item", name="coal", amount_min = 1, amount_max = 5, probability = 0.2, catalyst_amount = 10},
    },
    icon = "__base__/graphics/icons/fluid/advanced-oil-processing.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },
})


data:extend({

  {
    type = "assembling-machine",
    name = "centrifuge-small",
    icon = "__base__/graphics/icons/centrifuge.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "centrifuge"},
    max_health = 350,
    corpse = "centrifuge-remnants",
    dying_explosion = "centrifuge-explosion",
    fluid_boxes =
    {
      {
        production_type = "input",
        -- pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {
          { type="input", position = {-2, 0} },
        },
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.3, -0.8}, {1.3, 0.8}},
    selection_box = {{-1.5, -1}, {1.5, 1}},
    drawing_box = {{-1.5, -1.5}, {1.5, 1.0}},
   -- damaged_trigger_effect = hit_effects.entity(),

    always_draw_idle_animation = true,
    idle_animation =
    {
      layers =
      {
        -- Centrifuge C
        -- {
        --   filename = "__base__/graphics/entity/centrifuge/centrifuge-C.png",
        --   priority = "high",
        --   line_length = 8,
        --   width = 119,
        --   height = 107,
        --   frame_count = 64,
        --   shift = util.by_pixel(-0.5, -26.5),
        --   hr_version =
        --   {
        --     filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-C.png",
        --     priority = "high",
        --     scale = 0.5,
        --     line_length = 8,
        --     width = 237,
        --     height = 214,
        --     frame_count = 64,
        --     shift = util.by_pixel(-0.25, -26.5)
        --   }
        -- },
        -- {
        --   filename = "__base__/graphics/entity/centrifuge/centrifuge-C-shadow.png",
        --   draw_as_shadow = true,
        --   priority = "high",
        --   line_length = 8,
        --   width = 132,
        --   height = 74,
        --   frame_count = 64,
        --   shift = util.by_pixel(20, -10),
        --   hr_version =
        --   {
        --     filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-C-shadow.png",
        --     draw_as_shadow = true,
        --     priority = "high",
        --     scale = 0.5,
        --     line_length = 8,
        --     width = 279,
        --     height = 152,
        --     frame_count = 64,
        --     shift = util.by_pixel(16.75, -10)
        --   }
        -- },
        -- Centrifuge B
        {
          filename = "__base__/graphics/entity/centrifuge/centrifuge-B.png",
          priority = "high",
          line_length = 8,
          width = 78,
          height = 117,
          frame_count = 64,
          shift = util.by_pixel(23, -9.5),
          hr_version =
          {
            filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-B.png",
            priority = "high",
            scale = 0.5,
            line_length = 8,
            width = 156,
            height = 234,
            frame_count = 64,
            shift = util.by_pixel(23, -9.5)
          }
        },
        {
          filename = "__base__/graphics/entity/centrifuge/centrifuge-B-shadow.png",
          draw_as_shadow = true,
          priority = "high",
          line_length = 8,
          width = 124,
          height = 74,
          frame_count = 64,
          shift = util.by_pixel(63, 16),
          hr_version =
          {
            filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-B-shadow.png",
            draw_as_shadow = true,
            priority = "high",
            scale = 0.5,
            line_length = 8,
            width = 251,
            height = 149,
            frame_count = 64,
            shift = util.by_pixel(63.25, 15.25)
          }
        },
        -- Centrifuge A
        {
          filename = "__base__/graphics/entity/centrifuge/centrifuge-A.png",
          priority = "high",
          line_length = 8,
          width = 70,
          height = 123,
          frame_count = 64,
          shift = util.by_pixel(-26, 3.5),
          hr_version =
          {
            filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-A.png",
            priority = "high",
            scale = 0.5,
            line_length = 8,
            width = 139,
            height = 246,
            frame_count = 64,
            shift = util.by_pixel(-26.25, 3.5)
          }
        },
        {
          filename = "__base__/graphics/entity/centrifuge/centrifuge-A-shadow.png",
          priority = "high",
          draw_as_shadow = true,
          line_length = 8,
          width = 108,
          height = 54,
          frame_count = 64,
          shift = util.by_pixel(6, 27),
          hr_version =
          {
            filename = "__base__/graphics/entity/centrifuge/hr-centrifuge-A-shadow.png",
            priority = "high",
            draw_as_shadow = true,
            scale = 0.5,
            line_length = 8,
            width = 230,
            height = 124,
            frame_count = 64,
            shift = util.by_pixel(8.5, 23.5)
          }
        }
      }
    },

    working_visualisations =
    {
      {
        effect = "uranium-glow",
        fadeout = true,
        light = {intensity = 0.2, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.744, g = 0.275, b = 0.867}}
      },
      {
        effect = "uranium-glow",
        fadeout = true,
        draw_as_light = true,
        animation =
        {
          layers =
          {
            -- Centrifuge C
            -- {
            --   filename = GRAPHICS .. "entity/centrifuge/centrifuge-C-light.png",
            --   priority = "high",
            --   blend_mode = "additive", -- centrifuge
            --   line_length = 8,
            --   width = 96,
            --   height = 104,
            --   frame_count = 64,
            --   shift = util.by_pixel(0, -27),

            --   hr_version =
            --   {
            --     filename = GRAPHICS .. "entity/centrifuge/hr-centrifuge-C-light.png",
            --     priority = "high",
            --     scale = 0.5,
            --     blend_mode = "additive", -- centrifuge
            --     line_length = 8,
            --     width = 190,
            --     height = 207,
            --     frame_count = 64,
            --     shift = util.by_pixel(0, -27.25)
            --   }
            -- },
            -- Centrifuge B
            {
              filename = GRAPHICS .. "entity/centrifuge/centrifuge-B-light.png",
              priority = "high",
              blend_mode = "additive", -- centrifuge
              line_length = 8,
              width = 65,
              height = 103,
              frame_count = 64,
              shift = util.by_pixel(16.5, 0.5),
              hr_version =
              {
                filename = GRAPHICS .. "entity/centrifuge/hr-centrifuge-B-light.png",
                priority = "high",
                scale = 0.5,
                blend_mode = "additive", -- centrifuge
                line_length = 8,
                width = 131,
                height = 206,
                frame_count = 64,
                shift = util.by_pixel(16.75, 0.5)
              }
            },
            -- Centrifuge A
            {
              filename = GRAPHICS .. "entity/centrifuge/centrifuge-A-light.png",
              priority = "high",
              blend_mode = "additive", -- centrifuge
              line_length = 8,
              width = 55,
              height = 98,
              frame_count = 64,
              shift = util.by_pixel(-23.5, -2),
              hr_version =
              {
                filename = GRAPHICS .. "entity/centrifuge/hr-centrifuge-A-light.png",
                priority = "high",
                scale = 0.5,
                blend_mode = "additive", -- centrifuge
                line_length = 8,
                width = 108,
                height = 197,
                frame_count = 64,
                shift = util.by_pixel(-23.5, -1.75)
              }
            }

          }
        }
      }
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/centrifuge-3.ogg",
          volume = 0.3
        },
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      --max_sounds_per_type = 3,
      --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 }
    },
    crafting_speed = 1,
    crafting_categories = {"pollution"},
    energy_source =
    -- {
    --   type = "electric",
    --   usage_priority = "secondary-input",
    --   emissions_per_minute = 4
    -- },
    {
      type = "fluid",
      fluid_box =
      {
        base_area = 1,
        height = 2,
        base_level = -1,
        pipe_covers = pipecoverspictures(),
        pipe_connections =
        {
          {type = "input", position = {1, -1.5}},
        },
        production_type = "input",
        filter = "water"
      },
      burns_fluid = true,
      scale_fluid_usage = true,
    },
    energy_usage = "350kW",
    module_specification =
    {
      module_slots = 2
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/centrifuge/centrifuge-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 32,
        shift = util.by_pixel(0, 65),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})


-- This allows centrifuge to use color from recipe instead of something fixed
-- local centrifuge = data.raw["assembling-machine"].centrifuge
-- if centrifuge then
--   centrifuge.working_visualisations[1].light.color = {r = 0.9, g = 1.0, b = 0.7}
--   centrifuge.working_visualisations[2].apply_recipe_tint = "primary"
--   centrifuge.working_visualisations[2].animation.layers[1].filename = "__space-exploration-graphics__/graphics/entity/centrifuge/centrifuge-C-light.png"
--   centrifuge.working_visualisations[2].animation.layers[2].filename = "__space-exploration-graphics__/graphics/entity/centrifuge/centrifuge-B-light.png"
--   centrifuge.working_visualisations[2].animation.layers[3].filename = "__space-exploration-graphics__/graphics/entity/centrifuge/centrifuge-A-light.png"
--   centrifuge.working_visualisations[2].animation.layers[1].hr_version.filename = "__space-exploration-graphics__/graphics/entity/centrifuge/hr-centrifuge-C-light.png"
--   centrifuge.working_visualisations[2].animation.layers[2].hr_version.filename = "__space-exploration-graphics__/graphics/entity/centrifuge/hr-centrifuge-B-light.png"
--   centrifuge.working_visualisations[2].animation.layers[3].hr_version.filename = "__space-exploration-graphics__/graphics/entity/centrifuge/hr-centrifuge-A-light.png"
-- end
