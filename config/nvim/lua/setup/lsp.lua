local nvim_lsp = require("lspconfig")
-- local util = require("lspconfig/util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- nvim_lsp.tsserver.setup({
--     capabilities = capabilities,
--     flags = {debounce_text_changes = 150},
--     -- root_dir = util.root_pattern(".git","tsconfig.json", "jsconfig.json", "package.json")
--     root_dir = util.root_pattern(".git", "tsconfig.json")
-- })

local servers = {
    "tsserver", "jsonls", "dockerls", "yamlls", "lua_ls",
    "solargraph", "pyright", "sqlls", "eslint"
}

-- Use a loop to conveniently call 'setup' on multiple servers
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        flags = {debounce_text_changes = 150},
        settings = {

            json = {
                -- format = {enabled = false}, -- format defaults to true
                schemas = require("schemastore").json.schemas()
            },

            yaml = {
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json"
                },
                schemas = {
                    -- kubernetes = "*.yaml", -- kubernetes is special-cased in yamlls :|
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                    ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}"
                },
                format = {enabled = false},
                validate = true,
                completion = true,
                hover = true
            },

            Lua = { 
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            }
        }
    }
    require"lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
        doc_lines = 2, -- Set to 0 for not showing doc
        hint_prefix = "🐼 ",
        -- use_lspsaga = false,  -- set to true if you want to use lspsaga popup
        handler_opts = {
            border = "shadow" -- double, single, shadow, none
        }
    })
end
