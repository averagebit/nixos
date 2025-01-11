{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    luasnip
    cmp-nvim-lsp
    cmp_luasnip
    cmp-rg
    cmp-buffer
    cmp-path
    {
      plugin = nvim-cmp;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          local cmp = require('cmp')
          cmp.setup({
            formatting = {
              format = require('lspkind').cmp_format({
                before = function (entry, vim_item)
                  return vim_item
                end,
              }),
            },
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
            }),
            sources = {
              { name='otter' },
              { name='nvim_lsp' },
              { name='luasnip' },
              { name='git' },
              { name='buffer', option = { get_bufnrs = vim.api.nvim_list_bufs }},
              { name='path' },
              { name='rg' },
            },
          })
        '';
    }
    {
      plugin = cmp-git;
      type = "lua";
      config =
        /*
        lua
        */
        ''
          require("cmp_git").setup({})
        '';
    }
  ];
}

