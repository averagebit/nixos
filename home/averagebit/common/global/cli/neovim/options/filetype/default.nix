{
  programs.neovim.initLua =
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
