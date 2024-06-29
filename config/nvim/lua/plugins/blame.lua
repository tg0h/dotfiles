return {
  'FabijanZulj/blame.nvim',
  -- cmd = 'ToggleBlame',
  keys = { { '<M-b>', '<CMD>BlameToggle<CR>', desc = 'toggle blame' } },
  opts = {
    date_format = '%Y-%m-%d %H:%M:%S',
    virtual_style = 'float', -- or right_align
    views = {
      window = window_view,
      virtual = virtual_view,
      default = window_view,
    },
    merge_consecutive = false,
    max_summary_width = 30,
    colors = nil,
    commit_detail_view = 'vsplit',
    -- format_fn = formats.commit_date_author_fn,
    mappings = {
      commit_info = 'i',
      stack_push = '<TAB>',
      stack_pop = '<BS>',
      show_commit = '<CR>',
      close = { '<esc>', 'q' },
    },
  },
}
