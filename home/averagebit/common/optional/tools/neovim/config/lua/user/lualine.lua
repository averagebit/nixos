local M = {
    "nvim-lualine/lualine.nvim",
    commit = "7533b0ead663d80452210c0c089e5105089697e5",
    event = {
        "VimEnter",
        "InsertEnter",
        "BufReadPre",
        "BufAdd",
        "BufNew",
        "BufReadPost",
    },
}

function M.config()
    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end

    local icons = require("user.icons")

    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
            error = icons.diagnostics.BoldError .. " ",
            warn = icons.diagnostics.BoldWarning .. " ",
        },
        colored = false,
        always_visible = true,
    }

    local diff = {
        "diff",
        colored = false,
        symbols = {
            added = icons.git.LineAdded,
            modified = icons.git.LineModified,
            removed = icons.git.LineRemoved,
        },
        cond = hide_in_width,
    }

    local filetype = {
        "filetype",
        icons_enabled = false,
    }

    local location = {
        "location",
        padding = 0,
    }

    local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    require("lualine").setup({
        extensions = { "quickfix", "man", "fugitive" },
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            always_divide_middle = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            ignore_focus = { "NvimTree" },
            disabled_filetypes = { "alpha", "dashboard" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = { diagnostics },
            lualine_x = { diff, spaces, "encoding", filetype },
            lualine_y = { location },
            lualine_z = { "progress" },
        },
    })
end

return M
