for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  recipes["fill-polluted-air-barrel"].enabled = technologies["fluid-handling"].researched
  recipes["empty-polluted-air-barrel"].enabled = technologies["fluid-handling"].researched
  recipes["fill-toxic-sludge-barrel"].enabled = technologies["fluid-handling"].researched
  recipes["empty-toxic-sludge-barrel"].enabled = technologies["fluid-handling"].researched
end
