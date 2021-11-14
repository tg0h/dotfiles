"WINDOW MANAGEMENT ====================================================================================================
" Quicker window movement
"not sure why ctrl j does not work
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
""need to change fzf ctrl h mapping
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" see the ANSI key code by running sed -n l
" alt arrow keys go to window
" nmap <silent> <Esc>[1;9C :wincmd l<CR>
" nmap <silent> <Esc>[1;9B :wincmd j<CR>
" nmap <silent> <Esc>[1;9D :wincmd h<CR>
" nmap <silent> <Esc>[1;9A :wincmd k<CR>
