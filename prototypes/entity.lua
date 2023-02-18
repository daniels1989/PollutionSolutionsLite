require "constants"

--
-- incinerator
--

local incinerator = util.table.deepcopy(data.raw['reactor']['nuclear-reactor'])
incinerator.name = "toxic-incinerator"
incinerator.order = "z"
incinerator.minable.result = "toxic-incinerator"
incinerator.consumption = INCINERATOR_OUTPUT .. "MW" -- the game divides this by efficiency to get true consumption
incinerator.energy_source.fuel_category = "waste"
incinerator.energy_source.effectivity = INCINERATOR_EFFICIENCY
incinerator.meltdown_action = nil

local emissionsPerSludge = EMISSIONS_PER_AIR * AIR_PER_SLUDGE * (1-INCINERATOR_EFFICIENCY)
local sludgePerMinute = 60 * (INCINERATOR_OUTPUT / INCINERATOR_EFFICIENCY) / MJ_PER_TOXIC_SLUDGE

incinerator.energy_source.emissions_per_minute = emissionsPerSludge * sludgePerMinute

incinerator.picture.layers[1].filename = GRAPHICS.."entity/incinerator/incinerator.png"
incinerator.picture.layers[1].hr_version.filename = GRAPHICS.."entity/incinerator/hr-incinerator.png"
incinerator.working_light_picture.filename=GRAPHICS.."entity/incinerator/reactor-lights-color.png"
incinerator.working_light_picture.hr_version.filename=GRAPHICS.."entity/incinerator/hr-reactor-lights-color.png"
incinerator.light_color={r=0.744, g=0.275, b=0.867}
incinerator.heat_buffer.max_temperature=615

incinerator.energy_source.smoke =
{
  {
    name = "incinerator-smoke",
    north_position = {-0.1, -2},
    east_position = {-0.1, -2},
    frequency = 20,
    starting_vertical_speed = 0.05,
    slow_down_factor = 1,
    starting_frame_deviation = 60,
  }
}

local incineratorsmoke =
{
  type = "trivial-smoke",
  name = "incinerator-smoke",
  flags = {"not-on-map"},
  duration = 10*TICKS_PER_SECOND,
  fade_in_duration = 0,
  fade_away_duration = 10*TICKS_PER_SECOND,
  spread_duration = 10*TICKS_PER_SECOND,
  start_scale = 0.25,
  end_scale = 1.5,
  color = {r = 0.2, g = 0.2, b = 0.2, a = 0.5},
  cyclic = true,
  affected_by_wind = true,
  animation =
  {
    width = 152,
    height = 120,
    line_length = 5,
    frame_count = 60,
    axially_symmetrical = false,
    direction_count = 1,
    shift = {-0.53125, -0.4375},
    priority = "high",
    animation_speed = 0.25,
    filename = "__base__/graphics/entity/smoke/smoke.png",
    flags = { "smoke" }
  }
}



--
-- Heat exchanger
--

local lowheater = util.table.deepcopy(data.raw['boiler']['heat-exchanger'])
lowheater.name = "low-heat-exchanger"
lowheater.order = "z"
lowheater.minable.result = "low-heat-exchanger"
lowheater.target_temperature = 315
lowheater.icon = GRAPHICS.."icons/low-heat-boiler.png"
lowheater.structure.north.layers[1].filename			=  GRAPHICS.."entity/low-heat-exchanger/lowheatex-N-idle.png"
lowheater.structure.north.layers[1].hr_version.filename	=  GRAPHICS.."entity/low-heat-exchanger/hr-lowheatex-N-idle.png"
lowheater.structure.east.layers[1].filename				=  GRAPHICS.."entity/low-heat-exchanger/lowheatex-E-idle.png"
lowheater.structure.east.layers[1].hr_version.filename	=  GRAPHICS.."entity/low-heat-exchanger/hr-lowheatex-E-idle.png"
lowheater.structure.south.layers[1].filename			=  GRAPHICS.."entity/low-heat-exchanger/lowheatex-S-idle.png"
lowheater.structure.south.layers[1].hr_version.filename	=  GRAPHICS.."entity/low-heat-exchanger/hr-lowheatex-S-idle.png"
lowheater.structure.west.layers[1].filename 			=  GRAPHICS.."entity/low-heat-exchanger/lowheatex-W-idle.png"
lowheater.structure.west.layers[1].hr_version.filename	=  GRAPHICS.."entity/low-heat-exchanger/hr-lowheatex-W-idle.png"
lowheater.energy_source.min_working_temperature = 315
lowheater.energy_source.max_temperature = 615
lowheater.energy_source.minimum_glow_temperature = 100
lowheater.energy_consumption = "8MW"


