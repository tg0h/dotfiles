local nvim_lsp = require("lspconfig")
-- local util = require("lspconfig/util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim_lsp.tsserver.setup({
--     capabilities = capabilities,
--     flags = {debounce_text_changes = 150},
--     -- root_dir = util.root_pattern(".git","tsconfig.json", "jsconfig.json", "package.json")
--     root_dir = util.root_pattern(".git", "tsconfig.json")
-- })

local servers = {
    "tsserver", "jsonls", "bashls", "dockerls", "yamlls", "sumneko_lua",
    "solargraph", "pyright"
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
                cmd = {"lua-language-server"},
                filetypes = {"lua"},
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ";")
                },
                completion = {enable = true, callSnippet = "Both"},
                diagnostics = {
                    enable = true,
                    globals = {"vim", "describe"},
                    disable = {"lowercase-global"}
                },
                workspace = {
                    library = {
                        vim.api.nvim_get_runtime_file("", true),
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    },
                    -- adjust these two values if your performance is not optimal
                    maxPreload = 2000,
                    preloadFileSize = 1000
                },
                telemetry = {enable = false}
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
