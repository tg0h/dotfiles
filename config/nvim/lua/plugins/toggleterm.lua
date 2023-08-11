return {
  'akinsho/nvim-toggleterm.lua',
  keys = {
    { '<C-Bslash>', '<CMD>ToggleTerm', desc = 'open toggleterm' },
  },
  config = function()
    require('toggleterm').setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == 'horizontal' then
          return 30
        -- return vim.o.rows * 0.4
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      -- kitty maps C-- to C-\, so use C-\ to open toggleterm
      open_mapping = [[<C-Bslash>]], -- NOTE: opens toggleterm!
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
      shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = 'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'single', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- width = <value>,
        -- height = <value>,
        winblend = 3,
        highlights = { border = 'Normal', background = 'Normal' },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    })
    -- local Terminal = require('toggleterm.terminal').Terminal
    -- local lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })
    -- function _lazygit_toggle()
    --   lazygit:toggle()
    -- end
    --
    -- vim.api.nvim_set_keymap('n', '<leader>gl', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true }) -- start lazygit
    vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true }) -- back to normal mode in Terminal
  end,
}
