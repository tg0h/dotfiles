require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = {gc = "Comments"},
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>" -- binding to scroll up inside the popup
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left" -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = {"j", "k"},
        v = {"j", "k"}
    }
}

local wk = require("which-key")
default_options = {noremap = true, silent = true}

-- register non leader based mappings
wk.register({
    -- x is visual mode
    ga = {"<Plug>(EasyAlign)", "Align", mode = "x"}
})

-- Register all leader based mappings
wk.register({
    -- ["<Tab>"] = {"<cmd>e#<cr>", "Switch to previously opened buffer"},
    q = {
        "<cmd>lua require'tg.quickfix'.ToggleQFList(0)<CR>",
        "Toggle Location List"
    },
    j = {"<cmd>lnext<CR>", "Location List next"},
    k = {"<cmd>lprev<CR>", "Location List prev"},
    b = {
        name = "Buffers",
        b = {
            "<cmd>lua require'telescope.builtin'.buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
            "Find buffer"
        },
        a = {
            "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
            "Close all but the current buffer"
        },
        d = {"<cmd>Bdelete!<CR>", "Close Buffer"},
        f = {"<cmd>BufferLinePick<cr>", "Pick buffer"},
        l = {"<cmd>BufferLineCloseLeft<cr>", "Close all buffers to the left"},
        p = {"<cmd>BufferLineMovePrev<cr>", "Move buffer prev"},
        n = {"<cmd>BufferLineMoveNext<cr>", "Move buffer next"},
        r = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all BufferLines to the right"
        },
        x = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "Sort BufferLines automatically by directory"
        },
        L = {
            "<cmd>BufferLineSortByExtension<cr>",
            "Sort BufferLines automatically by extension"
        }
    },

    d = {
        name = "DAP",
        d = {"<Cmd>lua require'dapui'.toggle()<CR>", "Toggle UI"},
        r = {
            "<Cmd>lua require'dapui'.eval()<CR>", "View dapui cursor expression"
        },
        R = {
            "<Cmd>lua require'dap.ui.widgets'.hover()<CR>",
            "View cursor expression"
        },
        s = {
            "<Cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
            "View Scopes"
        },

        C = {
            "<Cmd>lua require'dap'.clear_breakpoints()<CR>", "Clear breakpoints"
        },

        p = {"<Cmd>lua require'dap'.repl.toggle()<CR>", "REPL toggle"},
        l = {"<Cmd>lua require'dap'.run_last()<CR>", "Run Last"},

        o = {
            "<Cmd>lua require\"telescope\".extensions.dap.commands{}<CR>",
            "Commands"
        },
        c = {
            "<Cmd>lua require\"telescope\".extensions.dap.configurations{}<CR>",
            "Configurations"
        },
        b = {
            "<Cmd>lua require\"telescope\".extensions.dap.list_breakpoints{}<CR>",
            "List breakpoints"
        },
        v = {
            "<Cmd>lua require\"telescope\".extensions.dap.variables{}<CR>",
            "Variables"
        },
        f = {
            "<Cmd>lua require\"telescope\".extensions.dap.frames{}<CR>",
            "Frames"
        }
    },

    f = {
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
    },

    c = {
        name = "Git Worktree",
        g = {
            "<cmd>lua require 'telescope'.load_extension'git_worktree'<CR>",
            "List Worktrees"
        }
    },
    g = {
        name = "Git",
        c = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Signs Next Hunk"},
        r = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Signs Prev Hunk"},
        p = {
            "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
            "Signs Preview Hunk"
        },
        f = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Signs Reset Hunk"},
        R = {
            "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
            "Signs Reset Buffer"
        },
        s = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Signs Stage Hunk"},
        ["."] = {"<cmd>Gitsigns toggle_linehl<CR>", "Signs Line Highlight"},

        l = "Open lazygit", -- comand in toggleterm.lua
        -- n = {"<cmd>Neogit<cr>", "Open Neogit"},
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk"
        },
        g = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        B = {"<cmd>GitBlameToggle<cr>", "Toggle Blame"},
        t = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)"
        }
    },

    h = {
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
        k = {
            "<cmd>lua require('harpoon.ui').nav_previous()<CR>", "Previous mark"
        },

        u = {
            "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",
            "Open Menu"
        }
    },

    l = {
        name = "LSP",
        A = {
            "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
            "Add Workspace Folder"
        },
        D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration"},
        I = {
            "<cmd>lua vim.lsp.buf.implementation()<cr>", "Show implementations"
        },
        K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands"},
        L = {
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
            "List Workspace Folders"
        },
        R = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols"
        },
        W = {
            "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
            "Remove Workspace Folder"
        },
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
        d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition"},
        e = {"<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics"},
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"}, -- use lsp server to format
        i = {"<cmd>LspInfo<cr>", "Connected Language Servers"},
        k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
        l = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics"},
        n = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic"},
        p = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic"},
        q = {"<cmd>lua vim.diagnostic.setloclist()<CR>", "Location List"},
        r = {"<cmd>lua vim.lsp.buf.references()<CR>", "References"},
        s = {"<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols"},
        t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
        w = {"<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics"}
    },

    m = {
        name = "Misc",
        t = {"<cmd>FloatermNew --autoclose=2<cr>", "New Floaterm"},
        s = {"<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline"},
        S = {"<cmd>SidebarNvimToggle<cr>", "Toggle Sidebar"},
        z = {"<cmd>ZenMode<cr>", "Toggle ZenMode"}
    },

    n = {
        name = "Notes",
        h = {
            "<cmd>lua require('setup/telescope').search_wiki_candy()<CR>",
            "Search wiki candy"
        },
        t = {
            "<cmd>lua require('setup/telescope').search_wiki()<CR>",
            "Search wiki"
        }
    },

    s = {
        name = "Search",
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
        s = {"<cmd>Telescope grep_string<cr>", "Text under cursor"},
        S = {"<cmd>Telescope symbols<cr>", "Search symbols"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
        c = {"<cmd>Telescope commands<cr>", "Commands"},
        p = {"<cmd>Telescope projects<cr>", "Projects"},
        P = {
            "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview"
        }
    },

    t = {
        name = "Trouble",
        w = {"<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics"},
        d = {"<cmd>Trouble document_diagnostics<CR>", "Document Diagnostic"},
        l = {"<cmd>Trouble loclist<CR>", "Loclist"},
        q = {"<cmd>Trouble quickfix<CR>", "Quickfix"},
        t = {"<cmd>TodoTrouble<CR>", "Todos"},

        -- use LSP keymaps instead
        r = {"<cmd>Trouble lsp_references<CR>", "LSP References"},
        e = {"<cmd>Trouble lsp_definitions<CR>", "LSP Definitions"},
        o = {"<cmd>Trouble lsp_type_definitions<CR>", "LSP Type Definitions"},

        R = {"<cmd>TroubleRefresh<CR>", "Refresh"},
        s = {"<cmd>TroubleClose<CR>", "Close"},
        h = {"<cmd>TroubleToggle<CR>", "Toggle"}
    },

    w = {
        name = "Window",
        a = {"<C-w><C-o>", "Close all other splits"},
        q = {"<cmd>:q<cr>", "Close"},
        s = {"<cmd>:split<cr>", "Horizontal Split"},
        t = {"<c-w>t", "Move to new tab"},
        ["="] = {"<c-w>=", "Equally size"},
        v = {"<cmd>:vsplit<cr>", "Vertical Split"},
        w = {"<c-w>x", "Swap"},
        z = {"<C-w>_<C-w>|<CR>", "Zoom Split"}
    }
}, {prefix = "<leader>", mode = "n", default_options})
