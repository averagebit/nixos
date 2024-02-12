local M = {
    "ahmedkhalf/project.nvim",
    commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
    event = "VeryLazy",
}

function M.config()
    require("project_nvim").setup({
        active = true,
        on_config_done = nil,
        manual_mode = false,
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        detection_methods = { "pattern" },
        patterns = {
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "Makefile",
            "package.json",
            "pom.xml",
        },
    })
    require("telescope").load_extension("projects")
end

return M
