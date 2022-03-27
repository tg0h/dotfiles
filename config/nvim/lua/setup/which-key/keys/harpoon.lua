local M = {
    name = "Harpoon",
    s = {"<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file"},

    o = {
        "<cmd>lua require('harpoon.tmux').gotoTerminal(2)<CR>",
        "go to Tmux Window 2"
    },

    e = {
        "<cmd>lua require('harpoon.tmux').gotoTerminal(3)<CR>",
        "go to Tmux Window 3"
    },

    [","] = {
        "<cmd>lua require('harpoon.tmux').sendCommand(2, 1)<CR>",
        "Send Command to Tmux Window 2"
    },

    ["."] = {
        "<cmd>lua require('harpoon.tmux').sendCommand(3, 1)<CR>",
        "Send Command to Tmux Window 3"
    },

    t = {
        "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>",
        "Go to Terminal 1"
    },
    n = {
        "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>",
        "Go to Terminal 2"
    },
    c = {
        "<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>",
        "Send Command 1 to Terminal 1"
    },
    r = {
        "<cmd>lua require('harpoon.term').sendCommand(2, 1)<CR>",
        "Send Command 1 to Terminal 2"
    },
    d = {"<cmd>Telescope harpoon marks<CR>", "Telescope harpoon marks"},

    j = {"<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next mark"},
    k = {"<cmd>lua require('harpoon.ui').nav_previous()<CR>", "Previous mark"},

    u = {
        "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",
        "Open Menu"
    }
}
return M
