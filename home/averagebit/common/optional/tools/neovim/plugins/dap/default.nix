{pkgs, ...}: {
  imports = [ ./ui.nix ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-dap;
      type = "lua";
      config =
        /*
        lua
        */
        ''
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
  ];
}
