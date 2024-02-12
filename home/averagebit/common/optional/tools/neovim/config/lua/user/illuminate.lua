local M = {
    "RRethy/vim-illuminate",
    commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86",
    event = "VeryLazy",
}

function M.config()
    require("illuminate").configure({
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        delay = 200,
        filetypes_denylist = {
            "DiffviewFiles",
            "DressingInput",
            "DressingSelect",
            "Jaq",
            "NeogitCommitMessage",
            "NeogitStatus",
            "NvimTree",
            "Outline",
            "TelescopePrompt",
            "Trouble",
            "alpha",
            "dirvish",
            "fugitive",
            "harpoon",
            "lazy",
            "lir",
            "mason",
            "minifiles",
            "neogitstatus",
            "netrw",
            "packer",
            "qf",
            "spectre_panel",
            "toggleterm",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
    })
end

return M
