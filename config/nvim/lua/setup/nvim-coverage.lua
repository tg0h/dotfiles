require("coverage").setup(
  {commands = true, -- create commands
	highlights = {
		-- customize highlight groups created by the plugin
		-- covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
		covered = { fg = "green" },   -- supports style, fg, bg, sp (see :h highlight-gui)
		uncovered = { fg = "#F07178" },
	},
	signs = {
		-- use your own highlight groups or text markers
		covered = { hl = "CoverageCovered", text = "▎" },
		uncovered = { hl = "CoverageUncovered", text = "▎" },
	},
	summary = {
		-- customize the summary pop-up
		min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
    width_percentage = 1.0,
    height_percentage = 1.0,
	},
	lang = {
		-- customize language specific settings
    -- javascript = {coverage_file = "packages/api/api/coverage/lcov.info"},
    -- typescript = {coverage_file = "packages/api/api/coverage/lcov.info"},
    -- javascript = {coverage_file = "coverage/lcov.info"},
    javascript = {coverage_file = "/Users/tim/src/candy/main/referralcandy-main/coverage/lcov.info"},
    typescript = {coverage_file = "/Users/tim/src/candy/main/referralcandy-main/coverage/lcov.info"}
	},
})
