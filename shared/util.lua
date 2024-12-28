local Util = {}

-- Has to be in a subfolder.
-- `table` or `string` will load the standard lua libraries.
-- `./table` works when debugging, but does not when packed into a zip file.

Util.table = require 'util/table'
Util.string = require 'util/string'

return Util