local M = {
  name = "coverage",
  h = { "<CMD>lua require('coverage').load(true)<CR>", "load coverage" },
  g = { "<CMD>lua require('coverage').toggle()<CR>", "toggle coverage" },
  c = { "<CMD>lua require('coverage').clear()<CR>", "clear coverage" },
  s = { "<CMD>lua require('coverage').show()<CR>", "show coverage" },
  a = { "<CMD>lua require('coverage').hide()<CR>", "hide coverage" },
  o = { "<CMD>lua require('coverage').summary()<CR>", "show coverage summary" },
  n = { "<CMD>lua require('coverage').jump_next('uncovered')<CR>", "jump next uncovered" },
  p = { "<CMD>lua require('coverage').jump_prev('uncovered')<CR>", "jump prev uncovered" },
}
return M
