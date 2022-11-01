require "constants"

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
