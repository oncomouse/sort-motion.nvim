local sort_motion_flags = vim.g.sort_motion_flags or ""

local M = {}

function M.sort_motion(mode)
	local sort_motion_visual_block_command = vim.g.sort_motion_visual_block_command or "sort"

	if mode == "line" then
		vim.cmd("'[,']sort " .. sort_motion_flags)
	elseif mode == "char" then
		vim.cmd("normal! `[v`]y")
		local unnamed = table.concat(vim.fn.getreginfo([["]]).regcontents, "\n")
		local startpos = vim.fn.match(unnamed, [[\v\i]])
		local parts = vim.fn.split(unnamed, [[\v\i+]])
		local prefix, delimiter, suffix
		if startpos > 0 then
			prefix = parts[1]
			delimiter = parts[2]
			suffix = parts[#parts]
		else
			prefix = ""
			delimiter = parts[1]
			suffix = ""
		end
		if prefix == delimiter then
			prefix = ""
		end
		if suffix == delimiter then
			suffix = ""
		end
		local sortstart = #prefix
		local sortend = #unnamed - sortstart - #suffix
		local sortables = vim.fn.strpart(unnamed, sortstart, sortend)
		local sorted =
			vim.fn.join(vim.fn.sort(vim.fn.split(sortables, [[\V]] .. vim.fn.escape(delimiter, [[\]]))), delimiter)
		vim.print(sorted)
		vim.cmd(string.format("normal! v`]c%s%s%s", prefix, sorted, suffix))
		vim.cmd("normal! `[")
	elseif mode == "V" then
		vim.cmd(string.format("'<,'>sort %s", sort_motion_flags))
	elseif mode == "" then
		vim.cmd(string.format("'<,'>%s %s", sort_motion_visual_block_command, sort_motion_flags))
	end
end

function M.sort_lines()
	local beginning = vim.fn.line(".")
	local ed = vim.v.count1 + beginning - 1
	vim.cmd(string.format("%d,%dsort %s", beginning, ed, sort_motion_flags))
end

return M
