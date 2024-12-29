-- Require utils
SharedUtils = require 'shared/util'

pollutants = {
  'pollution',
  'spores'
}

for _, pollutant in pairs(data.raw['airborne-pollutant']) do
  if not SharedUtils.table.contains(pollutants, pollutant.name) then
    table.insert(pollutants, pollutant.name)
  end
end

for _, planet in pairs(data.raw['planet']) do
  if planet.pollutant_type ~= nil and SharedUtils.table.contains(pollutants, planet.pollutant_type) then
    local type = SharedUtils.table.search(pollutants, planet.pollutant_type)
    data.raw['planet'][planet.name].surface_properties['airborne-pollutant'] = type or 0
  end
end
