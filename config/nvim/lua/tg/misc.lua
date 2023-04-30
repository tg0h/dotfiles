function print_ex_command(command)
  -- Get the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  -- Append the command to the buffer
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { vim.cmd.highlight })
end
