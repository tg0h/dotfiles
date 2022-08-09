local M = {
    name = "Git",
    -- hunk navigation
    t = {"<CMD>lua require 'gitsigns'.next_hunk()<CR>", "Signs Next Hunk"},
    n = {"<CMD>lua require 'gitsigns'.prev_hunk()<CR>", "Signs Prev Hunk"},

    -- hunk preview
    ["."] = {"<CMD>Gitsigns toggle_linehl<CR>", "Signs Line Highlight"},
    p = {"<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Signs Preview Hunk"},

    -- hunk managemenent
    s = {"<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Signs Stage Hunk"},
    r = {"<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Signs Reset Hunk"},
    u = {"<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk"},
    R = {"<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Signs Reset Buffer"},

    -- lazygit
    l = "Open lazygit", -- comand in toggleterm.lua
    -- n = {"<CMD>Neogit<CR>", "Open Neogit"},

    -- telescope
    g = {"<CMD>Telescope git_status<CR>", "Open changed file"},
    b = {"<CMD>Telescope git_branches<CR>", "Checkout branch"},
    B = {"<CMD>GitBlameToggle<CR>", "Toggle Blame"},
    c = {"<CMD>Telescope git_commits<CR>", "Checkout commit"},
    -- f = {"<CMD>Telescope git_bcommits<CR>", "Checkout commit(for current file)"}

    -- use tabclose to exit diffview file history
    f = {"<CMD>DiffviewFileHistory %<CR>", "Diffview File History"}
}

return M
