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

    use({
      'nvim-telescope/telescope.nvim',
      requires = { 
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'} 
      },
      config = get_setup('telescope')
    })

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

