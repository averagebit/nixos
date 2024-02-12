local M = {
    "rktjmp/paperplanes.nvim",
    commit = "bd52c54c36ad2e9ac563ae1c6a4f6ed1f5faacd2",
    event = "VeryLazy",
}

function M.config()
    require("paperplanes").setup({
        register = "+",
        provider = "paste.rs",
        provider_options = {},
        notifier = vim.notify or print,
    })
end

return M
