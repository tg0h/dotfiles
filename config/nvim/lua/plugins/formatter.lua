local M = {
  'mhartington/formatter.nvim',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_exec(
      [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.md,*.yaml,*.yml,*.json,*.js,*.mjs,*.jsx,*.tsx,*.ts,*.html,*.lua,*.edn FormatWrite
augroup END
]],
      true
    )

    local function prettierFormat()
      return {
        exe = 'prettierd',
        args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
        stdin = true,
      }
    end

    require('formatter').setup({
      filetype = {
        -- install stylua with brew
        lua = {
          function()
            return {
              exe = 'stylua',
              args = { '--config-path ' .. os.getenv('XDG_CONFIG_HOME') .. '/stylua/stylua.toml', '-' },
              stdin = true,
            }
          end,
        },

        html = { prettierFormat },
        typescript = { prettierFormat },
        typescriptreact = { prettierFormat },
        javascript = { prettierFormat },
        javascriptreact = { prettierFormat },
        json = { prettierFormat },
        markdown = { prettierFormat },
        yaml = { prettierFormat },
        sql = { prettierFormat },
        -- yaml = {
        --     function()
        --         return {
        --             -- exe = "yamlfix",
        --             -- args = {vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
        --             exe = "prettier",
        --             args = {"--single-quote", "false", "--parser", "yaml"},
        --             stdin = true
        --         }
        --     end
        -- }

        -- homebrew install zprint cask
        clojure = {
          function()
            return {
              exe = 'zprint',
              stdin = true,
            }
          end,
        },
      },
    })
  end,
}
return M
