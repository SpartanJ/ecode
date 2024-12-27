local style = require "core.style"
local common = require "core.common"

function common.color_to_hex(rgba)
	r = math.floor(rgba[1]) % 256
	g = math.floor(rgba[2]) % 256
	b = math.floor(rgba[3]) % 256
	a = math.floor(rgba[4]) % 256
	if a < 255 then
		return string.format("#%02x%02x%02x%02x", r, g, b, a)
	end
	return string.format("#%02x%02x%02x", r, g, b)
end

function print_syntax(prop, eprop)
	if style.syntax[prop] then
		if eprop then
			print(eprop .. "=" .. common.color_to_hex(style.syntax[prop]))
		else
			print(prop .. "=" .. common.color_to_hex(style.syntax[prop]))
		end
	end
end

function print_style(prop)
	if style[prop] then
		print(prop .. "=" .. common.color_to_hex(style[prop]))
	end
end

function print_lint(prop, eprop)
	if style.lint and style.lint[prop] then
		if eprop then
			print(eprop .. "=" .. common.color_to_hex(style.lint[prop]))
		else
			print(prop .. "=" .. common.color_to_hex(style.lint[prop]))
		end
	end
end
if arg[1] == nil then
	print("Expected a file name to parse")
	return
end

for i = 1, #arg do
	dofile(arg[i])
end

local section_name = arg[1]:match("([^/\\]+)%.lua$")
print("[" .. section_name .. "]")
print_style("background")
print_style("text")
print_style("caret")
print_style("selection")
print_style("line_highlight")
print_style("line_number")
print_style("line_number2")
print_lint("error")
print_lint("warning")
print_lint("info", "notice")
print("")
print_syntax("normal")
print_syntax("keyword")
print_syntax("keyword2")
print_syntax("parameter", "keyword3")
print_syntax("number")
print_syntax("literal")
print_syntax("string")
print_syntax("operator")
print_syntax("function")
print_syntax("symbol")
print_syntax("comment")
print_syntax("link")
print_syntax("link_hover")
