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

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    -- use("~/src/playground/vim/plugin")
    -- keys = {"<C-e>"}

    use('wbthomason/packer.nvim')
    use({ 'sainnhe/sonokai' })

    use({ '~/src/me/nvim/harpoon', requires = { 'nvim-lua/plenary.nvim' } })
    use({
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icon
      },
    })

    use({
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    })

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use({ 'nvim-treesitter/playground' })
    use('nvim-treesitter/nvim-treesitter-textobjects')

    use({
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      -- tag = "v<CurrentMajor>.*",
      -- install jsregexp (optional!:).
      run = 'make install_jsregexp',
    })

    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-emoji' },
        { 'hrsh7th/cmp-calc' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'petertriho/cmp-git' },
      },
    })
    -- use({ 'mfussenegger/nvim-lint', config = get_setup('nvim-lint') })

    use({
      'neovim/nvim-lspconfig',
      requires = { { 'b0o/schemastore.nvim' }, { 'hrsh7th/nvim-cmp' }, { 'folke/lua-dev.nvim' } },
    })

    use({
      'williamboman/mason.nvim',
      run = ':MasonUpdate', -- :MasonUpdate updates registry contents
    })

    use({ 'onsails/lspkind-nvim' })

    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' },
        { 'nvim-telescope/telescope-dap.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'crispgm/telescope-heading.nvim' },
      },
      -- do not lazy load so that i can set keymaps in nvim/config/after/
      -- event = 'BufWinEnter',
    })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({ 'nvim-telescope/telescope-symbols.nvim' }) -- add emojis
    use({ 'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sqlite.lua' } })

    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    })

    use({
      'folke/trouble.nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      -- cmd = { 'TroubleToggle', 'Trouble' },
    })

    use({
      'simrat39/symbols-outline.nvim',
      cmd = { 'SymbolsOutline' },
      -- config = get_setup("symbols"), -- TODO: how to async load config
    })

    use({
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
    })

    use('junegunn/vim-easy-align') -- no lua alternative

    use({ 'famiu/bufdelete.nvim', event = 'BufReadPre' })

    use({
      'akinsho/nvim-bufferline.lua',
      branch = 'main',
      requires = 'nvim-tree/nvim-web-devicons',
    })

    use({
      'akinsho/nvim-toggleterm.lua',
      branch = 'main',
      -- keys = { '<C-y>', '<leader>fl', '<leader>gl' },
    })

    -- gitsigns also provides a git blame
    use({ 'f-person/git-blame.nvim', config = get_setup('git-blame') })

    use({ 'folke/which-key.nvim', config = get_setup('which-key') })

    use({ 'mbbill/undotree' })

    use({ 'mhartington/formatter.nvim' })

    use({ 'tweekmonster/startuptime.vim' })

    -- use({ 'ggandor/leap.nvim' })
    -- to enable dot repeat for lightspeed
    use({ 'tpope/vim-repeat' })

    use({ 'windwp/nvim-autopairs' })
    use({ 'windwp/nvim-ts-autotag' })
    -- use('p00f/nvim-ts-rainbow')
    use('hiphish/rainbow-delimiters.nvim')
    use({ 'numToStr/Comment.nvim' })
    use({ 'norcalli/nvim-colorizer.lua' })

    use({ 'ur4ltz/surround.nvim' })

    use({
      'AckslD/nvim-neoclip.lua',
      requires = { { 'tami5/sqlite.lua', module = 'sqlite' }, { 'nvim-telescope/telescope.nvim' } },
    })

    use('fladson/vim-kitty') -- syntax highlighting for kitty
    use({ 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' })

    use({ 'vito-c/jq.vim' })

    use({ 'dkarter/bullets.vim' })
    use({ 'chentoast/marks.nvim' })
    use({ 'andythigpen/nvim-coverage', requires = 'nvim-lua/plenary.nvim' })

    use({ 'rhysd/committia.vim' }) -- git commit buffer with splits

    use({ 'ray-x/lsp_signature.nvim' })
    use({
      'notjedi/nvim-rooter.lua',
      config = function()
        require('nvim-rooter').setup()
      end,
    })
    use('dmmulroy/tsc.nvim')
    use('opdavies/toggle-checkbox.nvim')
    use('github/copilot.vim')
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
