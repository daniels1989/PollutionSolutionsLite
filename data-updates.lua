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

for _, armor in pairs(data.raw["armor"]) do
  if armor.name ~= "hev-armor" then
    local value = 0
    for _, resistance in pairs(armor.resistances) do
      if resistance.type == "acid" then
        value = resistance.percent
        break
      end
    end
    addResistance({armor}, POLLUTION_DAMAGE_TYPE, math.floor((value / 1.4) / 5) * 5, math.min(20, math.max(5, math.floor(value / 4))))
  end
end