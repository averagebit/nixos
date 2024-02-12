local M = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            commit = "e7b64c11035aa924f87385b72145e0ccf68a7e0a",
            lazy = true,
        },
        "nvim-lua/plenary.nvim",
    },
}

local servers = require("user.lsp.servers")
local icons = require("user.icons")

function M.config()
    require("mason").setup({
        ui = {
            border = "none",
            icons = {
                package_installed = icons.ui.Check,
                package_pending = icons.ui.Close,
                package_uninstalled = icons.ui.Forward,
            },
            keymaps = {
                -- Keymap to expand a package
                toggle_package_expand = "<CR>",
                -- Keymap to install the package under the current cursor position
                install_package = "i",
                -- Keymap to reinstall/update the package under the current cursor position
                update_package = "u",
                -- Keymap to check for new version for the package under the current cursor position
                check_package_version = "c",
                -- Keymap to update all installed packages
                update_all_packages = "U",
                -- Keymap to check which installed packages are outdated
                check_outdated_packages = "C",
                -- Keymap to uninstall a package
                uninstall_package = "X",
                -- Keymap to cancel a package installation
                cancel_installation = "<C-c>",
                -- Keymap to apply language filter
                apply_language_filter = "<C-f>",
            },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    })
    require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
    })
end

return M
