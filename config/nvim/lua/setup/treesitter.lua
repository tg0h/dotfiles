require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "cmake",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "typescript",
    "json",
    "ledger",
    "lua",
    "python",
    "toml",
    "yaml",
    "markdown",
    "ruby",
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  indent = { enable = true }, -- Indentation based on treesitter for the = operator

  -- Custom Modules
  -- autopairs = {{enable = true}},
  autotag = { enable = true },

  textobjects = { -- for git nvim-treesitter/nvim-treesitter-textobjects
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ik"] = "@block.inner",
        ["ak"] = "@block.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
  },
  rainbow = { -- git nvim-ts-rainbow
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 2000, -- Do not enable for files with more than specified lines
  },
})
