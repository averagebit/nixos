{
  programs.neovim.extraLuaConfig =
    /*
    lua
    */
    ''
      vim.filetype.add({
        extension = {
          hujson = "hjson"
        }
      })
    '';
}
