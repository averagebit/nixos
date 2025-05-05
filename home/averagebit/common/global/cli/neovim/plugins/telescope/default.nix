{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local wk = require "which-key"
          wk.add {
            { "<leader>b", "<cmd>Telescope buffers previewer=false<cr>", desc = "Open Buffer Picker" },
            -- { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
            { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open File Picker" },
            { "<leader>p", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Open Projects Picker" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Open Global Search" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Open Command Palette" },
            { "<leader>'", "<cmd>Telescope resume<cr>", desc = "Open Last Fuzzy Picker" },
            -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
          }

          local actions = require("telescope.actions")

          require("telescope").setup({
              defaults = {
                  prompt_prefix = " ",
                  selection_caret = " ",
                  entry_prefix = "   ",
                  initial_mode = "insert",
                  selection_strategy = "reset",
                  path_display = { "smart" },
                  color_devicons = true,
                  set_env = { ["COLORTERM"] = "truecolor" },
                  sorting_strategy = nil,
                  layout_strategy = nil,
                  layout_config = {},
                  file_ignore_patterns = { ".git/", "node_modules" },
                  vimgrep_arguments = {
                      "rg",
                      "--color=never",
                      "--no-heading",
                      "--with-filename",
                      "--line-number",
                      "--column",
                      "--smart-case",
                      "--hidden",
                      "--glob=!.git/",
                  },

                  mappings = {
                      i = {
                          ["<C-n>"] = actions.cycle_history_next,
                          ["<C-p>"] = actions.cycle_history_prev,

                          ["<C-j>"] = actions.move_selection_next,
                          ["<C-k>"] = actions.move_selection_previous,
                      },
                      n = {
                          ["<esc>"] = actions.close,
                          ["j"] = actions.move_selection_next,
                          ["k"] = actions.move_selection_previous,
                          ["q"] = actions.close,
                      },
                  },
              },
              pickers = {
                  live_grep = {
                      theme = "dropdown",
                  },

                  grep_string = {
                      theme = "dropdown",
                  },

                  find_files = {
                      previewer = false,
                      layout_strategy = "center",
                      layout_config = { height = 0.50 },
                      prompt_position = "top",
                      theme = "dropdown",
                  },

                  buffers = {
                      theme = "dropdown",
                      previewer = false,
                      initial_mode = "normal",
                      mappings = {
                          i = {
                              ["<C-d>"] = actions.delete_buffer,
                          },
                          n = {
                              ["dd"] = actions.delete_buffer,
                          },
                      },
                  },

                  planets = {
                      show_pluto = true,
                      show_moon = true,
                  },

                  colorscheme = {
                      enable_preview = true,
                  },

                  lsp_references = {
                      theme = "dropdown",
                      initial_mode = "normal",
                  },

                  lsp_definitions = {
                      theme = "dropdown",
                      initial_mode = "normal",
                  },

                  lsp_declarations = {
                      theme = "dropdown",
                      initial_mode = "normal",
                  },

                  lsp_implementations = {
                      theme = "dropdown",
                      initial_mode = "normal",
                  },
              },
          })
        '';
    }
  ];
}
