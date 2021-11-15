" " COC
" " " COC extension
" set shortmess+=c " for CoC plugin
" let g:coc_user_config = {}
" let g:coc_global_extensions = [
"       \ 'coc-emmet', 
"       \ 'coc-css', 
"       \ 'coc-html', 
"       \ 'coc-json', 
"       \ 'coc-prettier', 
"       \ 'coc-tsserver', 
"       \ 'coc-snippets', 
"       \ 'coc-eslint']
" " " To go back to previous state use Ctrl+O
" nmap <silent><leader>gd <Plug>(coc-definition)
" nmap <silent><leader>gy <Plug>(coc-type-definition)
" nmap <silent><leader>gi <Plug>(coc-implementation)
" nmap <silent><leader>gr <Plug>(coc-references)

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " " Always show the signcolumn, otherwise it would shift the text each time
" " " diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" " " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh() 

" " " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " " position. Coc only does snippet and additional edit on confirm.
" " " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" " " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" " " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected

" augroup mygroup
"   autocmd!
"   " " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " " Applying codeAction to the selected region.
" " " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " " Add (Neo)Vim's native statusline support.
" " " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
