require("sidebar-nvim").setup({
    disable_default_keybindings = 0,
    bindings = nil,
    open = false,
    side = "left",
    initial_width = 35,
    hide_statusline = false,
    update_interval = 1000,
    sections = { "git", "symbols", "todos", "diagnostics", "buffers", "containers" },
    section_separator = {"", "-----", ""},
    containers = {
        icon = "",
        use_podman = false,
        attach_shell = "/bin/zsh",
        show_all = true, -- whether to run `docker ps` or `docker ps -a`
        interval = 2000 -- the debouncer time frame to limit requests to the docker daemon
    },
    -- datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
    todos = {
        icon = "",
        ignored_paths = {"~"}, -- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
        initially_closed = false -- whether the groups should be initially closed on start. You can manually open/close groups later.
    },
    disable_closing_prompt = false
})
