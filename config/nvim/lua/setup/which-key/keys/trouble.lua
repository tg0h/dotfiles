local M = {
    name = "Trouble",
    w = {"<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics"},
    d = {"<cmd>Trouble document_diagnostics<CR>", "Document Diagnostic"},
    l = {"<cmd>Trouble loclist<CR>", "Loclist"},
    q = {"<cmd>Trouble quickfix<CR>", "Quickfix"},
    t = {"<cmd>TodoTrouble<CR>", "Todos"},

    -- use LSP keymaps instead
    r = {"<cmd>Trouble lsp_references<CR>", "LSP References"},
    e = {"<cmd>Trouble lsp_definitions<CR>", "LSP Definitions"},
    o = {"<cmd>Trouble lsp_type_definitions<CR>", "LSP Type Definitions"},

    R = {"<cmd>TroubleRefresh<CR>", "Refresh"},
    s = {"<cmd>TroubleClose<CR>", "Close"},
    h = {"<cmd>TroubleToggle<CR>", "Toggle"}
}
return M
