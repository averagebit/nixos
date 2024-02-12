local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
            lazy = true,
        },
    },
}

function M.config()
    local null_ls = require("null-ls")
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
        debug = false,
        sources = {
            -- formatting
            formatting.stylua,
            formatting.alejandra,
            formatting.goimports,
            formatting.gofumpt,
            formatting.terraform_fmt.with({
                extra_filetypes = { "hcl" },
            }),
            formatting.prettier.with({
                extra_filetypes = { "toml", "svelte", "astro" },
                -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            }),
        },
        on_attach = function(client, buf)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = buf,
                    callback = function()
                        vim.lsp.buf.format({
                            bufnr = buf,
                            filter = function(client)
                                return client.name == "null-ls"
                            end,
                        })
                    end,
                })
            end
        end,
    })
end

return M
