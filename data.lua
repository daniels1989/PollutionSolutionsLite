require("prototypes.category")
require("prototypes.projectiles")
require("prototypes.entity")
require("prototypes.fluid")
require("prototypes.item")
require("prototypes.recipe")
require("prototypes.technology")
require("prototypes.pollutioncollector")
require("prototypes.hevsuit")
if mods["k2-flare-stack"] then
	flare_stack.flare_stack_util.addBurnFluidEmissionsMultiplier("polluted-air", 600)
	flare_stack.flare_stack_util.addBurnFluidEmissionsMultiplier("toxic-sludge", 600 * AIR_PER_SLUDGE)
end