--
-- Turret
--

local toxicturret = util.table.deepcopy(data.raw['fluid-turret']['flamethrower-turret'])
toxicturret.name = "toxic-turret"
toxicturret.order = "z"
toxicturret.minable.result = "toxic-turret"

toxicturret.attack_parameters.fluids = {
  {type = "toxic-sludge"},
}

if mods["modmashsplinterresources"] then
  table.insert(toxicturret.attack_parameters.fluids,
  {
    type = "alien-ooze",
    damage_modifier=0.66
  })
end

if mods["NauvisDay"] then
  table.insert(toxicturret.attack_parameters.fluids,
  {
    type = "waste",
    damage_modifier=0.33
  })
end

toxicturret.attack_parameters.fluid_consumption = 3.0
toxicturret.attack_parameters.ammo_type.action.action_delivery.stream = "toxic-flame-stream"
toxicturret.attack_parameters.ammo_type.action.action_delivery.duration = 1*TICKS_PER_SECOND


--
-- Dump site
--

local emitter = util.table.deepcopy(data.raw['storage-tank']['storage-tank'])
emitter.name = "dump-site"
emitter.order = "z"
emitter.minable.result = "dump-site"
emitter.flags = {"placeable-neutral", "player-creation"}
emitter.corpse = "small-worm-corpse"
emitter.dying_explosion = "blood-explosion-big"
emitter.icon = GRAPHICS.."icons/toxicdump_icon.png"
emitter.icon_size=64
emitter.next_upgrade = nil
emitter.light = {
  minimum_darkness = 0.8,
  intensity = 0.9,
  size = 40,
  color = {r=0.333, g=0.063, b=0.451}
}
emitter.fluid_box.pipe_connections ={
  { position = {-2, 0} },
  { position = {0, 2} },
  { position = {2, 0} },
  { position = {0, -2} },
}
--emitter.fluid_box.filter = "toxicsludge"
emitter.fluid_box.base_area = 50
emitter.pictures.picture.sheets = {
  {
    filename = GRAPHICS.."entity/emitter/toxicdump.png",
    frames = 1,
    width = 321,--110,
    height = 321,--108,
    scale = 0.5,
    shift = util.by_pixel(0, 4),
    priority = "extra-high",
    hr_version = {
      filename = GRAPHICS.."entity/emitter/toxicdump.png",
      frames = 1,
      width = 321,--110,
      height = 321,--108,
      scale = 0.5,
      shift = util.by_pixel(-0.25, 3.75),
      priority = "extra-high",
    },
  },
  {
    filename = GRAPHICS.."entity/emitter/toxicdump_shadow.png",
    frames = 1,
    width = 321,--110,
    height = 256,--108,
    scale = 0.5,
    shift = util.by_pixel(0, 12),
    priority = "extra-high",
    draw_as_shadow = true,
    hr_version = {
      filename = GRAPHICS.."entity/emitter/toxicdump_shadow.png",
      frames = 1,
      width = 321,--110,
      height = 256,--108,
      scale = 0.5,
      shift = util.by_pixel(0, 24),
      priority = "extra-high",
      draw_as_shadow = true,
    },
  },
}
emitter.resistances = {
  {
    type = POLLUTION_DAMAGE_TYPE,
    percent = 100,
  },
  {
    type = "explosion",
    percent = 100,
  },
  {
    type = "fire",
    percent = 100,
  }
}
emitter.collision_mask = { "item-layer", "object-layer", "water-tile"}

local dumpsmoke = util.table.deepcopy(data.raw['trivial-smoke']['smoke'])
dumpsmoke.name = "dump-smoke"
dumpsmoke.duration = 30*TICKS_PER_SECOND
dumpsmoke.start_scale = 0.1
dumpsmoke.end_scale = 6.0
dumpsmoke.color = {r=0.744, g=0.275, b=0.867, a=0.5}
dumpsmoke.affected_by_wind = false
dumpsmoke.render_layer = "higher-object-under"


data:extend({
  incineratorsmoke,
  incinerator,
  toxicturret,
  lowheater,
  emitter,
  dumpsmoke,
})
