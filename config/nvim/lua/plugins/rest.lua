-- plugins/rest.lua
return {
  {
    'vhyrro/luarocks.nvim',
    opts = {
      rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' }, -- Specify LuaRocks packages to install
    },
    priority = 1000,
    config = true,
  },
  {
    'rest-nvim/rest.nvim',
    -- dependencies = { { 'nvim-lua/.nvim' } },
    dependencies = { 'luarocks.nvim' },
    -- event = 'VeryLazy',
    ft = 'http', -- https://github.com/rest-nvim/rest.nvim/discussions/249, get rest.nvim to work and recognize http filetype
    -- keys = {
    --   { '<leader>zz', '<Plug>RestNvim', desc = 'rest nvim run' },
    --   { '<leader>zp', '<Plug>RestNvimPreview', desc = 'rest nvim preview' },
    --   { '<leader>z.', '<Plug>RestNvimLast', desc = 'rest nvim last' },
    -- },
    config = function()
      require('rest-nvim').setup({
        client = 'curl',
        env_file = '.env',
        env_pattern = '\\.env$',
        env_edit_command = 'tabedit',
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = 'info',
          save = true,
        },
        result = {
          split = {
            horizontal = true,
            in_place = true,
            stay_in_current_window_after_split = true,
          },
          behavior = {
            decode_url = true,
            show_info = {
              url = true,
              headers = true,
              http_info = true,
              curl_command = true,
            },
            statistics = {
              enable = true,
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { 'total_time', title = 'Time taken:' },
                { 'size_download_t', title = 'Download size:' },
              },
            },
            formatters = {
              json = 'jq',
              html = function(body)
                if vim.fn.executable('tidy') == 0 then return body, { found = false, name = 'tidy' } end
                local fmt_body = vim.fn
                  .system({
                    'tidy',
                    '-i',
                    '-q',
                    '--tidy-mark',
                    'no',
                    '--show-body-only',
                    'auto',
                    '--show-errors',
                    '0',
                    '--show-warnings',
                    '0',
                    '-',
                  }, body)
                  :gsub('\n$', '')

                return fmt_body, { found = true, name = 'tidy' }
              end,
            },
          },
          keybinds = {
            buffer_local = true,
            prev = 'H',
            next = 'L',
          },
        },
        highlight = {
          enable = true,
          timeout = 750,
        },
        ---Example:
        ---
        ---```lua
        ---keybinds = {
        ---  {
        ---    "<localleader>rr", "<cmd>Rest run<cr>", "Run request under the cursor",
        ---  },
        ---  {
        ---    "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request",
        ---  },
        ---}
        ---
        ---```
        ---@see vim.keymap.set
        keybinds = {},
      })
    end,
  },
}
