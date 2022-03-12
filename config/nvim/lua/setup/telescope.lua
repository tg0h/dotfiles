-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local previewers = require("telescope.previewers")
-- local action_state = require("telescope.actions.state")
-- local conf = require("telescope.config").values
local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.load_extension 'fzy_native'
telescope.load_extension 'file_browser'
telescope.load_extension 'heading' -- markdown headings
telescope.load_extension 'projects' -- recent projects
telescope.load_extension 'harpoon'

telescope.setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<esc>"] = actions.close
            },
        },
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})


-- local M = {}
-- M.search_dotfiles = function()
--     require("telescope.builtin").find_files({
--         prompt_title = "< VimRC >",
--         cwd = vim.env.DOTFILES,
--         hidden = true,
--     })
-- end

-- return M
