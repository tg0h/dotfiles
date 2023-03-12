vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.md,*.yaml,*.yml,*.json,*.js,*.mjs,*.jsx,*.tsx,*.ts,*.html,*.lua FormatWrite
augroup END
]], true)

local function prettierFormat()
    return {
        exe = 'prettier',
        args = {'--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
        stdin = true
    }
end

require('formatter').setup({
    filetype = {
        -- install luarocks with brew
        -- https://github.com/Koihik/LuaFormatter
        lua = {function() return {exe = 'lua-format', args = {'-i'}, stdin = true} end},

        html = {prettierFormat},
        typescript = {prettierFormat},
        typescriptreact = {prettierFormat},
        javascript = {prettierFormat},
        javascriptreact = {prettierFormat},
        json = {prettierFormat},
        markdown = {prettierFormat},
        yaml = {prettierFormat},
        sql = {prettierFormat}
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
    }
})
