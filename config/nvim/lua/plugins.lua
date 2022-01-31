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
    use("wbthomason/packer.nvim")
    use { 'sainnhe/sonokai', config = get_setup("sonokai")}

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_setup("lualine")
    }

    use {"neovim/nvim-lspconfig", config = get_setup("lsp")}

    use {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    run = ":TSUpdate"
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-vsnip"}, {"hrsh7th/cmp-emoji"},
            {"hrsh7th/cmp-calc"}
        },
        config = get_setup("cmp")
    }
    use {"onsails/lspkind-nvim"}

    use {"hrsh7th/vim-vsnip", config = get_setup("vsnip")}
    use {"rafamadriz/friendly-snippets", requires = {{"hrsh7th/vim-vsnip"}}}

    use({
      'nvim-telescope/telescope.nvim',
      requires = { 
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'} 
      },
      config = get_setup('telescope')
    })
    use {"nvim-telescope/telescope-file-browser.nvim"}  

    use {
      "kyazdani42/nvim-tree.lua", 
      requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
      config = get_setup("nvim-tree")
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        event = "BufReadPre",
        config = get_setup("gitsigns")
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        cmd = {"TroubleToggle", "Trouble"},
        config = get_setup("trouble")
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        cmd = {"TodoTrouble", "TodoTelescope"},
        event = "BufReadPost",
        config = get_setup("todo")
    }

    use {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufReadPre",
    config = get_setup("bufferline")
    }

    use {
      "ThePrimeagen/harpoon",
      -- keybindings which will lazyload this plugin
      -- keys = {
      --     "<leader>ha", "<leader>hu", "<leader>h1", "<leader>h1", "<leader>h3",
      --     "<leader>h4"
      -- },
      requires = {"nvim-lua/plenary.nvim"},
      config = get_setup("harpoon")
    }

    use {
        "akinsho/nvim-toggleterm.lua",
        keys = {"<C-y>", "<leader>fl", "<leader>gt"},
        config = get_setup("toggleterm")
    }

    use {"f-person/git-blame.nvim", config = get_setup("git-blame")}

    use {
        "ptzz/lf.vim",
        requires = "voldikss/vim-floaterm",
        config = get_setup("lf")
    }

    use {
      "folke/which-key.nvim",
      config = get_setup('which-key')
    }

    use {"windwp/nvim-autopairs", config = get_setup("autopairs")}
    use "p00f/nvim-ts-rainbow"
    use('tpope/vim-commentary')

  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = 'single' })
      end
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})

