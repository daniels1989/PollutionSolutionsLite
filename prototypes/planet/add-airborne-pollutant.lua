pollutants = {
  nil,
}

for _, pollutant in pairs(data.raw['airborne-pollutant']) do
  table.insert(pollutants, pollutant.name)
end
