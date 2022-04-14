local M = {
    q = {
        "<cmd>lua require'tg.quickfix'.ToggleQFList(0)<CR>",
        "Toggle Location List"
    },
    j = {"<cmd>lnext<CR>", "Location List next"},
    k = {"<cmd>lprev<CR>", "Location List prev"},

    l = require("setup.which-key.keys.lsp"),
    b = require("setup.which-key.keys.buffers"),
    c = require("setup.which-key.keys.neoclip"),
    f = require("setup.which-key.keys.files"),
    d = require("setup.which-key.keys.dap"),
    g = require("setup.which-key.keys.git"),
    r = require("setup.which-key.keys.git-worktree"),
    h = require("setup.which-key.keys.harpoon"),
    m = require("setup.which-key.keys.misc"),
    n = require("setup.which-key.keys.notes"),
    s = require("setup.which-key.keys.search"),
    t = require("setup.which-key.keys.trouble"),
    w = require("setup.which-key.keys.window")
}
return M
