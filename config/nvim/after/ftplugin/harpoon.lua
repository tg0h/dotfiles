-- wo - window specific option
vim.wo.cursorline = true
-- show absolute line numbers for easier reference
vim.wo.relativenumber = false

-- highlight the 5th line
local bufnr = vim.api.nvim_get_current_buf()
vim.fn.sign_define('my_sign', { text = ' ', texthl = 'Search', linehl = '', numhl = '' })
vim.fn.sign_place(0, 'my_sign', 'my_sign', bufnr, { lnum = 5, priority = 100 })

vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', ':move +1<CR>', { desc = 'move harpoon menu item down' })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', ':move -2<CR>', { desc = 'move harpoon menu item up' })

-- vim.api.nvim_buf_set_keymap(0, 'n', '2', '2G<CR>', { desc = 'open harpoon item 2' })

-- " Background colors for active vs inactive windows
-- hi ActiveWindow guibg=#17252c
-- hi InactiveWindow guibg=#0D1B22

-- https://neovim.io/doc/user/api.html#nvim_buf_add_highlight()
local ns_id = vim.api.nvim_create_namespace(vim.bo.filetype)

-- vim.api.nvim_set_hl(0, 'HarpoonFrontend', { fg = '#00ff00', bg = '#f44336' })
vim.api.nvim_set_hl(ns_id, 'HarpoonFrontend', { fg = '#00ff00' })
vim.api.nvim_set_hl(ns_id, 'HarpoonFrontendPages', { fg = '#ffccff' })
vim.api.nvim_set_hl(ns_id, 'HarpoonFrontendComponents', { fg = '#0080ff' })
vim.api.nvim_set_hl(ns_id, 'HarpoonFrontendWonka', { bg = '#7f00ff' })
-- vim.api.nvim_set_hl(ns_id, 'HarpoonFrontendWonkaPages', { fg = '#ffccff' })
-- vim.api.nvim_set_hl(ns_id, 'HarpoonFrontendWonkaComponents', { fg = '#0080ff' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServices', { fg = '#ffcc99' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServicesServices', { fg = '#ff8000' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServicesWonka', { bg = '#7f00ff' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServicesModels', { fg = '#6666ff' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServicesRepositories', { fg = '#000000', bg = '#e0e0e0' })
vim.api.nvim_set_hl(ns_id, 'HarpoonCommonServicesTests', { fg = '#ff00ff' })

vim.api.nvim_set_hl(ns_id, 'HarpoonApi', { fg = '#ffff00' })

vim.api.nvim_set_hl(ns_id, 'HarpoonCommonLib', { fg = '#000000', bg = '#3399ff' })

vim.api.nvim_set_hl(ns_id, 'HarpoonInfra', { fg = '#000000', bg = '#ff8000' })

local highlightConfig = {
  api = {
    api = 'HarpoonApi',
    ['%.test%.'] = 'HarpoonCommonServicesTests', -- highlight file.test.ts
  },
  frontend = {
    frontend = 'HarpoonFrontend',
    pages = 'HarpoonFrontendPages',
    components = 'HarpoonFrontendComponents',
  },
  ['frontend%-wonka'] = {
    ['frontend%-wonka'] = 'HarpoonFrontendWonka',
    pages = 'HarpoonFrontendPages',
    components = 'HarpoonFrontendComponents',
  },
  ['common%-services'] = {
    ['common%-services'] = 'HarpoonCommonServices',
    services = 'HarpoonCommonServicesServices',
    wonka = 'HarpoonCommonServicesWonka',
    models = 'HarpoonCommonServicesModels',
    repositories = 'HarpoonCommonServicesRepositories',
    tests = 'HarpoonCommonServicesTests',
    ['%.test%.'] = 'HarpoonCommonServicesTests', -- highlight file.test.ts
  },
  ['common%-lib'] = {
    ['common%-lib'] = 'HarpoonCommonLib',
  },
  ['infra'] = {
    ['infra'] = 'HarpoonInfra',
  },
}

-- vim.api.nvim_set_hl(ns, group, hl_args)
-- vim.api.nvim_buff_add_highlight(0, ns_id)

vim.api.nvim_set_hl_ns(ns_id)
vim.api.nvim_win_set_hl_ns(0, ns_id)

local function highlight_line(line_index, line, highlightConfig)
  -- print('line index 🔴' .. line_index)
  for package, packageConfig in pairs(highlightConfig) do
    -- print('package ' .. package)
    local packageStart, packageEnd = string.find(line, package)
    if packageStart ~= nil and packageEnd ~= nil then
      local packageHighlightGroup = packageConfig[package]
      vim.api.nvim_buf_add_highlight(bufnr, ns_id, packageHighlightGroup, line_index - 1, packageStart - 1, packageEnd)
      -- print('packageStart ' .. packageStart)
      -- print('packageEnd ' .. packageEnd)
      for string, highlightGroup in pairs(packageConfig) do
        -- print('string is ' .. string)
        -- print('highlightGroup is ' .. highlightGroup)
        -- print('packgaeEnd is ' .. packageEnd)
        local _start, _end = string.find(line, string, packageEnd) --- only start searching for the package component after the package ends ... eg common-services/services ... start searching for services after common-services
        if _start ~= nil and _end ~= nil then
          -- print('start is ' .. _start)
          -- print('end is ' .. _end)
          vim.api.nvim_buf_add_highlight(bufnr, ns_id, highlightGroup, line_index - 1, _start - 1, _end)
        end
      end
    end
  end
end

local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
for line_index, line in ipairs(lines) do
  highlight_line(line_index, line, highlightConfig)
end
