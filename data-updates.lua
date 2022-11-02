require "constants"

-------------------
-- Compatibility --
-------------------

if mods["RampantIndustry"] then
  table.insert(data.raw["technology"]["rampant-industry-technology-air-filtering"].prerequisites, "pollution-controls")
end

if mods["NauvisDay"] then
  table.insert(data.raw["technology"]["pollution-capture"].prerequisites, "pollution-controls")
  table.insert(data.raw["technology"]["pollution-processing"].prerequisites, "incineration")
end

if mods["nauvis-melange"] then
  table.insert(data.raw["technology"]["nm-alien-breeding"].prerequisites, "incineration")
end

if mods["modmashsplinterresources"] then
  table.insert(data.raw["technology"]["alien-conversion1"].prerequisites, "incineration")
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

addResistance({data.raw["armor"]["modular-armor"]},		POLLUTION_DAMAGE_TYPE, 10, 5)
addResistance({data.raw["armor"]["power-armor"]},		POLLUTION_DAMAGE_TYPE, 30, 10)
addResistance({data.raw["armor"]["power-armor-mk2"]},	POLLUTION_DAMAGE_TYPE, 40, 15)
