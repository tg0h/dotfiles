" ========== fzf vim January 10 2021 Sunday =============================
" rip grep
nnoremap <C-J> :Rg<CR> 

" open files in git only
nnoremap <C-K> :GFiles<CR> 
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

nnoremap <C-H> :History<cr>
" nnoremap <C-T> :Files<cr>
nnoremap <C-B> :Buffers<cr>
nmap <C-L> :Lines<cr>
nmap <LEADER>sbl :BLines<cr>

"Command History
nmap <leader>sh :History:<cr>
"Search History
nmap <leader>ss :History/<cr>

"Actions
nmap <leader>sc :Commands<cr>
nmap <leader>sm :Maps<cr>
nmap <leader>sk :Marks<cr>
nnoremap <leader>st :Files<cr>

" Git ---------------------------------
nmap <leader>sgc :Commits<cr>
nmap <leader>sbc :BCommits<cr>
"git ls-files
nmap <leader>sgf :GFiles<cr>
"git status
nmap <leader>sgs :GFiles?<cr>
" ---------------------------------

nmap <leader>st :Tags<cr>
nmap <leader>sbt :BTags<cr>
" ========== fzf vim January 10 2021 Sunday - END
