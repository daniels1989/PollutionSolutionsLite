local StringUtils = {}

---@param haystack string
---@param needle string
---@return boolean
function StringUtils.starts_with(haystack, needle)
	return string.sub(haystack, 1, string.len(needle)) == needle
end

---@param haystack string
---@param needle string
---@return boolean
function StringUtils.ends_with(haystack, needle)
	return string.sub(haystack, string.len(needle) * -1) == needle
end

return StringUtils