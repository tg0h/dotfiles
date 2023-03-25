-- automatically run packer compile when this is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    -- use("~/src/playground/vim/plugin")
    -- keys = {"<C-e>"}

    use("wbthomason/packer.nvim")
    use({ "sainnhe/sonokai", config = get_setup("sonokai") })

    use({
      "nvim-tree/nvim-tree.lua",
      requires = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icon
      },
      config = get_setup("nvim-tree"),
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-tree/nvim-web-devicons", opt = true },
      config = get_setup("lualine"),
    })

    use({ "nvim-treesitter/nvim-treesitter", config = get_setup("treesitter"), run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")

    use({
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      -- tag = "v<CurrentMajor>.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp",
      config = get_setup("luasnip"),
    })

    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        -- {'hrsh7th/cmp-vsnip'},
        { "hrsh7th/cmp-emoji" },
        { "hrsh7th/cmp-calc" },
        { "saadparwaiz1/cmp_luasnip" },
      },
      config = get_setup("cmp"),
    })
    use({ "mfussenegger/nvim-lint", config = get_setup("nvim-lint") })

    use({
      "neovim/nvim-lspconfig",
      requires = { { "b0o/schemastore.nvim" }, { "hrsh7th/nvim-cmp" }, { "folke/lua-dev.nvim" } },
      config = get_setup("lsp"),
    })

    use({ "onsails/lspkind-nvim" })

    -- use {'hrsh7th/vim-vsnip', config = get_setup('vsnip')}
    use({ "rafamadriz/friendly-snippets", requires = { { "hrsh7th/vim-vsnip" } } })

    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = get_setup("telescope"),
      event = "BufWinEnter",
    })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({ "nvim-telescope/telescope-symbols.nvim" }) -- add emojis
    use({ "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sqlite.lua" } })

    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = get_setup("gitsigns"),
    })

    use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = get_setup("trouble"),
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
      -- config = get_setup("symbols"), -- TODO: how to async load config
    })

    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "TodoTrouble", "TodoTelescope" },
      event = "BufReadPost",
      config = get_setup("todo"),
    })

    use("junegunn/vim-easy-align") -- no lua alternative

    use({ "famiu/bufdelete.nvim", event = "BufReadPre" })

    use({
      "akinsho/nvim-bufferline.lua",
      branch = "main",
      requires = "nvim-tree/nvim-web-devicons",
      event = "BufReadPre",
      config = get_setup("bufferline"),
    })

    use({
      "akinsho/nvim-toggleterm.lua",
      branch = "main",
      keys = { "<C-y>", "<leader>fl", "<leader>gl" },
      config = get_setup("toggleterm"),
    })

    -- gitsigns also provides a git blame
    use({ "f-person/git-blame.nvim", config = get_setup("git-blame") })

    use({ "folke/which-key.nvim", config = get_setup("which-key") })

    use({ "mbbill/undotree" })

    use({ "mhartington/formatter.nvim", event = "BufWritePre", config = get_setup("formatter") })

    use({ "tweekmonster/startuptime.vim" })

    -- to enable dot repeat for lightspeed
    use({ "tpope/vim-repeat" })

    use({ "windwp/nvim-autopairs", config = get_setup("autopairs") })
    use({ "windwp/nvim-ts-autotag" })
    use("p00f/nvim-ts-rainbow")
    use({ "numToStr/Comment.nvim", opt = true, keys = { "gc", "gcc" }, config = get_setup("comment") })
    use({ "norcalli/nvim-colorizer.lua", event = "BufReadPre", config = get_setup("colorizer") })
    use({ "mfussenegger/nvim-dap", config = get_setup("dap") })

    use({ "rcarriga/nvim-dap-ui", after = "nvim-dap", config = get_setup("dap-ui") })
    use({ "theHamsta/nvim-dap-virtual-text", after = "nvim-dap", config = get_setup("dap-virtual-text") })
    use({ "alexghergh/nvim-tmux-navigation" })
    use({ "danilamihailov/beacon.nvim", config = get_setup("beacon") })
    use({ "ur4ltz/surround.nvim", config = get_setup("surround") })
    use({ "gennaro-tedesco/nvim-peekup" })

    use({
      "AckslD/nvim-neoclip.lua",
      requires = { { "tami5/sqlite.lua", module = "sqlite" }, { "nvim-telescope/telescope.nvim" } },
      config = get_setup("neoclip"),
    })

    use({ "~/src/me/nvim/harpoon", requires = { "nvim-lua/plenary.nvim" }, config = get_setup("harpoon") })

    use({ "~/src/me/nvim/git-worktree.nvim" })
    use({ "~/src/me/nvim/gitdiffer" })

    use({ "jxnblk/vim-mdx-js" })
    use("fladson/vim-kitty") -- syntax highlighting for kitty
    use({ "knubie/vim-kitty-navigator", run = "cp ./*.py ~/.config/kitty/" })

    use({ "vito-c/jq.vim" })
    use({ "mityu/vim-applescript" })
    use({ "lbrayner/vim-rzip" }) -- use so that go to definition is able to read .yarn/cache plug n play zipped files

    use({ "tpope/vim-dadbod" })
    use({ "kristijanhusak/vim-dadbod-ui" })
    use({ "dkarter/bullets.vim" })
    use({ "rizzatti/dash.vim" })
    use({ "chentoast/marks.nvim", config = get_setup("marks") })
    use({ "andythigpen/nvim-coverage", requires = "nvim-lua/plenary.nvim", config = get_setup("nvim-coverage") })

    use({ "rhysd/committia.vim" }) -- git commit buffer with splits

    use({ "ray-x/lsp_signature.nvim", config = get_setup("lsp-signature") })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
