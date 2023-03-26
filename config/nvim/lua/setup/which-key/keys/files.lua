local M = {
  name = 'Files',
  b = { '<CMD>Telescope file_browser<CR>', 'File browser' },
  f = {
    "<CMD>lua require'telescope.builtin'.find_files({ find_command = {'fd', '--hidden', '--type', 'file', '--follow'}})<CR>",
    'Find File',
  },
  l = { '<CMD>Lf<CR>', 'Open LF' },
  -- r = {"<CMD>Telescope frecency<CR>", "Open Frecent File"},
  r = {
    -- "<CMD>lua require('telescope').extensions.frecency.frecency(require('setup.telescope').no_preview())<CR>",
    "<CMD>lua require('telescope').extensions.frecency.frecency(require('setup.telescope').big_window())<CR>",
    'Open Frecent File',
  },
  o = { '<CMD>Telescope oldfiles<CR>', 'Open Old Files' },
  s = { '<CMD>w<CR>', 'Save Buffer' },
  T = { '<CMD>NvimTreeFindFile<CR>', 'Find in Tree' },
  -- z = {"<CMD>Telescope zoxide list<CR>", "Zoxide"}
}
return M
