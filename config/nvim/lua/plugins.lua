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
    use("phanviet/vim-monokai-pro")

    use {"neovim/nvim-lspconfig", config = get_setup("lsp")}

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

