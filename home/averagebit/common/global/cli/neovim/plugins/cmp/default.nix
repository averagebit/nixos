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
              ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
              ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
              ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
              ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
              ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
              ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
              ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
              ["<C-e>"] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
              },
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
