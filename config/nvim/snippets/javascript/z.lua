local ls = require('luasnip') -- {{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {} -- }}}

local group = vim.api.nvim_create_augroup('Javascript Snippets', { clear = true })
local file_pattern = '*.js,*.mjs'

local function cs(trigger, nodes, opts) -- {{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == 'string' then
      if opts == 'auto' then
        target_table = autosnippets
      else
        table.insert(keymaps, { 'i', opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == 'table' then
      for _, keymap in ipairs(opts) do
        if type(keymap) == 'string' then
          table.insert(keymaps, { 'i', keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= 'auto' then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd('BufEnter', {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end -- }}}

cs(
  'zhcs',
  fmt(
    [[
import http from 'http'

const server = http.createServer((req, res) => {{
  res.writeHead('200', {{ 'Content-Type': 'application/json' }})
  const payload = JSON.stringify({{ hello: 'world' }})
  res.write(payload)
  res.end()
}})

server.listen({})
{}
]],
    { c(1, { t('80'), i(1) }), i(0) }
  )
)

cs(
  'zhttppost',
  fmt(
    [[
import http from 'http'

const opts = {{
  method: 'post',
  hostname: 'pie.dev',
  path: '/post',
}}

const req = http.request(opts, (res) => {{
  process.stdout.write('status Code: ' + res.statusCode + '\n')
  res.pipe(process.stdout)
}})

req.on('error', (err) => {{
  console.error('error:', err)
}})

const payload = `{{
  "hello": "world"
}}`
req.end(payload)
]],
    {}
  )
)

cs(
  'zchildprocess',
  fmt(
    [[
import {{ fork }} from 'child_process'

const child = fork('child.js')
child.send('hello world')
child.on('message', (message) => console.log(`parent received message from child ${{message}}`))

//child.js
process.on('message', (message) => console.log(`child received ${{message}} from parent`))
process.send('child sending this message to parent')
]],
    {}
  )
)

cs(
  'zreadstream',
  fmt(
    [[
import fs from 'fs'
const rs = fs.createReadStream('./file.txt')

rs.on('data', (data) => {{
  console.log('read data', data.toString())
}})
rs.on('end', () => {{
  console.log('done')
}})
]],
    {}
  )
)

cs(
  'ztransform',
  fmta(
    [[
import fs from "fs";
import { Transform } from "stream";

const i = fs.createReadStream("in");
const o = fs.createWriteStream("out");

class Uppercase extends Transform {
  constructor() {
    super(); //pass options to super if you want to configure Transform, eg super({...options})
  }
  _transform(chunk, encoding, callback) {
    this.push(chunk.toString().toUpperCase());
    callback();
  }
}

const u = new Uppercase()
i.pipe(u).pipe(o)
]],
    {}
  )
)

cs(
  'zcluster',
  fmta( -- add a cluster
    [[
import { createServer } from 'http'
import { cpus } from 'os'
import cluster from 'cluster'

if (cluster.isPrimary) {
  const availableCpus = cpus()
  availableCpus.forEach(() =>> {
    cluster.fork()
  })
} else {
  const server = createServer((req, res) =>> {
    console.log(`Handling request from ${process.pid}`)
    res.end(`Hello from ${process.pid}\n`)
  })

  server.listen(8080)
}

]],
    {}
  )
)

return snippets, autosnippets
