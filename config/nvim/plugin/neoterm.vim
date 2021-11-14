" let g:neoterm_default_mod='belowright' " open terminal in bottom split
let g:neoterm_default_mod='botright vertical' " open terminal in bottom split
" let g:neoterm_size=150 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
" toggle terminal window
" neoterm keymaps
nnoremap <leader>tt :Ttoggle<cr> 
" open new neoterm terminal
nnoremap <leader>tn :Tnew<cr>
nnoremap <leader>tl :Tls<cr>
nnoremap <leader>tc :Tclose<cr>
" vnoremap <leader><cr> :TREPLSendSelection<cr> " send current selection
" https://github.com/kassio/neoterm/issues/314
" use this remap to escape from a neoterm terminal
tnoremap <C-\><C-\> <C-\><C-n>
" nnoremap <leader>ts :TREPLSendLine<cr>

" neoterm keymaps
" scratch function -----
"run the zsh ss command to source my scratch function
nnoremap <leader>hn :T ss<cr> 
"run the zsh tt to run my scratch function
nnoremap <leader>ht :T tt<cr> 
" current file  -----
"copy the last run command into the t register
nnoremap <leader>nh :let @t=@:<cr> 
" tell neo term to source current file
nnoremap <localleader>nh :T source %<cr> 
"run the t register as an ex command
nnoremap <localleader>th :@t<cr> 
