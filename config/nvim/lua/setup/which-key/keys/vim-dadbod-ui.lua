local M = {
    name = 'vim dadbod ui',
    m = {'<CMD>DBUIToggle<CR>', 'DB Toggle'},
    h = {'<CMD>DBUIFindBuffer<CR>', 'DB Find Buffer'},
    j = {'<CMD>DBUIRenameBuffer<CR>', 'DB Rename Buffer'},
    v = {'<CMD>DBUILastQueryInfo<CR>', 'DB Last Query Info'},
    t = {'<Plug>(DBUI_ToggleResultLayout)', 'DB Toggle Result Layout'}
}
return M
