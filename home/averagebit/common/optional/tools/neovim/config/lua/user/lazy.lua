local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    spec = LAZY_PLUGIN_SPEC,
    install = {
        colorscheme = { require("user.colorscheme").name },
    },
    ui = {
        border = "rounded",
        wrap = "true",
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    debug = false,
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                -- "matchit",
                --  "matchparen",
            },
        },
    },
})
