-- autoload/sort_motion.vim

local sort_motion_flags = vim.g.sort_motion_flags

local M = {}

function M.sort_motion(mode)
	local sort_motion_visual_block_command = vim.g.sort_motion_visual_block_command or "sort"

  if mode == 'line'
	  vim.cmd(string.format([[execute "'[,']sort %"]], sort_motion_flags))
  elseif mode == 'char'
    vim.cmd([[execute "normal! `[v`]y"]])
    local startpos = match(@@, '\v\i')
    local parts = split(@@, '\v\i+')
	local prefix, delimiter, suffix
    if startpos > 0
      prefix = parts[0]
      delimiter = parts[1]
      suffix = parts[-1]
    else
      prefix = ''
      delimiter = parts[0]
      suffix = ''
    end
    if prefix == delimiter
      prefix = ''
    end
    if suffix == delimiter
      suffix = ''
    end
    local sortstart = strlen(prefix)
    local sortend = strlen(@@) - sortstart - strlen(suffix)
    local sortables = strpart(@@, sortstart, sortend)
    local sorted = join(sort(split(sortables, '\V' . escape(delimiter, '\'))), delimiter)
    execute "normal! v`]c" . prefix . sorted . suffix
    execute "normal! `["
  elseif a:mode == 'V'
    execute "'<,'>sort " . s:sort_motion_flags
  elseif a:mode ==# ''
    execute "'<,'>".l:sort_motion_visual_block_command.' '.s:sort_motion_flags
  endif
endfunction

function! sort_motion#sort_lines() abort
  let beginning = line('.')
  let end = v:count1 + beginning - 1
  execute beginning . ',' . end . 'sort ' . s:sort_motion_flags
endfunction
