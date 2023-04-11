local M = {}

M.my_grep_string = function()
  require('telescope.builtin').grep_string({
    hidden = false,
    layout_strategy = 'vertical',
    layout_config = {
      height = 0.99,
      -- anchor = 'E',
      width = 0.9,
      prompt_position = 'top',
      preview_height = 0.5,
      mirror = true,
    },
  })
end

return M
