"airline settings---------------------------------------------------------------------->
" let g:airline_powerline_fonts = 1 "enable arrow separator
" let g:airline_theme='jellybeans'
" set encoding=utf-8 "to allow powerline fonts to work
" Lightline
let g:lightline = {
  \     'colorscheme': 'powerlineish',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }
