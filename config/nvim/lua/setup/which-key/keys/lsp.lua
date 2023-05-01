local M = {
  name = 'LSP',
  -- A = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', 'Add Workspace Folder' },
  -- W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', 'Remove Workspace Folder' },
  d = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go To Declaration' },
  i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Show implementations' },
  K = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover Commands' },
  -- L = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'List Workspace Folders' },
  S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
  i = { '<cmd>LspInfo<cr>', 'Connected Language Servers' },
  k = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature Help' },
  s = { '<cmd>Telescope lsp_document_symbols<CR>', 'Document Symbols' },
  t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
}

return M
