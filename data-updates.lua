require "constants"

------------------
-- Technologies --
------------------

data:extend(
{
	{
		type = "technology",
		name = "pollution-controls",
		icon = "__PollutionSolutionsFixFork__/graphics/icons/pollution-collection.png",
		icon_size = 128,
		prerequisites = {"fluid-handling"},
		unit =
		{
			count = 100,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			},
			time = 30
		},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "pollutioncollector"
			},
			{
				type = "unlock-recipe",
				recipe = "dump-site"
			},
			{
				type = "unlock-recipe",
				recipe = "blue-xenomass"
			},
			{
				type = "unlock-recipe",
				recipe = "red-xenomass"
			},
		},
		order = "c-a"
	},
})

data:extend(
{
	{
		type = "technology",
		name = "inceneration",
		icon = "__PollutionSolutionsFixFork__/graphics/icons/inceneration.png",
		icon_size = 128,
		prerequisites = {"pollution-controls", "flammables","military-2"},
		unit =
		{
			count = 100,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			},
			time = 30
		},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "liquify-pollution"
			},
			{
				type = "unlock-recipe",
				recipe = "toxic-turret"
			},
			{
				type = "unlock-recipe",
				recipe = "hev-armor"
			},
			{
				type = "unlock-recipe",
				recipe = "toxic-waste-treatment"
			},
			{
				type = "unlock-recipe",
				recipe = "toxic-incinerator"
			},
			{
				type = "unlock-recipe",
				recipe = "low-heat-exchanger"
			},
			{
				type = "unlock-recipe",
				recipe = "fill-toxic-sludge-barrel"
			},
			{
				type = "unlock-recipe",
				recipe = "empty-toxic-sludge-barrel"
			},
		},
		order = "c-a"
	},
})


-------------------
-- Compatibility --
-------------------

if mods["RampantIndustry"] then
  table.insert(data.raw["technology"]["rampant-industry-technology-air-filtering"].prerequisites, "pollution-controls")
end

if mods["NauvisDay"] then
  table.insert(data.raw["technology"]["pollution-capture"].prerequisites, "pollution-controls")
  table.insert(data.raw["technology"]["pollution-processing"].prerequisites, "inceneration")
end

if mods["nauvis-melange"] then
  table.insert(data.raw["technology"]["nm-alien-breeding"].prerequisites, "inceneration")
end

if mods["modmashsplinterresources"] then
  table.insert(data.raw["technology"]["alien-conversion1"].prerequisites, "inceneration")
end

-------------------
-- Toxic Barrels --
-------------------

-- The technology the barrel unlocks will be added to
local technology_name = "inceneration"
-- The base empty barrel item
local empty_barrel_name = "empty-barrel"

-- Item icon masks
local barrel_side_mask = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png"
local barrel_hoop_top_mask = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png"

-- Recipe icon masks
local barrel_empty = "__base__/graphics/icons/fluid/barreling/barrel-empty.png"
local barrel_empty_side_mask = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png"
local barrel_empty_top_mask = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png"
local barrel_fill = "__base__/graphics/icons/fluid/barreling/barrel-fill.png"
local barrel_fill_side_mask = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png"
local barrel_fill_top_mask = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png"

-- Alpha used for barrel masks
local side_alpha = 0.75
local top_hoop_alpha = 0.75
-- Fluid required per barrel recipe
local fluid_per_barrel = SLUDGE_PER_BARREL
-- Crafting energy per barrel fill recipe
local energy_per_fill = 1
-- Crafting energy per barrel empty recipe
local energy_per_empty = 1
-- If the fill/empty recipes effect production statistics
local hide_barreling_from_production_stats = true
-- If the fill/empty recipes should be included in the list of valid recipes things can use when calculating raw materials
local allow_barreling_decomposition = false


local function get_technology(name)
  local technologies = data.raw["technology"]
  if technologies then
    return technologies[name]
  end
  return nil
end

local function get_item(name)
  local items = data.raw["item"]
  if items then
    return items[name]
  end
  return nil
