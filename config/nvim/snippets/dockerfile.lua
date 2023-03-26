local ls = require("luasnip") -- {{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} -- }}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) -- {{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  if opts ~= nil then
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end -- }}}

cs(
  "df",
  fmt(
    [[
FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
{}
]],
    { i(0) }
  )
)

return snippets, autosnippets
