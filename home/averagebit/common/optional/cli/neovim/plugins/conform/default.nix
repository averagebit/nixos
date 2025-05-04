{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = conform-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("conform").setup({
            formatters_by_ft = {
              bash = { "shfmt", lsp_format = "fallback" },
              cue = { "cueimports", lsp_format = "fallback" },
              go = { "gofumpt", lsp_format = "fallback" },
              lua = { "stylua" },
              mksh = { "shfmt", lsp_format = "fallback" },
              nix = { "alejandra", lsp_format = "fallback" },
              python = { "black", lsp_format = "fallback" },
              rust = { "rustfmt", lsp_format = "fallback" },
              sh = { "shfmt", lsp_format = "fallback" },
              shell = { "shfmt", lsp_format = "fallback" },
              webassembly = { "wasm-language-tools", lsp_format = "fallback" };
              angular = { "prettierd", "prettier", stop_after_first = true },
              css = { "prettierd", "prettier", stop_after_first = true },
              flow = { "prettierd", "prettier", stop_after_first = true },
              graphql = { "prettierd", "prettier", stop_after_first = true },
              html = { "prettierd", "prettier", stop_after_first = true },
              json = { "prettierd", "prettier", stop_after_first = true },
              jsx = { "prettierd", "prettier", stop_after_first = true },
              javascript = { "prettierd", "prettier", stop_after_first = true },
              less = { "prettierd", "prettier", stop_after_first = true },
              markdown = { "prettierd", "prettier", stop_after_first = true },
              scss = { "prettierd", "prettier", stop_after_first = true },
              typescript = { "prettierd", "prettier", stop_after_first = true },
              vue = { "prettierd", "prettier", stop_after_first = true },
              yaml = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = function(bufnr)
              -- Disable autoformat on certain filetypes
              local ignore_filetypes = { "sql", "java" }
              if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
              end
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              -- Disable autoformat for files in a certain path
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              if bufname:match("/node_modules/") then
                return
              end
              -- ...additional logic...
              return { timeout_ms = 500, lsp_format = "fallback" }
            end,
          })
          vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
              -- FormatDisable! will disable formatting just for this buffer
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end, {
            desc = "Disable autoformat-on-save",
            bang = true,
          })
          vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end, {
            desc = "Re-enable autoformat-on-save",
          })
        '';
    }
  ];
}
