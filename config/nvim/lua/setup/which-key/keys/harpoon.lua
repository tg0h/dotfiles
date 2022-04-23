local M = {
    name = "Harpoon",
    b = {"<CMD>lua require('harpoon.dev').reload()<CR>", "Reload Harpoon"},

    s = {"<CMD>lua require('harpoon.mark').add_file()<CR>", "Add file"},

    o = {
        "<CMD>lua require('harpoon.tmux').gotoTerminal(2)<CR>",
        "go to Tmux Window 2"
    },

    e = {
        "<CMD>lua require('harpoon.tmux').gotoTerminal(3)<CR>",
        "go to Tmux Window 3"
    },

    [","] = {
        "<CMD>lua require('harpoon.tmux').sendCommand(2, 1)<CR>",
        "Send Command to Tmux Window 2"
    },

    ["."] = {
        "<CMD>lua require('harpoon.tmux').sendCommand(3, 1)<CR>",
        "Send Command to Tmux Window 3"
    },

    t = {
        "<CMD>lua require('harpoon.term').gotoTerminal(1)<CR>",
        "Go to Terminal 1"
    },
    n = {
        "<CMD>lua require('harpoon.term').gotoTerminal(2)<CR>",
        "Go to Terminal 2"
    },
    c = {
        "<CMD>lua require('harpoon.term').sendCommand(1, 1)<CR>",
        "Send Command 1 to Terminal 1"
    },
    r = {
        "<CMD>lua require('harpoon.term').sendCommand(2, 1)<CR>",
        "Send Command 1 to Terminal 2"
    },
    d = {"<CMD>Telescope harpoon marks<CR>", "Telescope harpoon marks"},

    j = {"<CMD>lua require('harpoon.ui').nav_next()<CR>", "Next mark"},
    k = {"<CMD>lua require('harpoon.ui').nav_previous()<CR>", "Previous mark"},

    u = {
        "<CMD>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",
        "Open Menu"
    }
}
return M
