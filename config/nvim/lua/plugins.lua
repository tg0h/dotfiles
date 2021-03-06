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
    return string.format("require(\"setup/%s\")", name)
end

return require("packer").startup({
    function(use)
        -- Packer can manage itself
        -- use("~/src/playground/vim/plugin")
        -- keys = {"<C-e>"}

        -- use("rafcamlet/nvim-luapad")

        -- TODO: luadev requires lspconfig ??
        -- use {"folke/lua-dev.nvim", config = get_setup("luadev")}

        use("wbthomason/packer.nvim")
        use {"sainnhe/sonokai", config = get_setup("sonokai")}

        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = get_setup("lualine")
        }

        use {
            "nvim-treesitter/nvim-treesitter",
            config = get_setup("treesitter"),
            run = ":TSUpdate"
        }
        use "nvim-treesitter/nvim-treesitter-textobjects"

        use {
            "hrsh7th/nvim-cmp",
            requires = {
                {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"},
                {"hrsh7th/cmp-vsnip"}, {"hrsh7th/cmp-emoji"},
                {"hrsh7th/cmp-calc"}
            },
            config = get_setup("cmp")
        }

        use {
            "neovim/nvim-lspconfig",
            requires = {
                {"b0o/schemastore.nvim"}, {"hrsh7th/nvim-cmp"},
                {"folke/lua-dev.nvim"}
            },
            config = get_setup("lsp")
        }

        use {"onsails/lspkind-nvim"}

        use {"hrsh7th/vim-vsnip", config = get_setup("vsnip")}
        use {"rafamadriz/friendly-snippets", requires = {{"hrsh7th/vim-vsnip"}}}

        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzy-native.nvim"},
                {"nvim-telescope/telescope-dap.nvim"}
            },
            config = get_setup("telescope"),
            event = "BufWinEnter"
        })
        use {"nvim-telescope/telescope-file-browser.nvim"}
        -- use {"crispgm/telescope-heading.nvim"} -- markdown headings
        use {"nvim-telescope/telescope-symbols.nvim"} -- add emojis
        -- use {"ThePrimeagen/git-worktree.nvim"}
        use {
            "nvim-telescope/telescope-frecency.nvim",
            requires = {"tami5/sqlite.lua"}
        }

        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons" -- optional, for file icon
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
            "simrat39/symbols-outline.nvim",
            cmd = {"SymbolsOutline"}
            -- config = get_setup("symbols"), -- TODO: how to async load config
        }

        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            cmd = {"TodoTrouble", "TodoTelescope"},
            event = "BufReadPost",
            config = get_setup("todo")
        }

        use "junegunn/vim-easy-align" -- no lua alternative

        use {"famiu/bufdelete.nvim", event = "BufReadPre"}

        use {
            "akinsho/nvim-bufferline.lua",
            branch = "main",
            requires = "kyazdani42/nvim-web-devicons",
            event = "BufReadPre",
            config = get_setup("bufferline")
        }

        -- use {
        --     "ThePrimeagen/harpoon",
        --     -- keybindings which will lazyload this plugin
        --     -- keys = {
        --     --     "<leader>ha", "<leader>hu", "<leader>h1", "<leader>h1", "<leader>h3",
        --     --     "<leader>h4"
        --     -- },
        --     requires = {"nvim-lua/plenary.nvim"},
        --     config = get_setup("harpoon")
        -- }

        use {
            "akinsho/nvim-toggleterm.lua",
      branch='main',
            keys = {"<C-y>", "<leader>fl", "<leader>gl"},
            config = get_setup("toggleterm")
        }

        -- gitsigns also provides a git blame
        use {"f-person/git-blame.nvim", config = get_setup("git-blame")}

        -- use {
        --     "ptzz/lf.vim",
        --     requires = "voldikss/vim-floaterm",
        --     config = get_setup("lf")
        -- }

        use {"folke/which-key.nvim", config = get_setup("which-key")}

        use {"mbbill/undotree"}

        use {
            "mhartington/formatter.nvim",
            event = "BufWritePre",
            config = get_setup("formatter")
        }

        use {"tweekmonster/startuptime.vim"}
        use {"ray-x/lsp_signature.nvim", requires = {{"neovim/nvim-lspconfig"}}}
        -- use {"ggandor/lightspeed.nvim", event = "BufReadPre"}

        -- to enable dot repeat for lightspeed
        use {"tpope/vim-repeat"}

        -- use {"ahmedkhalf/project.nvim", config = get_setup("project")}
        -- use {
        --     "folke/zen-mode.nvim",
        --     cmd = "ZenMode",
        --     config = get_setup("zen-mode")
        -- }
        -- use {"sidebar-nvim/sidebar.nvim", config = get_setup("sidebar")}
        use {"windwp/nvim-autopairs", config = get_setup("autopairs")}
        use {"windwp/nvim-ts-autotag"}
        use "p00f/nvim-ts-rainbow"
        use {
            "numToStr/Comment.nvim",
            opt = true,
            keys = {"gc", "gcc"},
            config = get_setup("comment")
        }
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufReadPre",
            config = get_setup("colorizer")
        }
        use {"mfussenegger/nvim-dap", config = get_setup("dap")}

        -- use {
        --     "Pocco81/DAPInstall.nvim",
        --     config = get_setup("dap-install"),
        --     after = "nvim-dap"
        -- }

        use {
            "rcarriga/nvim-dap-ui",
            after = "nvim-dap",
            config = get_setup("dap-ui")
        }
        use {
            "theHamsta/nvim-dap-virtual-text",
            after = "nvim-dap",
            config = get_setup("dap-virtual-text")
        }
        use {"alexghergh/nvim-tmux-navigation"}
        use {"danilamihailov/beacon.nvim", config = get_setup("beacon")}
        use {"ur4ltz/surround.nvim", config = get_setup("surround")}
        -- use {"tversteeg/registers.nvim", config = get_setup("registers")}
        use {"gennaro-tedesco/nvim-peekup"}

        use {
            "AckslD/nvim-neoclip.lua",
            requires = {
                {"tami5/sqlite.lua", module = "sqlite"},
                {"nvim-telescope/telescope.nvim"}
            },
            config = get_setup("neoclip")
        }
        -- use {"tpope/vim-fugitive"}

        use {
            "~/src/me/nvim/harpoon",
            requires = {"nvim-lua/plenary.nvim"},
            config = get_setup("harpoon")
        }

        use {"~/src/me/nvim/git-worktree.nvim"}
        use {"~/src/me/nvim/gitdiffer"}
        -- use {"kana/vim-textobj-user"}
        -- iv and av text objects for snake_case and camelCase
        use {
            "Julian/vim-textobj-variable-segment",
            requires = {"kana/vim-textobj-user"}
        }
        use {"jxnblk/vim-mdx-js"}
        use "fladson/vim-kitty" -- syntax highlighting for kitty
        use {"knubie/vim-kitty-navigator", run='cp ./*.py ~/.config/kitty/'}

    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end
        },
        profile = {
            enable = true,
            threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
        }
    }
})
