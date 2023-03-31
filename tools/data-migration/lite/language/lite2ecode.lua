local syntax = require "core.syntax"
local json = require "core.json"

if arg[1] == nil then
	print("Expected a file name to parse")
	return
end

for i = 1, #arg do
	dofile(arg[i])
end

local function gsplit(text, pattern, plain)
  local splitStart, length = 1, #text
  return function ()
    if splitStart then
      local sepStart, sepEnd = string.find(text, pattern, splitStart, plain)
      local ret
      if not sepStart then
        ret = string.sub(text, splitStart)
        splitStart = nil
      elseif sepEnd < sepStart then
        -- Empty separator!
        ret = string.sub(text, splitStart, sepStart)
        if sepStart < length then
          splitStart = sepStart + 1
        else
          splitStart = nil
        end
      else
        ret = sepStart > splitStart and string.sub(text, splitStart, sepStart - 1) or ''
        splitStart = sepEnd + 1
      end
      return ret
    end
  end
end

local function split(text, pattern, plain)
  local ret = {}
  for match in gsplit(text, pattern, plain) do
    table.insert(ret, match)
  end
  return ret
end

for i = 1, #syntax.items do
	syntax.items[i]["space_handling"] = nil
	for p = 1, #syntax.items[i].patterns do
		if type(syntax.items[i].patterns[p].type) == "table" then
			local ptr = {}
			local result = split(syntax.items[i].patterns[p].pattern, "()", true)
			for _, v in ipairs(result) do
				-- print(v)
				table.insert(ptr, "(" .. v .. ")")
			end
			local new_pattern = ""
			for z = 1, #ptr do
				new_pattern = new_pattern .. ptr[z]
			end
			local new_type = {}
			table.insert(new_type, "normal")
			for t = 1, #syntax.items[i].patterns[p].type do
				table.insert(new_type, syntax.items[i].patterns[p].type[t])
			end
			syntax.items[i].patterns[p].pattern = new_pattern
			syntax.items[i].patterns[p].type = new_type
		end
	end
end

if #syntax.items == 1 then
	print(json.encode(syntax.items[1]))
else
	print(json.encode(syntax.items))
end
