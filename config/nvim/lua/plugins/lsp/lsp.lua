-- local conf = vim.g.config
-- local nvim_lsp = require("lspconfig")
-- local utils = require("core.plugins.lsp.utils")
-- local lsp_settings = require("core.plugins.lsp.settings")
-- 
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- enable autoclompletion via nvim-cmp
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- 
-- require("core.utils.functions").on_attach(function(client, buffer)
--   require("core.plugins.lsp.keys").on_attach(client, buffer)
-- end)
-- 
-- for _, lsp in ipairs(conf.lsp_servers) do
--   if lsp == "rust_analyzer" then
--     vim.notify("rust_analyzer is managed by rust-tools", vim.log.levels.INFO, { title = "LSP config" })
--     goto continue
--   end
--   nvim_lsp[lsp].setup({
--     before_init = function(_, config)
--       if lsp == "pyright" then
--         config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
--       end
--     end,
--     capabilities = capabilities,
--     flags = { debounce_text_changes = 150 },
--     settings = {
--       json = lsp_settings.json,
--       Lua = lsp_settings.lua,
--       ltex = lsp_settings.ltex,
--       redhat = { telemetry = { enabled = false } },
--       texlab = lsp_settings.tex,
--       yaml = lsp_settings.yaml,
--     },
--   })
--   ::continue::
-- end

local nvim_lsp = require('lspconfig')
-- local util = require("lspconfig/util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- nvim_lsp.tsserver.setup({
--     capabilities = capabilities,
--     flags = {debounce_text_changes = 150},
--     -- root_dir = util.root_pattern(".git","tsconfig.json", "jsconfig.json", "package.json")
--     root_dir = util.root_pattern(".git", "tsconfig.json")
-- })

local servers = { 'tsserver', 'jsonls', 'dockerls', 'yamlls', 'lua_ls', 'solargraph', 'pyright', 'sqlls', 'eslint' }

-- Use a loop to conveniently call 'setup' on multiple servers
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {

      json = {
        -- format = {enabled = false}, -- format defaults to true
        schemas = require('schemastore').json.schemas(),
      },

      yaml = {
        schemaStore = { enable = true, url = 'https://www.schemastore.org/api/json/catalog.json' },
        schemas = {
          -- kubernetes = "*.yaml", -- kubernetes is special-cased in yamlls :|
          ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
          ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
          ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
          ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
          ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
          ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
        },
        format = { enabled = false },
        validate = true,
        completion = true,
        hover = true,
      },

      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false, -- disable annoying 'do you need to configure your work enviroment as ... prompt'
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },

    root_dir = require('lspconfig.util').root_pattern({
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
      vim.fn.getcwd(),
    }),
  })
  -- require'lsp_signature'.setup({
  --     bind = true, -- This is mandatory, otherwise border config won't get registered.
  --     floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  --     doc_lines = 2, -- Set to 0 for not showing doc
  --     hint_prefix = '🐼 ',
  --     -- use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  --     handler_opts = {
  --         border = 'shadow' -- double, single, shadow, none
  --     }
  -- })
end

vim.keymap.set('n', '<A-e>', ':lua vim.lsp.buf.rename()<CR>', { desc = 'lsp buf rename' }) -- rename
vim.keymap.set('n', '<A-o>', ':lua vim.lsp.buf.code_action()<CR>', { desc = 'lsp buf code action' }) -- code action

vim.keymap.set('n', '<A-a>', ':lua vim.lsp.buf.definition()<CR>', { desc = 'lsp buf definition' }) -- go to def
vim.keymap.set('n', '<A-u>', ':lua vim.lsp.buf.references()<CR>', { desc = 'lsp buf references' }) -- find references

local diagnostic = vim.diagnostic
vim.keymap.set('n', '<S-C-;>', diagnostic.setloclist, { desc = 'add buffer diagnostics to loc list' }) -- C-:

vim.keymap.set('n', '<C-A-g>', ':lua vim.diagnostic.goto_prev()<CR>', { desc = 'vim diagnostic goto prev' }) -- prev diagnostic
vim.keymap.set('n', '<C-A-r>', ':lua vim.diagnostic.goto_next()<CR>', { desc = 'vim diagnostic goto next' }) -- next diagnostic

vim.keymap.set('n', '<C-A-l>', ':lua vim.diagnostic.open_float()<CR>', { desc = 'vim diagnostic open float' }) -- show diagnostic
