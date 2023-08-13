-- lsp symbol navigation for lualine. This shows where
-- in the code structure you are - within functions, classes,
-- etc - in the statusline.
return {
  'SmiteshP/nvim-navic',
  event = 'VeryLazy',
  init = function()
    vim.g.navic_silence = true
    -- add navic to winbar
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    require('utils').on_attach(function(client, buffer)
      if client.server_capabilities.documentSymbolProvider then require('nvim-navic').attach(client, buffer) end
    end)

    -- vim.api.nvim_set_hl(0, 'NavicIconsFile', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsModule', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsPackage', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsClass', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsMethod', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsProperty', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsField', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsEnum', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsInterface', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsFunction', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsVariable', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsConstant', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsString', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsNumber', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsArray', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsObject', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsKey', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsNull', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsStruct', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsEvent', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsOperator', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicIconsTypeParameter', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicText', { default = true, bg = '#000000', fg = '#ffffff' })
    -- vim.api.nvim_set_hl(0, 'NavicSeparator', { default = true, bg = '#000000', fg = '#ffffff' })
  end,

  opts = {
    icons = {
      File = '󰈙 ',
      Module = ' ',
      Namespace = '󰌗 ',
      Package = ' ',
      Class = '󰌗 ',
      Method = '󰆧 ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = '󰕘',
      Interface = '󰕘',
      Function = '󰊕 ',
      Variable = '󰆧 ',
      Constant = '󰏿 ',
      String = '󰀬 ',
      Number = '󰎠 ',
      Boolean = '◩ ',
      Array = '󰅪 ',
      Object = '󰅩 ',
      Key = '󰌋 ',
      Null = '󰟢 ',
      EnumMember = ' ',
      Struct = '󰌗 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰊄 ',
    },
    lsp = {
      auto_attach = false,
      preference = nil,
    },
    highlight = true,
    separator = ' > ',
    depth_limit = 0,
    depth_limit_indicator = '..',
    safe_output = true,
    lazy_update_context = false,
    click = false,
  },
}
