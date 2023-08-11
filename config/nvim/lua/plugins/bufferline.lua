return {
  'akinsho/nvim-bufferline.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    require('bufferline').setup({
      options = {
        -- do not show the buffer id
        numbers = function(opts)
          return string.format('%s%s', opts.ordinal, opts.raise(opts.id)) -- :h bufferline-numbers
        end,
        close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return '(' .. count .. ')'
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
            return true
          end
          -- filter out by buffer name
          if vim.fn.bufname(buf_number) ~= 'No Name' then
            return true
          end
          -- filter out based on arbitrary rules
          -- e.g. filter out vim wiki buffer from tabline in your work repo
          if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
            return true
          end
        end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'center', padding = 1 } },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        -- sort_by = 'id',
        sort_by = 'insert_after_current',
        -- sort_by = 'insert_after_current'
        --   | 'insert_at_end'
        --   | 'id'
        --   | 'extension'
        --   | 'relative_directory'
        --   | 'directory'
        --   | 'tabs'
        --   | function(buffer_a, buffer_b)
        --     -- add custom logic
        --     return buffer_a.modified > buffer_b.modified
        --   end,
      },
    })

    local bufferline = require('bufferline')
    vim.keymap.set('n', '<LEADER>nB.', bufferline.pick, { desc = 'bufferline pick' })
    vim.keymap.set('n', '<LEADER>nBd', function()
      bufferline.sort_by('directory')
    end, { desc = 'bufferline sort by dir' })
    vim.keymap.set('n', '<LEADER>nBs', function()
      bufferline.sort_by('extension')
    end, { desc = 'bufferline sort by dir' })
    -- vim.keymap.set('n', '<LEADER>bs', bufferline.sort_by('extension'), { desc = 'bufferline sort by extension' })

    -- Buffers
    -- vim.keymap.set("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)
    -- vim.keymap.set('n', '<A-CR>', ':e#<CR>', default_options) -- edit previously opened buffer (or C-^)

    -- nnorevim.keymap.set <silent><leader>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>

    -- go to nth visible buffer, not by absolute position
    vim.keymap.set('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', { desc = 'go to buffer 1' })
    vim.keymap.set('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', { desc = 'go to buffer 2' })
    vim.keymap.set('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', { desc = 'go to buffer 3' })
    vim.keymap.set('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', { desc = 'go to buffer 4' })
    vim.keymap.set('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', { desc = 'go to buffer 5' })
    vim.keymap.set('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', { desc = 'go to buffer 6' })
    -- vim.keymap.set('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', default_options)
    -- vim.keymap.set('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', default_options)
    -- vim.keymap.set('n', '<A-9>', ':BufferLineGoToBuffer 9<CR>', default_options)

    vim.keymap.set('n', '<S-A-4>', ':BufferLineGoToBuffer -1<CR>', { desc = 'go to last buffer' }) -- A-$

    vim.keymap.set('n', '<A-g>', ':BufferLineCyclePrev<CR>', { desc = 'go to previous buffer' }) -- go to left buffer
    vim.keymap.set('n', '<A-r>', ':BufferLineCycleNext<CR>', { desc = 'go to next buffer' }) -- go to right buffer

    vim.keymap.set('n', '<S-A-9>', ':BufferLineMovePrev<CR>', { desc = 'move to previous buffer' })
    vim.keymap.set('n', '<S-A-[>', ':BufferLineMoveNext<CR>', { desc = 'move to next buffer' })

    vim.keymap.set('n', '<A-8>', ':BufferLineCloseLeft<CR>', { desc = 'close buffers to the left' })
    vim.keymap.set('n', '<A-9>', ':BufferLineCloseRight<CR>', { desc = 'close buffers to the right' })
    vim.keymap.set(
      'n',
      '<A-0>',
      ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>',
      { desc = 'close all except current buffer' }
    )
  end,
}
