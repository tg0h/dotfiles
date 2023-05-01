local M = {
  name = 'Search',
  ['.'] = {
    "<CMD>lua require('setup/telescope').bookmarks(require('telescope.themes').get_dropdown {})<CR>",
    'My Bookmarks',
  },

  o = { "<cmd>lua require('setup/telescope').search_dotfiles()<CR>", 'Search dotfiles' },
  e = { "<cmd>lua require('setup/telescope').search_neovim_dotfiles()<CR>", 'Search Neovim dotfiles' },
  m = { '<cmd>Telescope man_pages<CR>', 'Man Pages' },
  t = { '<cmd>Telescope live_grep<CR>', 'Text' },
  b = { '<CMD>Telescope current_buffer_fuzzy_find<CR>', 'Text - Current Buffer' },
  s = { "<cmd>lua require('setup/telescope').my_grep_string_no_input()<CR>", 'Text under cursor' },
  -- p = { '<cmd>Telescope projects<CR>', 'Projects' },
  -- P = {
  --   "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
  --   'Colorscheme with Preview',
  -- },
}
return M
