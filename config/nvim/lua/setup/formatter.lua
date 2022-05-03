vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.md,*.yaml,*.yml,*.json,*.js,*.mjs,*.tsx,*.ts,*.html FormatWrite
augroup END
]], true)

require("formatter").setup({
    filetype = {

        -- install luarocks with brew
        -- https://github.com/Koihik/LuaFormatter
        lua = {
            function()
                return {
                    exe = "lua-format",
                    args = {
                        "-i", "--no-keep-simple-function-one-line",
                        "--no-break-after-operator", "--break-after-table-lb",
                        "--no-break-before-functioncall-rp",
                        "--no-chop-down-parameter",
                        "--single-quote-to-double-quote",
                        "--no-keep-simple-control-block-one-line",
                        "--no-keep-simple-function-one-line",
                        "--no-break-after-functioncall-lp"
                    },
                    stdin = true
                }
            end
        },

        -- javascript = {
        --     -- prettier
        --     function()
        --         return {
        --             exe = "standard",
        --             args = {
        --                 "--stdin",
        --                 vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        --                 "--fix"
        --             },
        --             stdin = true,
        --             ignore_exitcode = true
        --         }
        --     end
        -- },

        html = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        typescriptreact = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        typescript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        javascript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        -- go = {
        --     function()
        --         return {
        --             exe = "gofmt",
        --             args = {
        --                 "-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
        --             },
        --             stdin = false
        --         }
        --     end
        -- },

        json = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        markdown = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                    },
                    stdin = true
                }
            end
        },

        -- python = {
        --     function()
        --         return {exe = "black", args = {"-"}, stdin = true}
        --     end
        -- },

        yaml = {
            function()
                return {
                    -- exe = "yamlfix",
                    -- args = {vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
                    exe = "prettier",
                    args = {"--single-quote", "false", "--parser", "yaml"},
                    stdin = true
                }
            end
        }
    }
})
