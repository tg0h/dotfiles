local nvim_lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {"tsserver", "jsonls", "bashls", "dockerls", "yamlls"}
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
            }
        }
    }
end
