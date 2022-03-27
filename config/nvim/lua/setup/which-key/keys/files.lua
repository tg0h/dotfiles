local M = {
    name = "Files",
    b = {"<cmd>Telescope file_browser<cr>", "File browser"},
    f = {
        "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'fd', '--hidden', '--type', 'file', '--follow'}})<cr>",
        "Find File"
    },
    l = {"<cmd>Lf<cr>", "Open LF"},
    -- p = {"<cmd>NvimTreeToggle<cr>", "Toggle Tree"},
    r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
    s = {"<cmd>w<cr>", "Save Buffer"},
    T = {"<cmd>NvimTreeFindFile<CR>", "Find in Tree"}
    -- z = {"<cmd>Telescope zoxide list<CR>", "Zoxide"}
}
return M
