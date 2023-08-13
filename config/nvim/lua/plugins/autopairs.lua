local M = {
  'windwp/nvim-autopairs',
  -- opts = {
  --   enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
  --   ignored_next_char = '[%w%.]', -- will ignore alphanumeric and `.` symbol
  --   check_ts = true, -- use treesitter to check for a pair.
  --   ts_config = {
  --     lua = { 'string' }, -- it will not add pair on that treesitter node
  --     javascript = { 'template_string' },
  --     java = false, -- don't check treesitter on java
  --   },
  -- },
  -- event = 'InsertEnter',
  event = 'VeryLazy',
  config = function()
    local npairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')

    npairs.setup({
      check_ts = true, -- use treesitter to check for a pair
      enable_check_bracket_line = false, -- don't add a pair if there is already a close pair in the same line

      disable_filetype = { 'TelescopePrompt' },
      disable_in_macro = false, -- disable when recording or executing a macro
      disable_in_visualblock = false, -- disable when insert after visual block mode
      ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
      enable_moveright = true,
      enable_afterquote = true, -- add bracket pairs after quote
      enable_bracket_in_quote = true,
      map_cr = true,
      map_bs = true, -- map the <BS> key
      map_c_h = false, -- Map the <C-h> key to delete a pair
      map_c_w = false, -- map <c-w> to delete a pair if possible

      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        end_key = '$',
        keys = 'aoeusnthqwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    })

    npairs.add_rules({
      -- js anonymous func arrow key ()=> adds {}
      Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' }):use_regex(true):set_end_pair_length(2),
    })
  end,
}

return M
