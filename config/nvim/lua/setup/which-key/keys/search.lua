local M = {
    name = "Search",
    ["."] = {
        "<CMD>lua require('setup/telescope').bookmarks(require('telescope.themes').get_dropdown {})<CR>",
        "My Bookmarks"
    },

    b = {"<cmd>Telescope builtin<CR>", "Telescope builtin"},
    C = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
    o = {
        "<cmd>lua require('setup/telescope').search_dotfiles()<CR>",
        "Search dotfiles"
    },
    e = {
        "<cmd>lua require('setup/telescope').search_neovim_dotfiles()<CR>",
        "Search Neovim dotfiles"
    },
    h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
    H = {"<cmd>Telescope heading<cr>", "Find Header"},
    M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
    R = {"<cmd>Telescope registers<cr>", "Registers"},
    t = {"<cmd>Telescope live_grep<cr>", "Text"},
    T = {
        "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Text - Current Buffer"
    },
    s = {"<cmd>Telescope grep_string<cr>", "Text under cursor"},
    S = {"<cmd>Telescope symbols<cr>", "Search symbols"},
    k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
    c = {"<cmd>Telescope commands<cr>", "Commands"},
    p = {"<cmd>Telescope projects<cr>", "Projects"},
    P = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview"
    }
}
return M
