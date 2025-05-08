{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-dap;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local wk = require "which-key"
          wk.add {
            { "<leader>Gb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Debug: Toggle breakpoint" },
            { "<leader>Gc", "<cmd>lua require'dap'.continue()<cr>", desc = "Debug: Continue" },
            { "<leader>Gi", "<cmd>lua require'dap'.step_into()<cr>", desc = "Debug: Step into" },
            { "<leader>Go", "<cmd>lua require'dap'.step_over()<cr>", desc = "Debug: Step over" },
            { "<leader>GO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Debug: Step out" },
            { "<leader>Gl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Debug: Run last" },
            { "<leader>Gt", "<cmd>lua require'dap'.terminate()<cr>", desc = "Debug: terminate" },
            { "<leader>Gr", "<cmd>lua require'dap'.repl.toggle({height = 14})<cr>", desc = "Debug: Toggle repl" },
          }

          local dap = require("dap")

          dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
          end

          dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
          end

          dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
          end

          dap.configurations.c = {
              {
                  name = "Launch file",
                  type = "codelldb",
                  request = "launch",
                  program = function()
                      local path
                      vim.ui.input({
                          prompt = "Path to executable: ",
                          default = vim.loop.cwd() .. "/build/",
                      }, function(input)
                          path = input
                      end)
                      vim.cmd([[redraw]])
                      return path
                  end,
                  stopOnEntry = false,
              },
          }
        '';
    }
    {
      plugin = nvim-dap-ui;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          -- DAP
          local wk = require "which-key"
          wk.add {
            { "<leader>Gd", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Debug: Toggle UI" },
          }

          require("dapui").setup({
              expand_lines = true,
              icons = { expanded = "", collapsed = "", circular = "" },
              mappings = {
                  expand = { "<CR>", "<2-LeftMouse>" },
                  open = "o",
                  remove = "d",
                  edit = "e",
                  repl = "r",
                  toggle = "t",
              },
              layouts = {
                  {
                      elements = {
                          { id = "scopes", size = 0.33 },
                          { id = "breakpoints", size = 0.17 },
                          { id = "stacks", size = 0.25 },
                          { id = "watches", size = 0.25 },
                      },
                      size = 0.33,
                      position = "right",
                  },
                  {
                      elements = {
                          { id = "repl", size = 0.45 },
                          { id = "console", size = 0.55 },
                      },
                      size = 0.27,
                      position = "bottom",
                  },
              },
              floating = {
                  max_height = 0.9,
                  max_width = 0.5, -- Floats will be treated as percentage of your screen.
                  border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
                  mappings = {
                      close = { "q", "<Esc>" },
                  },
              },
          })

          vim.fn.sign_define("DapBreakpoint", {
              text = "",
              texthl = "DiagnosticSignError",
              linehl = "",
              numhl = "",
          })
        '';
    }
  ];
}
