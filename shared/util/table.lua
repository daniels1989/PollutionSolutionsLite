local TableUtils = {}

---@param table table
---@return boolean
function TableUtils.contains(table, needle)
	for _, value in pairs(table) do
		if value == needle then
			return true
		end
	end

	return false
end

---@param table table
---@return boolean
function TableUtils.key_exists(table, needle)
	for key, _ in pairs(table) do
		if key == needle then
			return true
		end
	end

	return false
end

---@param table1 table
---@param table2 table
function TableUtils.merge(table1, table2)
	for _, value in pairs(table2) do
		table.insert(table1, value)
	end
end

---@param table1 table
---@param table2 table
function TableUtils.merge_keys(table1, table2)
	for key, value in pairs(table2) do
		table1[key] = value
	end
	return table1
end

return TableUtils