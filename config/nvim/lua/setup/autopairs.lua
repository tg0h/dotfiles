local npairs = require "nvim-autopairs"

npairs.setup {
    check_ts = true, -- use treesitter to check for a pair
    enable_check_bracket_line = false -- don't add a pair if there is already a close pair in the same line
}


-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require('cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
