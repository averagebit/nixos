{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = copilot-lua;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("copilot").setup({
            suggestion = {
              enabled = true,
              auto_trigger = false,
              hide_during_completion = true,
              debounce = 75,
              trigger_on_accept = true,
              keymap = {
                accept = "<M-l>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
            },
            filetypes = {
              go = true,
              nix = true,
              javascript = true,
              typescript = true,
              ["*"] = false,
            },
          })
        '';
    }
  ];
}
