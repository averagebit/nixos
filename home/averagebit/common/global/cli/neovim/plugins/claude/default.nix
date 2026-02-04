{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    snacks-nvim
    {
      plugin = claudecode-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("claudecode").setup({
            config = true,
            keys = {
              { "<leader>a", nil, desc = "AI/Claude Code" },
              { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
              { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
              { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
              { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
              { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
              { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
              { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
              {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
              },
              -- Diff management
              { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
              { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
            },
            terminal = {
              cwd_provider = function(ctx)
                -- Prefer repo root; fallback to file's directory
                local cwd = require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
                return cwd
              end,
            },
          })
        '';
    }
  ];
}
