local M = {
    "folke/which-key.nvim",
    commit = "ce741eb559c924d72e3a67d2189ad3771a231414",
    event = "VeryLazy",
}

function M.config()
    require("which-key").setup({})
end

return M
