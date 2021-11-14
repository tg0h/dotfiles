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
                    \ {'path': '~/certis/docs/wiki', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1},
                    \]
let g:vimwiki_folding = 'expr' "but this setting does not fold headers
let g:vimwiki_global_ext = 0    "this setting turns off the association of the vimwiki file type to markdown files outside of the vimwiki folder
"
"if fileType is vimwiki -- also, see ToggleCalendar function defined above
:autocmd FileType vimwiki map <localleader>d :VimwikiMakeDiaryNote<CR>
:autocmd FileType vimwiki map <localleader>c :call ToggleCalendar()<CR> 
