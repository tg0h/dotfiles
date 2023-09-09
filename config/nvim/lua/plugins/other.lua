return {
  'rgroli/other.nvim',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_set_keymap('n', '<LEADER>oa', '<CMD>:Other<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LEADER>otn', '<CMD>:OtherTabNew<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LEADER>op', '<CMD>:OtherSplit<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LEADER>ov', '<CMD>:OtherVSplit<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<LEADER>oc', '<CMD>:OtherClear<CR>', { noremap = true, silent = true })

    -- Context specific bindings
    -- vim.api.nvim_set_keymap('n', '<LEADER>ot', '<CMD>:Other test<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<LEADER>os', '<CMD>:Other scss<CR>', { noremap = true, silent = true })
    require('other-nvim').setup({
      mappings = {
        -- custom mapping
        {
          -- packages/common-services/services/contactCampaignSetting/ContactCampaignSettingService.ts
          pattern = '/packages/common%-services/services/(.*)/.*Service.ts$',
          target = {
            -- packages/common-services/services/contactCampaignSetting/IContactCampaignSettingService.ts
            {
              target = '/packages/common%-services/services/%1/I%1Service.ts',
              context = 'interface',
              transformer = 'uppercaseFirstLetter',
            },
            -- packages/common-services/services/contactCampaignSetting/makeContactCampaignSettingService.ts
            {
              target = '/packages/common%-services/services/%1/make%1Service.ts',
              context = 'make',
              transformer = 'uppercaseFirstLetter',
            },
            -- packages/common-services/tests/services/contactCampaignSetting/ContactCampaignSettingService.test.ts
            {
              target = '/packages/common%-services/tests/services/%1/%1Service.test.ts',
              context = 'test',
              transformer = 'uppercaseFirstLetter',
            },
            -- packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
            {
              target = '/packages/common%-services/repositories/%1/Sequelize%1Repository.ts',
              context = 'repository',
              transformer = 'uppercaseFirstLetter',
            },
            -- packages/common-services/models/contactCampaignSetting.ts
            { target = '/packages/common%-services/models/%1.ts', context = 'model' },
          },
          {
            pattern = './make.*Service.ts',
            target = './%1Service.ts',
            context = 'service',
            transformer = 'uppercaseFirstLetter',
          },
        },
      },
      transformers = {
        -- defining a custom transformer
        lowercase = function(inputString) return inputString:lower() end,
        -- removeService = function(inputString) return inputString.gsub('Service', '') end,
        uppercaseFirstLetter = function(str) return (str:gsub('^%l', string.upper)) end,
      },

      -- Should the window show files which do not exist yet based on
      -- pattern matching. Selecting the files will create the file.
      showMissingFiles = true,

      -- When a mapping requires an initial selection of the other file, this setting controls,
      -- wether the selection should be remembered for the current user session.
      -- When this option is set to false reference between the two buffers are never saved.
      -- Existing references can be removed on the buffer with :OtherClear
      rememberBuffers = false,

      keybindings = {
        ['<cr>'] = 'open_file()',
        ['<esc>'] = 'close_window()',
        t = 'open_file_tabnew()',
        o = 'open_file()',
        q = 'close_window()',
        v = 'open_file_vs()',
        s = 'open_file_sp()',
      },

      hooks = {
        -- This hook which is executed when the file-picker is shown.
        -- It could be used to filter or reorder the files in the filepicker.
        -- The function must return a lua table with the same structure as the input parameter.
        --
        -- The input parameter "files" is a lua table with each entry containing:
        -- @param table (filename (string), context (string), exists (boolean))
        -- @return table
        filePickerBeforeShow = function(files) return files end,

        -- This hook is called whenever a file is about to be opened.
        -- One example how this can be used: a non existing file needs to be opened by another plugin, which provides a template.
        --
        -- @param filename (string) the full-path of the file
        -- @param exists (boolean) doess the file already exist
        -- @return (boolean) When true (default) the plugin takes care of opening the file, when the function returns false this indicated that opening of the file is done in the hook.
        onOpenFile = function(filename, exists) return true end,
      },

      style = {
        -- How the plugin paints its window borders
        -- Allowed values are none, single, double, rounded, solid and shadow
        border = 'solid',

        -- Column seperator for the window
        seperator = '|',

        -- Indicator showing that the file does not yet exist
        newFileIndicator = '(* new *)',

        -- width of the window in percent. e.g. 0.5 is 50%, 1 is 100%
        width = 0.7,

        -- min height in rows.
        -- when more columns are needed this value is extended automatically
        minHeight = 10,
      },
    })
  end,
}
