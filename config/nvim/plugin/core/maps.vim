" Vim mappings ====================================================================================================
" n                 normal mode map
" i                 insert
" v                 visual and select mode
" x                 visual mode map
" s                 select mode map - mode that mimics selection in windows, 
" c                 command line mode map
" o                 operator pending mode map
" :map or :noremap  normal, visual, and operator pending mode map
let mapleader = " "
let maplocalleader = ","
" " Line moving
" " " Normal mode
nnoremap <Esc>^[[1;5B> :m .+1<CR>==
nnoremap <Esc>^[[1;5A> :m .-2<CR>==
" " Insert mode
" inoremap <C-j> <ESC>:m .+1<CR>==gi
" inoremap <C-k> <ESC>:m .-2<CR>==gi
" '> is a mark that identifies the line the last visual selection is on
" +1 means move down 1 line
" <CR> executes the m command (which ends the visual highlight)
" gv reselects the last visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"backspace to previous buffer
noremap <BS> :bprevious<cr>  
"next
noremap <S-BS> :bnext<cr> 
"close
nnoremap <Leader>q :Bdelete<CR> 

"quickfix
nnoremap n :cn<cr> " map alt n to next in quickfix list (this only works in iterm, not in mvim) 
" nnoremap ˜ :cn<cr> " map alt n to next in quickfix list (this only works in mvim) 
nnoremap p :cp<cr> " map alt p to next in quickfix list (this only works in iterm, not in mvim)
nnoremap π :cp<cr> " map alt n to next in quickfix list (this only works in mvim) 
"====================================================================================================

" even in insert mode, F2 means save
" ctrl o escapes insert mode so we can send :w
" inoremap <F2> <C-O>:w <CR>
" noremap <F2> :w <CR>
noremap <localleader>w :w<CR>
" update is like write, but only when buffer is modified
noremap <leader>ev :e ~/dotfiles/config/nvim/init.vim<CR>
noremap <leader>sv :source ~/dotfiles/config/nvim/init.vim<CR>
" nmap <F4> i<C-R>=strftime("%B %d %Y %A")<CR><Esc>
noremap <F6> :setlocal spell! spelllang=en_gb<CR> " Toggle Spellcheck
