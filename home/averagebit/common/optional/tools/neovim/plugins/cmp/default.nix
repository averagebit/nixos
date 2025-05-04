{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    luasnip
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-path
    cmp-rg
    cmp_luasnip
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
              ["<C-k>"] = cmp.mapping.select_prev_item(),
              ["<C-j>"] = cmp.mapping.select_next_item(),
              ["<Down>"] = cmp.mapping.select_next_item(),
              ["<Up>"] = cmp.mapping.select_prev_item(),
              ["<Left>"] = cmp.mapping.scroll_docs(-1),
              ["<Right>"] = cmp.mapping.scroll_docs(1),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<Tab>"] = cmp.mapping.confirm { select = true },
            }),
            sources = {
              { name='copilot' },
              { name='otter' },
              { name='nvim_lsp' },
              { name='luasnip' },
              { name='buffer' },
              { name='path' },
              { name='calc' },
              { name='git' },
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
