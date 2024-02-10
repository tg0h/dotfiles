local M = {}

function M.open_current_file(kittyLaunchType)
  local filename = vim.api.nvim_buf_get_name(0)

  if filename then
    -- launch bottom split assuming monitor is in portrait mode
    -- location=hsplit launches a bottom split
    -- location=split is dynamic - it launches a side split if window is in landscape, launches a bottom split if portrait
    local cmd_template = [[ kitty @ launch --type=%s --location=split --cwd=current zsh -c 'nvim %s' ]]
    local cmd = string.format(cmd_template, kittyLaunchType, filename)
    os.execute(cmd)
  end
end

return M
