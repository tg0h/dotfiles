local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- Map the leader key
-- map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = ' '
-- vim.g.maplocalleader = ','
-- vim.g.maplocalleader = '<BS>' --doesn't work

-- Emacs emulation
map('i', '<C-a>', '<Esc>I', default_options) -- go to beginning of line in insert mode
map('i', '<C-e>', '<Esc>A', default_options) -- go to end of line in insert mode
map('i', '<C-d>', '<Del>', default_options) -- go to end of line in insert mode

-- Help
map('n', '<F1>', ':WhichKey<CR>', default_options) -- show all mappings

-- nice defaults
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- move lines, adds indent if moving eg into an if block
map('v', 'J', ":m '>+1<CR>gv=gv", default_options)
map('v', 'K', ":m '<-2<CR>gv=gv", default_options)
-- keep it centred when searching
map('n', 'n', 'nzzzv', default_options) -- zv opens folds
map('n', 'N', 'Nzzzv', default_options)
-- keep cursor on same place when you normal J
map('n', 'J', 'mzJ`z', default_options)
-- granular undo break points
map('i', ',', ',<C-g>u', default_options)
map('i', '.', '.<C-g>u', default_options)
map('i', '!', '!<C-g>u', default_options)
map('i', '?', '?<C-g>u', default_options)
-- vimscript . concats strings
-- m' adds a context mark which also adds to the jump list as a side effect
map('n', 'j', [[ (v:count > 5 ? "m'" . v:count : "") . 'j' ]], expr_options)
map('n', 'k', [[ (v:count > 5 ? "m'" . v:count : "") . 'k' ]], expr_options)

-- map("n", "gx", ":!open <C-R><C-A><CR>", expr_options)
-- https://vi.stackexchange.com/questions/27255/how-can-i-make-a-single-mapping-take-effect-for-both-normal-mode-insert-mode-a (you can't)
-- define for both normal and insert modes
map('n', '<C-M-z>', ':cquit<CR>', default_options) -- exit with error code
map('i', '<C-M-z>', '<Esc>:cquit<CR>', default_options) -- exit with error code

map('n', '<C-M-e>', ':w<CR>', default_options) -- normal mode save
map('i', '<C-M-e>', '<Esc>:w<CR>a', default_options) -- insert mode save

map('n', '<C-M-S>', ':wq<CR>', default_options) -- normal mode - save and exit
map('i', '<C-M-S>', '<Esc>:wq<CR>', default_options) -- insert mode - save and exit

map('n', '<C-M-a>', '<Esc>:Dash<CR>', default_options) -- open dash docs with word under cursor
map('n', '<M-->', 'yyp', default_options) -- open dash docs with word under cursor

vim.keymap.set('n', '<LEADER>0', '"0p', { desc = 'paste 0 register' }) -- open dash docs with word under cursor

-- copied from primeagen - https://www.youtube.com/watch?v=w7i4amO_zaE&t=562s
vim.keymap.set('x', '<LEADER>p', '"_dP', { desc = 'preserve " buffer when visual mode pasting' })

map('n', '<C-z>', '<NOP>', default_options)
-- map("n", "<C-M-z>", "<Esc>:ZenMode<CR>", default_options)
-- vim.keymap.set('n', '<D-:>', ':lua print "hello"<CR>')

-- replace the word that the cursor is on ... I flag means don't ignore case
vim.keymap.set('n', '<leader>a', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- gg
vim.keymap.set('n', '<LEADER>gg', '<CMD>silent !gg<CR>') --silent means supress all stdout (not added to message history)

vim.keymap.set('n', '<LEADER>cg', '<CMD>messages<CR>', { desc = 'vim messages' })
vim.keymap.set('n', '<LEADER>cc', '<CMD>messages clear<CR>', { desc = 'vim messages clear' })
