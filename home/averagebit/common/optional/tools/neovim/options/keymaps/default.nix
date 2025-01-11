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
          cnoreabbrev Bd bd
          cnoreabbrev bD bd
      ]])

      -- Open last file
      map("n", "<leader>o", "<cmd>e#<CR>", opts)

      -- Navigate buffers
      map("n", "<S-l>", "<cmd>bnext<CR>", opts)
      map("n", "<S-h>", "<cmd>bprevious<CR>", opts)

      -- Close buffers
      map("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

      -- Toggle editor's visual effects
      map("n", "<CR>", "<cmd>let @/ = \'\'<CR><CR>", opts)

      -- Clear highlights
      map("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

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

      -- Drag current line/s vertically and auto-indent
      map("n", "<Leader>k", "<cmd>m-2<CR>", opts)
      map("n", "<Leader>j", "<cmd>m+<CR>", opts)
      map("v", "<Leader>k", "<cmd>m'<-2<CR>gv=gv", opts)
      map("v", "<Leader>j", "<cmd>m'>+<CR>gv=gv", opts)

      -- Editor
      map("n", "<leader>ts", "<cmd>setlocal spell!<CR>", opts)
      map("n", "<leader>tl", "<cmd>setlocal nolist!<CR>", opts)
      map("n", "<leader>tn", "<cmd>setlocal nonumber!<CR><cmd>setlocal rnu!<CR>", opts)
      map("n", "<leader>tw", "<cmd>execute('setlocal wrap! breakindent! colorcolumn='. (&colorcolumn == \'\' ? &textwidth : \'\'))<CR>", opts)

      -- Plugins --

      -- NvimTree
      map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

      -- Telescope
      map("n", "<leader>pp", "<cmd>Telescope find_files<CR>", opts)
      map("n", "<leader>pf", "<cmd>Telescope live_grep<CR>", opts)
      map("n", "<leader>pj", "<cmd>Telescope projects<CR>", opts)
      map("n", "<leader>pb", "<cmd>Telescope buffers<CR>", opts)

      -- Comment
      map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
      map("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

      -- DAP
      map("n", "<leader>dd", "<cmd>lua require'dapui'.toggle()<CR>", opts)
      map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
      map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
      map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
      map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
      map("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)
      map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)
      map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
      map("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", opts)
      map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle({height = 14})<CR>", opts)

      -- Gitsigns
      map("n", "<leader>hp", "<cmd>lua require'gitsigns'.preview_hunk_inline()<CR>", opts)
      map("n", "<leader>hP", "<cmd>lua require'gitsigns'.preview_hunk()<CR>", opts)
      map("n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line()<CR>", opts)
      map("n", "<leader>hB", "<cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>", opts)

      -- Lsp
      map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", opts)
    '';
}
