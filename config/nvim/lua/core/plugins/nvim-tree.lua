local M = {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local lib = require('nvim-tree.lib')
    local view = require('nvim-tree.view')
    local api = require('nvim-tree.api')

    local function collapse_all()
      require('nvim-tree.actions.tree-modifiers.collapse-all').fn()
    end

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

    local function previous_sibling_preview()
      -- local node = lib.get_node_at_cursor()
      api.node.navigate.sibling.prev()
      api.node.open.preview()
    end

    local function next_sibling_preview()
      -- local node = lib.get_node_at_cursor()
      api.node.navigate.sibling.next()
      api.node.open.preview()
    end

    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place')) -- open in same pane as nvim tree
      vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))

      vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))

      -- useful home row mappings
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
      vim.keymap.set('n', 'D', api.node.navigate.parent, opts('Parent Directory'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))
      -- just use j and k
      -- previous and next sibling is slightly better, keeping it on the same level
      -- vim.keymap.set('n', 'n', api.node.navigate.sibling.prev, opts('Previous Sibling'))
      -- vim.keymap.set('n', 't', api.node.navigate.sibling.next, opts('Next Sibling'))
      -- vim.keymap.set('n', 'T', api.node.navigate.sibling.last, opts('Last Sibling'))
      -- vim.keymap.set('n', 'N', api.node.navigate.sibling.first, opts('First Sibling'))
      vim.keymap.set('n', 's', edit_or_open, opts('Edit or Open'))
      vim.keymap.set('n', 'L', function()
        local node = api.tree.get_node_under_cursor()
        -- your code goes here
        vsplit_preview()
      end, opts('vsplit_preview'))

      vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))

      -- local node = api.tree.get_node_under_cursor()
      vim.keymap.set('n', '<C-n>', next_sibling_preview, opts('no description'))
      vim.keymap.set('n', '<M-n>', next_sibling_preview, opts('no description'))
      vim.keymap.set('n', '<C-p>', previous_sibling_preview, opts('no description'))
      vim.keymap.set('n', '<M-p>', previous_sibling_preview, opts('no description'))

      vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

      vim.keymap.set('n', '<A-g>', api.node.navigate.git.prev, opts('Prev Git'))
      vim.keymap.set('n', '<A-r>', api.node.navigate.git.next, opts('Next Git'))

      vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
      vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))

      vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
      vim.keymap.set('n', 'u', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
      vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))

      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', '_', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', 'A', api.tree.search_node, opts('Search'))
      vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))

      vim.keymap.set('n', "'", api.node.run.system, opts('Run System'))

      vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
      vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))
      vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
      vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
      vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    end

    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    -- vim.keymap.set('n', '<leader>mn', require('nvim-tree.api').marks.navigate.next, { desc = 'nvim-tree marks next' })
    -- vim.keymap.set('n', '<leader>mp', require('nvim-tree.api').marks.navigate.next, { desc = 'nvim-tree marks previous' })
    -- vim.keymap.set('n', '<leader>ms', require('nvim-tree.api').marks.navigate.next, { desc = 'nvim-tree marks select' })

    vim.keymap.set('n', '<A-m>', ':NvimTreeToggle<CR>', { desc = 'nvim tree toggle' })
    vim.keymap.set('n', '<A-b>', ':NvimTreeFindFile<CR>', { desc = 'nvim tree find file' })

    local function openNvimTreeAndKeepOpen()
      if vim.fn.bufname():match('NvimTree_') then
        -- previous window
        vim.cmd.wincmd('p')
      else
        api.tree.open({ find_file = true })
      end
    end

    vim.keymap.set('n', '<M-CR>', openNvimTreeAndKeepOpen, { desc = 'nvim-tree: toggle' })
    vim.keymap.set('n', '<M-Space>', openNvimTreeAndKeepOpen, { desc = 'nvim-tree: toggle' })

    require('nvim-tree').setup({

      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = true, -- disables netrw completely
      hijack_cursor = false, -- hijack the cursor in the tree to put it at the start of the filename
      hijack_netrw = true, -- hijack netrw window on startup
      hijack_unnamed_buffer_when_opening = false,
      -- ignore_buffer_on_setup = false,
      -- open_on_setup = true, -- open the tree when running this setup function
      -- open_on_setup_file = false,
      open_on_tab = false,
      sort_by = 'name',
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      root_dirs = { '/Users/tim/src/candy/main/referralcandy-main' },
      reload_on_bufenter = false,
      respect_buf_cwd = false,

      on_attach = on_attach,

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
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = { relative = 'editor', border = 'rounded', width = 30, height = 30, row = 1, col = 1 },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = 'none',
        root_folder_modifier = ':~',
        indent_markers = { enable = false, icons = { corner = '└', edge = '│', item = '│', none = ' ' } },
        icons = {
          webdev_colors = true,
          git_placement = 'before',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          show = { file = true, folder = true, folder_arrow = true, git = true },
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
              symlink_open = '',
            },
            git = {
              unstaged = '',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = 'U',
              deleted = '',
              ignored = '◌',
            },
          },
        },
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        symlink_destination = true,
      },

      hijack_directories = { enable = true, auto_open = true },
      -- do not update root so that i can still continue to eg grep for a string with the cwd of the project root
      update_focused_file = { enable = true, update_root = true, ignore_list = {} },
      -- ignore_ft_on_setup = {}, -- will not open on setup if the filetype is in this list
      system_open = { cmd = '', args = {} },
      diagnostics = { -- show lsp diagnostics in the signcolumn
        enable = false,
        show_on_dirs = false,
        icons = { hint = '', info = '', warning = '', error = '' },
      },
      filters = { dotfiles = false, custom = {}, exclude = {} },
      filesystem_watchers = { enable = true, debounce_delay = 50 },
      git = { enable = true, ignore = true, show_on_dirs = true, timeout = 400 },
      actions = {
        use_system_clipboard = true,
        change_dir = { enable = true, global = false, restrict_above_cwd = false },
        expand_all = { max_folder_discovery = 300, exclude = {} },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = false,
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
        remove_file = { close_window = true },
      },

      trash = { cmd = 'gio trash', require_confirm = true },
      live_filter = { prefix = '[FILTER]: ', always_show_folders = true },
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
          watcher = false,
        },
      },
    })
  end,
}

return M
