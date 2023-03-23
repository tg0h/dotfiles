local M = {
  name = "Window",
  a = { "<C-w><C-o>", "Close all other splits" },
  q = { "<cmd>:q<cr>", "Close" },
  s = { "<cmd>:split<cr>", "Horizontal Split" },
  t = { "<c-w>t", "Move to new tab" },
  ["="] = { "<c-w>=", "Equally size" },
  v = { "<cmd>:vsplit<cr>", "Vertical Split" },
  w = { "<c-w>x", "Swap" },
  z = { "<C-w>_<C-w>|<CR>", "Zoom Split" },
}
return M
