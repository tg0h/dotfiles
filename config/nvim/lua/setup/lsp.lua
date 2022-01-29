local nvim_lsp = require("lspconfig")

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
    "tsserver"
}
-- Use a loop to conveniently call 'setup' on multiple servers
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        flags = {debounce_text_changes = 150}
    }
end
