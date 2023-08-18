local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    -- "hrsh7th/cmp-calc",
    -- "lukas-reineke/cmp-rg",
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
    'saadparwaiz1/cmp_luasnip',
    'petertriho/cmp-git',
    'L3MON4D3/LuaSnip',
    {
      'zbirenbaum/copilot-cmp',
      dependencies = 'copilot.lua',
      opts = {},
      config = function(_, opts)
        local copilot_cmp = require('copilot_cmp')
        copilot_cmp.setup(opts)
        -- attach cmp source whenever copilot attaches
        -- fixes lazy-loading issues with the copilot cmp source
        require('utils').on_attach(function(client)
          if client.name == 'copilot' then copilot_cmp._on_insert_enter({}) end
        end)
      end,
    },
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind') -- add icons to comp items
    -- local luasnip = require('luasnip')

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
    end

    lspkind.init({

      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = 'symbol_text',
      symbol_map = {
        Copilot = '',
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰜢',
        Variable = '󰀫',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '󰑭',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '󰈇',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '',
      },
    })

    vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

    cmp.setup({

      formatting = {
        -- configure lspkind
        format = lspkind.cmp_format({
          with_text = true,
          maxwidth = 50,
          menu = {
            buffer = 'BUF',
            nvim_lsp = 'LSP',
            path = 'PATH',
            vsnip = 'SNIP',
            calc = 'CALC',
            spell = 'SPELL',
            emoji = 'EMOJI',
          },
        }),
      },

      experimental = { native_menu = false, ghost_text = false },

      snippet = {
        expand = function(args)
          -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      mapping = {
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true, -- auto select first entry on enter
        }),
        ['<Tab>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true, -- auto select first entry on enter
        }),

        -- ['<Tab>'] = vim.schedule_wrap(function(fallback)
        --   if cmp.visible() and has_words_before() then
        --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --   else
        --     fallback()
        --   end
        -- end),

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        --     end
        -- end, {"i", "s"}),
        -- ["<S-Tab>"] = cmp.mapping(function()
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     end
        -- end, {"i", "s"})
      },

      sources = {
        { name = 'copilot', group_index = 2 },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'git' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'path' },
      },

      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- TODO: doesn't play well with nvimtree, causes eg :args to show filename instead of output?
    cmp.setup.cmdline(':', {
      mapping = {
        ['<C-n>'] = {
          c = function(fallback)
            -- local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
        ['<C-p>'] = {
          c = function(fallback)
            -- local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
        ['<C-e>'] = {
          c = cmp.mapping.abort(),
        },
        ['<C-y>'] = {
          c = cmp.mapping.confirm({ select = false }),
        },
      },
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
  end,
}

return M
