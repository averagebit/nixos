local M = {
    "nvim-treesitter/nvim-treesitter",
    commit = "afa103385a2b5ef060596ed822ef63276ae88016",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            commit = "92e688f013c69f90c9bbd596019ec10235bc51de",
            event = "VeryLazy",
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            commit = "f6c71641f6f183427a651c0ce4ba3fb89404fa9e",
        },
    },
}

function M.config()
    require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "go",
            "rust",
            "lua",
            "markdown",
            "markdown_inline",
            "bash",
            "python",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "phpdoc" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,
            -- Disable for files larger than `max_filesize` or if it matches one
            -- of the languages in `langs`.
            disable = function(lang, buf)
                local langs = { "markdown" }
                local max_filesize = 100 * 1024 -- 100 KB
                for _, value in ipairs(langs) do
                    if lang == value[1] then
                        return true
                    end
                end
                local ok, stats =
                    pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },

        matchup = {
            enable = { "astro " },
            disable = { "lua" },
        },

        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },

        autopairs = { enable = true },
    })
end

return M
