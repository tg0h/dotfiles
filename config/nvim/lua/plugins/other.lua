return {
  'rgroli/other.nvim',
  config = function()
    require('other-nvim').setup({
      mappings = {
        -- custom mapping
        {
          -- packages/common-services/services/contactCampaignSetting/ContactCampaignSettingService.ts
          pattern = '/packages/common%-services/services/(.*)/.*.ts$',
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
        },
      },
      transformers = {
        -- defining a custom transformer
        lowercase = function(inputString) return inputString:lower() end,
        -- removeService = function(inputString) return inputString.gsub('Service', '') end,
        uppercaseFirstLetter = function(str) return (str:gsub('^%l', string.upper)) end,
      },
      style = {
        -- How the plugin paints its window borders
        -- Allowed values are none, single, double, rounded, solid and shadow
        border = 'solid',

        -- Column seperator for the window
        seperator = '|',

        -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
        width = 0.9,

        -- min height in rows.
        -- when more columns are needed this value is extended automatically
        minHeight = 10,
      },
    })
  end,
}
