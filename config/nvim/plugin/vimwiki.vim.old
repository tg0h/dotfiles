" map <S-Space> <Plug>VimwikiToggleListItem
noremap <F7> :VimwikiTable<CR>

"vimwiki ----------------------------------------------------------
"wiki_1 is currently not in use
let wiki_1 = {}
let wiki_1.path = '~/src/certis/argus/argus-apps/argus-cc-test/docs/website/docs'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.list_margin = 0 "set the list indent to 0 when generating the diary index or TOC, this prevents markdown from treating the list as indented text
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let wiki_1.custom_wiki2html = 'C:\users\timothy_goh\Desktop\vimwiki\timTest.ps1'

let g:vimwiki_list = [
                    \ {'path': '~/docs/zettel', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1},
                    \]
let g:vimwiki_folding = 'expr' "but this setting does not fold headers
let g:vimwiki_global_ext = 0    "this setting turns off the association of the vimwiki file type to markdown files outside of the vimwiki folder
"
"if fileType is vimwiki -- also, see ToggleCalendar function defined above
:autocmd FileType vimwiki map <localleader>d :VimwikiMakeDiaryNote<CR>
:autocmd FileType vimwiki map <localleader>c :call ToggleCalendar()<CR> 

" zettel
" https://www.reddit.com/r/Zettelkasten/comments/fidaum/vimzettel_an_addon_for_the_vimwiki_addon_for_vim/
let g:zettel_options = [{"template" :  "~/.config/zettel/zettel.tpl", "disable_front_matter": 1}]

" let g:zettel_format = '%Y%m%d-%H%M%S'
let g:zettel_format = '%Y%m%d-%H%M'

" inoremap [[ [[<esc>:ZettelSearch<CR>
imap <silent> [[ [[<esc><Plug>ZettelSearchMap

nmap T <Plug>ZettelYankNameMap

nmap gZ <Plug>ZettelReplaceFileWithLink

nnoremap <leader>vt :VimwikiSearchTags<space>

nnoremap <leader>vs :VimwikiSearch<space>

nnoremap <leader>gt :VimwikiRebuildTags!<cr>:VimwikiGenerateTagLinks<cr><c-l>

nnoremap <leader>zl :ZettelSearch<cr>

nnoremap <leader>zn :ZettelNew<cr><cr>:4d<cr>:w<cr>ggA

nnoremap <leader>bl :VimwikiBacklinks<cr>

let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"

let g:zettel_fzf_options = ['--exact', '--tiebreak=end']
