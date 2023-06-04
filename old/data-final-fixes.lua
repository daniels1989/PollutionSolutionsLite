require "constants"

data.raw["item"][TOXIC_SLUDGE_NAME .. "-barrel"].fuel_category = "waste"
data.raw["item"][TOXIC_SLUDGE_NAME .. "-barrel"].fuel_value = (50 * MJ_PER_TOXIC_SLUDGE) .. "MJ"
data.raw["item"][TOXIC_SLUDGE_NAME .. "-barrel"].burnt_result = "empty-barrel"