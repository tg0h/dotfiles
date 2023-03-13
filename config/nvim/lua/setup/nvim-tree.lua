local lib = require('nvim-tree.lib')
local view = require('nvim-tree.view')

local function collapse_all() require('nvim-tree.actions.tree-modifiers.collapse-all').fn() end

local function edit_or_open()
    -- open as vsplit on current node
    local action = 'edit'
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = 'vsplit'
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {

    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true, -- disables netrw completely
    hijack_cursor = false, -- hijack the cursor in the tree to put it at the start of the filename
    hijack_netrw = true, -- hijack netrw window on startup
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    -- open_on_setup = true, -- open the tree when running this setup function
    -- open_on_setup_file = false,
    open_on_tab = false,
    sort_by = 'name',
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,

    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 60,
        -- height = 30,
        hide_root_folder = false,
        side = 'left',
        preserve_window_proportions = false,
        number = true,
        relativenumber = true,
        signcolumn = 'yes',
        mappings = {
            custom_only = true,
            list = {
                {key = {'<CR>', 'o', '<2-LeftMouse>'}, cb = tree_cb('edit')},
                {key = '<C-e>', action = 'edit_in_place'},
                {key = 'O', action = 'edit_no_picker'},
                {key = '<C-v>', cb = tree_cb('vsplit')},
                {key = '<C-x>', cb = tree_cb('split')},
                {key = '<C-t>', cb = tree_cb('tabnew')},
                {key = '<Tab>', cb = tree_cb('preview')}, -- useful home row mappings
                {key = 'D', cb = tree_cb('parent_node')},
                {key = 'h', cb = tree_cb('close_node')},
                {key = 'H', cb = tree_cb('collapse_all')},
                {key = 't', cb = tree_cb('next_sibling')},
                {key = 'T', cb = tree_cb('last_sibling')},
                {key = 'n', cb = tree_cb('prev_sibling')},
                {key = 'N', cb = tree_cb('first_sibling')},
                {key = 'l', action = 'edit', action_cb = edit_or_open},
                {key = 'L', action = 'vsplit_preview', action_cb = vsplit_preview},
                {key = '-', cb = tree_cb('dir_up')},

                {key = 'E', action = 'expand_all'},
                {key = {'<2-RightMouse>', '<C-]>', '_'}, cb = tree_cb('cd')},

                {key = '<A-g>', cb = tree_cb('prev_git_item')},
                {key = '<A-r>', cb = tree_cb('next_git_item')},

                {key = '[e', action = 'prev_diag_item'},
                {key = ']e', action = 'next_diag_item'},

                {key = 'I', action = 'toggle_git_ignored'},
                {key = 'i', cb = tree_cb('toggle_ignored')},
                {key = '.', cb = tree_cb('toggle_dotfiles')},
                {key = 'U', action = 'toggle_custom'},

                {key = 'A', cb = tree_cb('search_node')},
                {key = 'R', cb = tree_cb('refresh')},
                {key = 'a', cb = tree_cb('create')},
                {key = 'd', cb = tree_cb('remove')},
                {key = 'r', cb = tree_cb('rename')},
                {key = '<C-r>', cb = tree_cb('full_rename')},
                {key = 'x', cb = tree_cb('cut')},
                {key = 'c', cb = tree_cb('copy')},
                {key = 'p', cb = tree_cb('paste')},
                {key = 'y', cb = tree_cb('copy_name')},
                {key = 'Y', cb = tree_cb('copy_path')},
                {key = 'gy', cb = tree_cb('copy_absolute_path')},
                {key = '\'', cb = tree_cb('system_open')}, -- avoid clash with lightspeed

                {key = 'q', cb = tree_cb('close')},
                {key = 'u', action = 'toggle_file_info'},
                {key = 'g?', cb = tree_cb('toggle_help')},
                {key = 'f', action = 'live_filter'},
                {key = 'F', action = 'clear_live_filter'}, -- { key = ".", action = "run_file_command" },
                {key = 'm', action = 'toggle_mark'}
            }
        },
        float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {relative = 'editor', border = 'rounded', width = 30, height = 30, row = 1, col = 1}
        }
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = 'none',
        root_folder_modifier = ':~',
        indent_markers = {enable = false, icons = {corner = '└', edge = '│', item = '│', none = ' '}},
        icons = {
            webdev_colors = true,
            git_placement = 'before',
            padding = ' ',
            symlink_arrow = ' ➛ ',
            show = {file = true, folder = true, folder_arrow = true, git = true},
            glyphs = {
                default = '',
                symlink = '',
                bookmark = '',
                folder = {
                    arrow_closed = '',
                    arrow_open = '',
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                    symlink_open = ''
                },
                git = {
                    unstaged = '',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    untracked = 'U',
                    deleted = '',
                    ignored = '◌'
                }
            }
        },
        special_files = {'Cargo.toml', 'Makefile', 'README.md', 'readme.md'},
        symlink_destination = true
    },

    hijack_directories = {enable = true, auto_open = true},
    update_focused_file = {enable = true, update_root = true, ignore_list = {}},
    ignore_ft_on_setup = {}, -- will not open on setup if the filetype is in this list
    system_open = {cmd = '', args = {}},
    diagnostics = { -- show lsp diagnostics in the signcolumn
        enable = false,
        show_on_dirs = false,
        icons = {hint = '', info = '', warning = '', error = ''}
    },
    filters = {dotfiles = false, custom = {}, exclude = {}},
    filesystem_watchers = {enable = true, debounce_delay = 50},
    git = {enable = true, ignore = true, show_on_dirs = true, timeout = 400},
    actions = {
        use_system_clipboard = true,
        change_dir = {enable = true, global = false, restrict_above_cwd = false},
        expand_all = {max_folder_discovery = 300, exclude = {}},
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = false,
                chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                exclude = {
                    filetype = {'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame'},
                    buftype = {'nofile', 'terminal', 'help'}
                }
            }
        },
        remove_file = {close_window = true}
    },

    trash = {cmd = 'gio trash', require_confirm = true},
    live_filter = {prefix = '[FILTER]: ', always_show_folders = true},
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false
        }
    }
}