end

-- Generates the icons definition for a barrel item with the provided name and fluid definition using the provided empty barrel base icon
local function generate_barrel_item_icons(name, fluid, empty_barrel_item)
  local side_tint = util.table.deepcopy(fluid.base_color)
  side_tint.a = side_alpha
  local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
  top_hoop_tint.a = top_hoop_alpha

  return
  {
    {
      icon = empty_barrel_item.icon
    },
    {
      icon = barrel_side_mask,
      tint = side_tint
    },
    {
      icon = barrel_hoop_top_mask,
      tint = top_hoop_tint
    }
  }
end

-- Generates a barrel item with the provided name and fluid definition using the provided empty barrel stack size
local function create_barrel_item(name, fluid, empty_barrel_item)
  local result =
  {
    type = "item",
    name = name,
    localised_name = {"item-name.filled-barrel", {"fluid-name." .. fluid.name}},
    icons = generate_barrel_item_icons(name, fluid, empty_barrel_item),
    icon_size = 64,
    subgroup = "fill-barrel",
    order = "b[" .. name .. "]",
    stack_size = empty_barrel_item.stack_size,
	fuel_category = "waste",
	burnt_result = "empty-barrel",
	fuel_value = (SLUDGE_PER_BARREL * MJ_PER_TOXIC_SLUDGE) .. "MJ"
  }

  data:extend({result})
  return result
end

local function get_or_create_barrel_item(name, fluid, empty_barrel_item)
  return create_barrel_item(name, fluid, empty_barrel_item)
end

-- Generates the icons definition for a fill-barrel recipe with the provided barrel name and fluid definition
local function generate_fill_barrel_icons(name, fluid)
  local side_tint = util.table.deepcopy(fluid.base_color)
  side_tint.a = side_alpha
  local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
  top_hoop_tint.a = top_hoop_alpha

  return
  {
    {
      icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png"
    },
    {
      icon = barrel_fill_side_mask,
      tint = side_tint
    },
    {
      icon = barrel_fill_top_mask,
      tint = top_hoop_tint
    },
    {
      icon = fluid.icon,
      scale = 0.25,
      shift = {4, -8}
    }
  }
end

-- Generates the icons definition for a empty-barrel recipe with the provided barrel name and fluid definition
local function generate_empty_barrel_icons(name, fluid)
  local side_tint = util.table.deepcopy(fluid.base_color)
  side_tint.a = side_alpha
  local top_hoop_tint = util.table.deepcopy(fluid.flow_color)
  top_hoop_tint.a = top_hoop_alpha

  return
  {
    {
      icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png"
    },
    {
      icon = barrel_empty_side_mask,
      tint = side_tint
    },
    {
      icon = barrel_empty_top_mask,
      tint = top_hoop_tint
    },
    {
      icon = fluid.icon,
      scale = 0.25,
      shift = {7, 8}
    }
  }
end

-- Creates a recipe to fill the provided barrel item with the provided fluid
local function create_fill_barrel_recipe(item, fluid)
  local recipe =
  {
    type = "recipe",
    name = "fill-" .. item.name,
    localised_name = {"recipe-name.fill-barrel", {"fluid-name." .. fluid.name}},
    category = "crafting-with-fluid",
    energy_required = energy_per_fill,
    subgroup = "fill-barrel",
    order = "b[fill-" .. item.name .. "]",
    enabled = false,
    icons = generate_fill_barrel_icons(item, fluid),
    icon_size = 64,
    ingredients =
    {
      {type = "fluid", name = fluid.name, amount = 2*fluid_per_barrel},
      {type = "item", name = empty_barrel_name, amount = 2},
    },
    results=
    {
      {type = "item", name = item.name, amount = 2}
    },
    hide_from_stats = hide_barreling_from_production_stats,
    allow_decomposition = allow_barreling_decomposition
  }

  data:extend({recipe})
  return recipe
end

