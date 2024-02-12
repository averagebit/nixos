local M = {
    "lukas-reineke/indent-blankline.nvim",
    commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
    event = "VeryLazy",
}

function M.config()
    local icons = require("user.icons")

    require("indent_blankline").setup({
        filetype_exclude = {
            "NvimTree",
            "Trouble",
            "dashboard",
            "help",
            "lazy",
            "neogitstatus",
            "packer",
            "startify",
            "text",
        },
        -- char = icons.ui.LineLeft,
        -- context_char = icons.ui.LineLeft,
        buftype_exclude = { "terminal", "nofile" },
        char = icons.ui.LineMiddle,
        context_char = icons.ui.LineMiddle,
        show_current_context = true,
        show_first_indent_level = true,
        show_trailing_blankline_indent = false,
        use_treesitter = true,
    })
end

return M
