local map = vim.api.nvim_set_keymap
-- {desc=''} = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- Map the leader key
-- vim.keymap.set("n", "<Space>", "<NOP>", {desc=''})
vim.g.mapleader = ' '
-- vim.g.maplocalleader = ','
-- vim.g.maplocalleader = '<BS>' --doesn't work

-- Emacs emulation
vim.keymap.set('i', '<C-a>', '<Esc>I', { desc = 'go to beginning of line in insert mode' }) -- go to beginning of line in insert mode
vim.keymap.set('i', '<C-e>', '<Esc>A', { desc = 'go to end of line in insert mode' }) -- go to end of line in insert mode
vim.keymap.set('i', '<C-d>', '<Del>', { desc = 'delete in insert mode' })

-- Help
vim.keymap.set('n', '<F1>', ':WhichKey<CR>', { desc = 'show all which key mappings' }) -- show all mappings

-- nice defaults
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'centre after page down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'centre after page up' })
-- move lines, adds indent if moving eg into an if block
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move lines, adds indent if moving, eg into an if block' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move lines, adds indent if moving, eg into an if block' })
-- keep it centred when searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'keep it centred when searching' }) -- zv opens folds
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'keep it centred when searching' })
-- keep cursor on same place when you normal J
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'keep cursor location after normal J' })
-- granular undo break points
vim.keymap.set('i', ',', ',<C-g>u', { desc = 'granular undo break points' })
vim.keymap.set('i', '.', '.<C-g>u', { desc = 'granular undo break points' })
vim.keymap.set('i', '!', '!<C-g>u', { desc = 'granular undo break points' })
vim.keymap.set('i', '?', '?<C-g>u', { desc = 'granular undo break points' })
-- vimscript . concats strings
-- m' adds a context mark which also adds to the jump list as a side effect
map('n', 'j', [[ (v:count > 5 ? "m'" . v:count : "") . 'j' ]], expr_options)
map('n', 'k', [[ (v:count > 5 ? "m'" . v:count : "") . 'k' ]], expr_options)

-- vim.keymap.set("n", "gx", ":!open <C-R><C-A><CR>", expr_options)
-- https://vi.stackexchange.com/questions/27255/how-can-i-make-a-single-mapping-take-effect-for-both-normal-mode-insert-mode-a (you can't)
-- define for both normal and insert modes
vim.keymap.set('n', '<C-M-z>', ':cquit<CR>', { desc = 'normal mode exit with error code' }) -- exit with error code
vim.keymap.set('i', '<C-M-z>', '<Esc>:cquit<CR>', { desc = 'insert mode exit with error code' }) -- exit with error code

vim.keymap.set('n', '<C-M-e>', ':w<CR>', { desc = 'normal mode save' }) -- normal mode save
vim.keymap.set('i', '<C-M-e>', '<Esc>:w<CR>a', { desc = 'insert mode save' }) -- insert mode save

vim.keymap.set('n', '<C-M-S>', ':wq<CR>', { desc = 'normal mode save and exit' }) -- normal mode - save and exit
vim.keymap.set('i', '<C-M-S>', '<Esc>:wq<CR>', { desc = 'insert mode save and exit' }) -- insert mode - save and exit

vim.keymap.set('n', '<M-->', 'yyp', { desc = '' }) -- open dash docs with word under cursor

vim.keymap.set('n', '<LEADER>0', '"0p', { desc = 'paste 0 register' })

-- copied from primeagen - https://www.youtube.com/watch?v=w7i4amO_zaE&t=562s
vim.keymap.set('x', '<LEADER>p', '"_dP', { desc = 'preserve " buffer when visual mode pasting' })

-- vim.keymap.set('n', '<C-z>', '<NOP>', { desc = 'disable background job' })
-- vim.keymap.set("n", "<C-M-z>", "<Esc>:ZenMode<CR>", {desc=''})
-- vim.keymap.set('n', '<D-:>', ':lua print "hello"<CR>')

-- replace the word that the cursor is on ... I flag means don't ignore case
vim.keymap.set('n', '<leader>a', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'replace word under cursor' })

-- gg
vim.keymap.set('n', '<LEADER>gg', '<CMD>silent !gg<CR>', { desc = 'commit with gg script' }) --silent means supress all stdout (not added to message history)
vim.keymap.set(
  'n',
  '<LEADER>go',
  '<CMD>silent !gg -a<CR>',
  { desc = 'commit with gg script - only commit files that have already been added' }
)

vim.keymap.set('n', '<LEADER>.g', '<CMD>messages<CR>', { desc = 'show vim messages' })
vim.keymap.set('n', '<LEADER>.c', '<CMD>messages clear<CR>', { desc = 'clear vim messages' })

-- go to next ) and then a
-- vim.keymap.set('i', '<C-S-n>', '<Esc>%%a', { desc = 'place cursor after next )' })

-- only works in kitty without tmux and using autocmd to send csi u
-- vim.keymap.set("i", "<tab>", "a", {desc=''})
-- vim.keymap.set("i", "<C-m>", "m", {desc=''})

-- vim.keymap.set('n', '<F5>', ':luafile %<CR>', {desc=''})
