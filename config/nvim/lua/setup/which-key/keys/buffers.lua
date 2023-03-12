local M = {
    name = 'Buffers',
    b = {
        '<cmd>lua require\'telescope.builtin\'.buffers({ sort_mru = true, ignore_current_buffer = true })<cr>',
        'Find buffer'
    },
    a = {'<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>', 'Close all but the current buffer'},
    d = {'<cmd>Bdelete!<CR>', 'Close Buffer'},
    f = {'<cmd>BufferLinePick<cr>', 'Pick buffer'},
    l = {'<cmd>BufferLineCloseLeft<cr>', 'Close all buffers to the left'},
    p = {'<cmd>BufferLineMovePrev<cr>', 'Move buffer prev'},
    n = {'<cmd>BufferLineMoveNext<cr>', 'Move buffer next'},
    r = {'<cmd>BufferLineCloseRight<cr>', 'Close all BufferLines to the right'},
    x = {'<cmd>BufferLineSortByDirectory<cr>', 'Sort BufferLines automatically by directory'},
    L = {'<cmd>BufferLineSortByExtension<cr>', 'Sort BufferLines automatically by extension'}
}
return M
