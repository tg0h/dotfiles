-- require('core.diagnostic')
require('keymaps')
require('config.options')
require('config.autocmd')
require('utils.files') -- used by kitty tab switcher to open latest changed files in dir

require('utils.files').load_env()
-- Plugin management via lazy
require('config.lazy')
