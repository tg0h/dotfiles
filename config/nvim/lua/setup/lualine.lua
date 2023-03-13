require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'powerline_dark',
        -- theme = 'auto',
        -- a component is an element in a section
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = {'mode'}, -- Vim normal, etc mode
        lualine_b = {{'b:gitsigns_head', icon = ''}, 'diff'}, -- display the gitsigns plugin buffer variable
        lualine_c = {
            {
                'filename',
                file_status = true, -- show readonly/modified status
                path = 1, -- show relative path
                shorting_target = 40,
                symbols = {modified = '[+]', readonly = ' '} -- copied icon from https://www.nerdfonts.com/cheat-sheet
            }
        },
        lualine_x = {
            {'diagnostics', sources = {'nvim_diagnostic'}}, -- LSP diagnostics
            'encoding',
            'fileformat',
            'filetype'
        },
        lualine_y = {'progress'}, -- percentage of file shown
        lualine_z = {'location'} -- which file line and column
    },
    inactive_sections = { -- what to show if window is not active
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    -- extensions = {"nvim-tree", "toggleterm", "quickfix", "symbols-outline"}
    extensions = {'nvim-tree'}
}
