-- visual  - visually select then press s<char> or press sa{motion}{char}
-- replace - sr<from><to>
-- delete  - sd<char>
-- ss repeats last surround command.
require('surround').setup({
  -- context_offset = 100,
  -- load_autogroups = false,
  -- mappings_style = "sandwich",
  map_insert_mode = false, -- do not allow surround to create C-s insert mode keymaps
  -- quotes = {"'", "\""},
  -- brackets = {"(", '{', '[' },
  -- space_on_closing_char = false,
  -- pairs = {
  --   nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
  --   linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' }
  -- },
  prefix = 's',
})
