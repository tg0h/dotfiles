return {
  'nvim-pack/nvim-spectre',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    local wk = require('which-key')
    wk.register({
      z = { 'spectre' },
    }, { prefix = '<leader>', mode = 'n', {} })
  end,
  -- enabled = vim.g.config.plugins.spectre.enable,
  keys = {
    {
      '<leader>zz',
      function() require('spectre').toggle() end,
      desc = 'Toggle search and replace',
    },
    {
      '<leader>zw',
      function() require('spectre').open_visual({ select_word = true }) end,
      desc = 'Search current word',
    },
    {
      '<leader>zw',
      mode = 'v',
      function() require('spectre').open_visual({ select_word = true }) end,
      desc = 'Search current word',
    },
    {
      '<leader>zf',
      function() require('spectre').open_file_search({ select_word = true }) end,
      desc = 'Search on current file',
    },
  },
  opts = {

    color_devicons = true,
    open_cmd = 'new', -- instead of vnew, use new to open a new horizontal window
    live_update = false, -- auto execute search again when you write to any file in vim
    line_sep_start = '┌-----------------------------------------',
    result_padding = '¦  ',
    line_sep = '└-----------------------------------------',
    highlight = {
      ui = 'String',
      search = 'DiffChange',
      replace = 'DiffDelete',
    },
    mapping = {
      ['tab'] = {
        map = '<Tab>',
        cmd = "<cmd>lua require('spectre').tab()<cr>",
        desc = 'next query',
      },
      ['shift-tab'] = {
        map = '<S-Tab>',
        cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
        desc = 'previous query',
      },
      ['toggle_line'] = {
        map = 'dd',
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = 'toggle item',
      },
      ['enter_file'] = {
        map = '<cr>',
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = 'open file',
      },
      ['send_to_qf'] = {
        map = '<leader>q',
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = 'send all items to quickfix',
      },
      ['replace_cmd'] = {
        map = '<leader>c',
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = 'input replace command',
      },
      ['show_option_menu'] = {
        map = '<leader>o',
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = 'show options',
      },
      ['run_current_replace'] = {
        map = 'rc',
        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
        desc = 'replace current line',
      },
      ['run_replace'] = {
        map = 'ra',
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = 'replace all',
      },
      ['change_view_mode'] = {
        map = '<C-g>',
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = 'change result view mode',
      },
      ['change_replace_sed'] = {
        map = 'trs',
        cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
        desc = 'use sed to replace',
      },
      ['change_replace_oxi'] = {
        map = 'tro',
        cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
        desc = 'use oxi to replace',
      },
      ['toggle_live_update'] = {
        map = 'tu',
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = 'update when vim writes to file',
      },
      ['toggle_ignore_case'] = {
        map = 'ti',
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = 'toggle ignore case',
      },
      ['toggle_ignore_hidden'] = {
        map = 'th',
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = 'toggle search hidden',
      },
      ['resume_last_search'] = {
        map = 'rr',
        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
        desc = 'repeat last search',
      },
      -- you can put your mapping here it only use normal mode
    },
    find_engine = {
      -- rg is map with finder_cmd
      ['rg'] = {
        cmd = 'rg',
        -- default args
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
          -- you can put any rg search option you want here it can toggle with
          -- show_option function
        },
      },
      ['ag'] = {
        cmd = 'ag',
        args = {
          '--vimgrep',
          '-s',
        },
        options = {
          ['ignore-case'] = {
            value = '-i',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
        },
      },
    },
    replace_engine = {
      ['sed'] = {
        cmd = 'gsed',
        args = nil,
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
        },
      },
      -- call rust code by nvim-oxi to replace
      ['oxi'] = {
        cmd = 'oxi',
        args = {},
        options = {
          ['ignore-case'] = {
            value = 'i',
            icon = '[I]',
            desc = 'ignore case',
          },
        },
      },
    },
    default = {
      find = {
        --pick one of item in find_engine
        cmd = 'rg',
        options = { 'ignore-case' },
      },
      replace = {
        --pick one of item in replace_engine
        cmd = 'sed',
      },
    },
    replace_vim_cmd = 'cdo',
    is_open_target_win = true, --open file on opener window
    is_insert_mode = false, -- start open panel on is_insert_mode
    is_block_ui_break = false, -- mapping backspace and enter key to avoid ui break
  },
}
