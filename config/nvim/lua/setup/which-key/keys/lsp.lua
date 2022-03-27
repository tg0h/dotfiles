local M = {
    name = "LSP",
    A = {
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
        "Add Workspace Folder"
    },
    D = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration"},
    I = {"<cmd>lua vim.lsp.buf.implementation()<cr>", "Show implementations"},
    K = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands"},
    L = {
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
        "List Workspace Folders"
    },
    R = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
    S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"
    },
    W = {
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
        "Remove Workspace Folder"
    },
    a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
    d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition"},
    e = {"<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics"},
    f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"}, -- use lsp server to format
    i = {"<cmd>LspInfo<cr>", "Connected Language Servers"},
    k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
    l = {"<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics"},
    n = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic"},
    p = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic"},
    q = {"<cmd>lua vim.diagnostic.setloclist()<CR>", "Location List"},
    r = {"<cmd>lua vim.lsp.buf.references()<CR>", "References"},
    s = {"<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols"},
    t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition"},
    w = {"<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics"}
}

return M
