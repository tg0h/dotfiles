local g = vim.g

-- https://github.com/kyazdani42/nvim-tree.lua
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

-- vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<localleader>s', ':NvimTreeFindFile<CR>', {noremap = true})

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")


local function collapse_all()
    require("nvim-tree.actions.collapse-all").fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1, folder_arrows = 1}
g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌"
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = ""
    }
}

local tree_cb = require"nvim-tree.config".nvim_tree_callback
require"nvim-tree".setup {

    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    open_on_tab = false,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = false,
    -- update_to_buf_dir = {enable = true, auto_open = true},

    -- show lsp diagnostics in the signcolumn
    diagnostics = {
        enable = false,
        icons = {hint = "", info = "", warning = "", error = ""}
    },

    update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},

    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {}
    },

    trash = {cmd = "trash", require_confirm = false},

    filters = {dotfiles = false, custom = {}},

    git = {enable = true, ignore = true, timeout = 500},

    view = {
        number = true,
        relativenumber = true,
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        -- auto_resize = true,
        signcolumn = "yes",

        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = true,
            -- list of mappings to set on the tree manually
            list = {
                {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},

                {key = "<C-v>", cb = tree_cb("vsplit")},
                {key = "<C-x>", cb = tree_cb("split")},
                {key = "<C-t>", cb = tree_cb("tabnew")},
                {key = "<Tab>", cb = tree_cb("preview")},

                -- useful home row mappings
                {key = "D", cb = tree_cb("parent_node")},
                {key = "h", cb = tree_cb("close_node")},
                {key = "H", cb = tree_cb("collapse_all")},
                {key = "t", cb = tree_cb("next_sibling")},
                {key = "T", cb = tree_cb("last_sibling")},
                {key = "n", cb = tree_cb("prev_sibling")},
                {key = "N", cb = tree_cb("first_sibling")},
                { key = "l", action = "edit", action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },

                {key = "-", cb = tree_cb("dir_up")},
                {key = {"<2-RightMouse>", "<C-]>", "_"}, cb = tree_cb("cd")},

                {key = "<A-g>", cb = tree_cb("prev_git_item")},
                {key = "<A-r>", cb = tree_cb("next_git_item")},

                {key = "i", cb = tree_cb("toggle_ignored")},
                {key = ".", cb = tree_cb("toggle_dotfiles")},

                {key = "A", cb = tree_cb("search_node")},

                {key = "R", cb = tree_cb("refresh")},
                {key = "a", cb = tree_cb("create")},
                {key = "d", cb = tree_cb("remove")},
                {key = "r", cb = tree_cb("rename")},
                {key = "<C-r>", cb = tree_cb("full_rename")},
                {key = "x", cb = tree_cb("cut")},
                {key = "c", cb = tree_cb("copy")},
                {key = "p", cb = tree_cb("paste")},
                {key = "y", cb = tree_cb("copy_name")},
                {key = "Y", cb = tree_cb("copy_path")},
                {key = "gy", cb = tree_cb("copy_absolute_path")},

                {key = "'", cb = tree_cb("system_open")}, -- avoid clash with lightspeed

                {key = "q", cb = tree_cb("close")},
                {key = "u", action = "toggle_file_info" },
                {key = "g?", cb = tree_cb("toggle_help")},
                -- { key = ".", action = "run_file_command" }
            }
        }
    },
    actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  },
}
