{
  programs.neovim.extraLuaConfig =
    /*
    lua
    */
    ''
      local map = vim.keymap.set
      local opts = { silent = true }

      map("", "<Space>", "<Nop>", opts)
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Modes
      --   normal_mode = "n",
      --   insert_mode = "i",
      --   visual_mode = "v",
      --   visual_block_mode = "x",
      --   term_mode = "t",
      --   command_mode = "c",

      -- Handle typos
      vim.cmd([[
          cnoreabbrev W w
          cnoreabbrev Q q
          cnoreabbrev qw wq
          cnoreabbrev Wq wq
          cnoreabbrev WQ wq
          cnoreabbrev Qa qa
          cnoreabbrev # q
          cnoreabbrev w# wq
          cnoreabbrev W# wq
          cnoreabbrev #w wq
          cnoreabbrev #W wq
          cnoreabbrev #a wq
          cnoreabbrev Bd bd
          cnoreabbrev bD bd
      ]])

      -- Yank to the end of the line
      map("n", "Y", "y$", opts)

      -- Stay in indent mode
      map("v", "<", "<gv", opts)
      map("v", ">", ">gv", opts)

      -- Maintain cursor position and keep it centered during search & joining
      map("n", "n", "nzzzv", opts)
      map("n", "N", "Nzzzv", opts)
      map("n", "J", "mzJ`z", opts)

      -- Resize with arrows
      map("n", "<Up>", "<cmd>resize -2<CR>", opts)
      map("n", "<Down>", "<cmd>resize +2<CR>", opts)
      map("n", "<Left>", "<cmd>vertical resize -2<CR>", opts)
      map("n", "<Right>", "<cmd>vertical resize +2<CR>", opts)

      local wk = require "which-key"
      wk.add {
        -- Open last file
        { "ga", "<cmd>e#<CR>", desc = "Open last file"},

        -- Navigate buffers
        { "gq", "<cmd>Bdelete!<cr>", desc = "Close buffer" },
        { "gn", "<cmd>bnext<cr>", desc = "Open next buffer" },
        { "gp", "<cmd>bprevious<cr>", desc = "Open previous buffer" },

        -- Drag current line/s vertically and auto-indent
        { "<leader>k", "<cmd>m-2<cr>", desc = "Drag line up" },
        { "<leader>j", "<cmd>m+<cr>", desc = "Drag line down" },
        { "<leader>k", "<cmd>m-2<cr>", desc = "Drag line up", mode = "v" },
        { "<leader>j", "<cmd>m+<cr>", desc = "Drag line down", mode = "v" },

        -- Editor
        { "<CR>", "<cmd>let @/ = \'\'<CR><CR>", desc = "Toggle visual effects" },
        { "<leader>ts", "<cmd>setlocal spell!<cr>", desc = "Toggle spell checking" },
        { "<leader>tn", "<cmd>setlocal nonumber!<CR><cmd>setlocal rnu!<CR>", desc = "Toggle line numbers" },
        { "<leader>tw", "<cmd>execute('setlocal wrap! breakindent! colorcolumn='. (&colorcolumn == \'\' ? &textwidth : \'\'))<CR>", desc = "Toggle wrapping" },
      }
    '';
}
