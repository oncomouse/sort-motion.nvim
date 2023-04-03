-- autoload/sort_motion.vim

local sort_motion_flags = vim.g.sort_motion_flags

local M = {}

function M.sort_motion(mode)
	local sort_motion_visual_block_command = vim.g.sort_motion_visual_block_command or "sort"

  if mode == 'line' then
	  vim.cmd(string.format([[execute "'[,']sort %"]], sort_motion_flags))
  elseif mode == 'char' then
	  local unnamed = table.concat(vim.fn.getreginfo([["]]).regcontents, "\n")
    vim.cmd([[execute "normal! `[v`]y"]])
    local startpos = vim.fn.match(unnamed, [[\v\i]])
    local parts = vim.fn.split(unnamed, [[\v\i+]])
	local prefix, delimiter, suffix
    if startpos > 0 then
      prefix = parts[0]
      delimiter = parts[1]
      suffix = parts[-1]
    else
      prefix = ''
      delimiter = parts[0]
      suffix = ''
    end
    if prefix == delimiter then
      prefix = ''
    end
    if suffix == delimiter then
      suffix = ''
    end
    local sortstart = #prefix
    local sortend = #unnamed - sortstart - #suffix
    local sortables = vim.fn.strpart(unnamed, sortstart, sortend)
    local sorted = vim.fn.join(vim.fn.sort(vim.fn.split(sortables, [[\V]] .. vim.fn.escape(delimiter, [[\]]))), delimiter)
    vim.cmd(string.format([[execute "normal! v`]c%s%s%"]] , prefix , sorted , suffix))
    vim.cmd([[execute "normal! `["]])
  elseif mode == 'V' then
    vim.cmd(string.format([[execute "'<,'>sort %s"]],sort_motion_flags))
  elseif mode == '' then
    vim.cmd(string.format([[execute "'<,'>%s %s"]],sort_motion_visual_block_command, sort_motion_flags))
  end
end

function M.sort_lines()
  local beginning = vim.fn.line('.')
  local ed = vim.v.count1 + beginning - 1
  vim.cmd([[execute %d,%dsort %s]], beginning, ed, sort_motion_flags)
end

return M
