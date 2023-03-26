local M = {
  name = 'Search',
  ['.'] = {
    "<CMD>lua require('setup/telescope').bookmarks(require('telescope.themes').get_dropdown {})<CR>",
    'My Bookmarks',
  },

  b = { '<cmd>Telescope builtin<CR>', 'Telescope builtin' },
  C = { '<cmd>Telescope colorscheme<CR>', 'Colorscheme' },
  o = { "<cmd>lua require('setup/telescope').search_dotfiles()<CR>", 'Search dotfiles' },
  e = { "<cmd>lua require('setup/telescope').search_neovim_dotfiles()<CR>", 'Search Neovim dotfiles' },
  h = { '<cmd>Telescope git_files<CR>', 'Git files' },
  u = { '<cmd>Telescope help_tags<CR>', 'Find Help' },
  H = { '<cmd>Telescope heading<CR>', 'Find Header' },
  M = { '<cmd>Telescope man_pages<CR>', 'Man Pages' },
  q = { "<cmd>lua require'telescope.builtin'.quickfix{}<CR>", 'Search quickfix' },
  R = { '<cmd>Telescope registers<CR>', 'Registers' },
  t = { '<cmd>Telescope live_grep<CR>', 'Text' },
  T = { '<CMD>Telescope current_buffer_fuzzy_find<CR>', 'Text - Current Buffer' },
  s = { '<cmd>Telescope grep_string<CR>', 'Text under cursor' },
  S = { '<cmd>Telescope symbols<CR>', 'Search symbols' },
  k = { '<cmd>Telescope keymaps<CR>', 'Keymaps' },
  c = { '<cmd>Telescope commands<CR>', 'Commands' },
  p = { '<cmd>Telescope projects<CR>', 'Projects' },
  P = {
    "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
    'Colorscheme with Preview',
  },
}
return M