-- Creates a recipe to empty the provided full barrel item producing the provided fluid
local function create_empty_barrel_recipe(item, fluid)
  local recipe =
  {
    type = "recipe",
    name = "empty-" .. item.name,
    localised_name = {"recipe-name.empty-filled-barrel", {"fluid-name." .. fluid.name}},
    category = "crafting-with-fluid",
    energy_required = energy_per_empty,
    subgroup = "empty-barrel",
    order = "c[empty-" .. item.name .. "]",
    enabled = false,
    icons = generate_empty_barrel_icons(item, fluid),
    icon_size = 64,
    ingredients =
    {
      {type = "item", name = item.name, amount = 1}
    },
    results=
    {
      {type = "fluid", name = fluid.name, amount = fluid_per_barrel},
      {type = "item", name = empty_barrel_name, amount = 1}
    },
    hide_from_stats = hide_barreling_from_production_stats,
    allow_decomposition = allow_barreling_decomposition
  }

  data:extend({recipe})
  return recipe
end

local function get_or_create_barrel_recipes(item, fluid)
  local fill_recipe, empty_recipe

  --if not fill_recipe then
    fill_recipe = create_fill_barrel_recipe(item, fluid)
  --end
  --if not empty_recipe then
    empty_recipe = create_empty_barrel_recipe(item, fluid)
  --end

  return fill_recipe, empty_recipe
end


local function process_fluid(fluid, technology, empty_barrel_item)
  local barrel_name = fluid.name .. "-barrel"

  -- check if a barrel already exists for this fluid if not - create one
  local barrel_item = get_or_create_barrel_item(barrel_name, fluid, empty_barrel_item)

  -- check if the barrel has a recipe if not - create one
  local barrel_fill_recipe, barrel_empty_recipe = get_or_create_barrel_recipes(barrel_item, fluid)

  -- check if the barrel recipe exists in the unlock list of the technology if not - add it
  --add_barrel_to_technology(barrel_item, barrel_fill_recipe, barrel_empty_recipe, technology)
end

process_fluid(data.raw["fluid"]["toxic-sludge"], get_technology(technology_name), get_item(empty_barrel_name))

local function addResistance(entityList, _DamageType, _Percent, _Decrease)
	if not entityList or (not _Percent and not _Decrease) or (_Percent == 0 and _Decrease == 0)  then
		log("Failed to make entity list immune.")
	end
	for name,entity in pairs(entityList) do
		local resistTable = {
			type = _DamageType,
		}
		if _Percent and _Percent ~= 0 then
			resistTable.percent = _Percent
		end
		if _Decrease and _Decrease ~= 0 then
			resistTable.decrease = _Decrease
		end
		if not entity.resistances then
			entityList[name].resistances = {resistTable}
		else
			table.insert(entityList[name].resistances, resistTable)
		end
	end
end

-----------------
-- Resistances --
-----------------

addResistance(data.raw["wall"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["gate"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["transport-belt"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["car"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["electric-turret"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["ammo-turret"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["construction-robot"],	POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["combat-robot"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["logistic-robot"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["logistic-container"],	POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["container"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["electric-pole"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["heat-pipe"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["pipe"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["pipe-to-ground"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["land-mine"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["straight-rail"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["curved-rail"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["train-stop"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["locomotive"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["rail-signal"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["rail-chain-signal"],	POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["underground-belt"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["lamp"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["cargo-wagon"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["fluid-wagon"],			POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["artillery-wagon"],		POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["tree"],					POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["radar"],				POLLUTION_DAMAGE_TYPE, 100)
addResistance(data.raw["unit-spawner"],			POLLUTION_DAMAGE_TYPE, 100)

addResistance({data.raw["armor"]["modular-armor"]},		POLLUTION_DAMAGE_TYPE, 10, 5)
addResistance({data.raw["armor"]["power-armor"]},		POLLUTION_DAMAGE_TYPE, 30, 10)
addResistance({data.raw["armor"]["power-armor-mk2"]},	POLLUTION_DAMAGE_TYPE, 40, 15)
