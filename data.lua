require "constants"

require "prototypes/category"
require "prototypes/fluid"
require "prototypes/surface-property"

local test_resource = util.table.deepcopy(data.raw['resource']['crude-oil'])
test_resource.name = "test-pollution"
test_resource.flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"}
test_resource.collision_box = {{-0.1, -0.1}, {0.1, 0.1}}
data:extend({test_resource})

local test_jack = util.table.deepcopy(data.raw['mining-drill']['pumpjack'])
test_jack.name = "test-pollution-jack"
test_jack.resource_searching_radius = 2.49
data:extend({test_jack})