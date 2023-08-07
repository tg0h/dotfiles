-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local extras = require('luasnip.extras')
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require('luasnip.extras.expand_conditions')
local postfix = require('luasnip.extras.postfix').postfix
local types = require('luasnip.util.types')
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet

-- TODO: load helpers in snip_env - https://github.com/L3MON4D3/LuaSnip/issues/781

-- https://github.com/ziontee113/luasnip-tutorial/blob/main/luasnip-config/init.lua
-- {{{

-- require("luasnip.loaders.from_vscode").lazy_load()
require('luasnip.loaders.from_lua').load({ paths = '~/dotfiles/config/nvim/snippets/' })
require('luasnip').config.setup({ store_selection_keys = '<A-p>' })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) -- }}}

-- Virtual Text{{{
local types = require('luasnip.util.types')
ls.config.set_config({
  history = true, -- keep around last snippet local to jump back
  -- update dynamic snippets as you type
  updateevents = 'TextChanged,TextChangedI', -- update changes as you type
  enable_autosnippets = true,
  ext_opts = {
    -- [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}}
    -- [types.insertNode] = {
    --  active = {
    --    virt_text = { { "●", "GruvboxBlue" } },
    --  },
    -- },
  },

  -- Events on which to leave the current snippet if the cursor is outside its' 'region'.
  region_check_events = 'InsertEnter',

  -- When to check if the current snippet was deleted, and if so, remove it from the history
  delete_check_events = 'TextChanged,InsertLeave',
}) -- }}}

ls.filetype_extend('typescript', { 'javascript' })
-- Key Mapping --{{{

-- vim.keymap.set({"i", "s"}, "<c-s>", "<Esc>:w<cr>")

-- show picker via vim.ui.select to select choice
-- vim.keymap.set({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

-- this is the expand key
vim.keymap.set({ 'i', 's' }, '<C-t>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-n>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- jumping
-- also used by quickfix down/up
-- vim.keymap.set({"i", "s"}, "<M-j>", function() if ls.jumpable(1) then ls.jump(1) end end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<M-k>", function() if ls.jumpable(-1) then ls.jump(-1) end end, {silent = true})
-- -- cycle through choices
-- vim.keymap.set({"i", "s"}, "<a-l>", function()
--     if ls.choice_active() then
--         ls.change_choice(1)
--     else
--         -- print current time
--         local t = os.date("*t")
--         local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
--         print(time)
--     end
-- end)
-- vim.keymap.set({"i", "s"}, "<a-h>", function() if ls.choice_active() then ls.change_choice(-1) end end) -- }}}

-- More Settings --

vim.keymap.set('n', '<Leader><CR>', '<cmd>LuaSnipEdit<cr>', { silent = true, noremap = true })
vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
