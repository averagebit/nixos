local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
    commit = "89eaa18a472be680539dee5977e2255f4dbd0738",
}

function M.config()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }
    dashboard.section.buttons.val = {
        dashboard.button(
            "e",
            " " .. " New",
            "<cmd>ene <BAR> startinsert<CR>"
        ),
        dashboard.button(
            "p",
            " " .. " Files",
            "<cmd>Telescope find_files<CR>"
        ),
        dashboard.button(
            "f",
            "󰱽 " .. " Search",
            "<cmd>Telescope live_grep<CR>"
        ),
        dashboard.button(
            "r",
            "󱀩 " .. " Recent",
            "<cmd>Telescope oldfiles<CR>"
        ),
        dashboard.button(
            "j",
            " " .. " Projects",
            "<cmd>Telescope projects<CR>"
        ),
        dashboard.button(
            "l",
            " " .. " Lab",
            "<cmd>cd ~/workspace/lab | :e flake.nix<CR>"
        ),
        dashboard.button(
            "n",
            "󱇗 " .. " Notes",
            "<cmd>cd ~/workspace/notes | :e flake.nix<CR>"
        ),
        dashboard.button(
            "h",
            "󰒃 " .. " Recon",
            "<cmd>cd ~/workspace/recon | :e README.md<CR>"
        ),
        dashboard.button(
            "o",
            " " .. " NixOS",
            "<cmd>cd ~/workspace/nixos | :e flake.nix<CR>"
        ),
        dashboard.button(
            "c",
            " " .. " Configuration",
            "<cmd>cd ~/workspace/nixos/home/averagebit/common/optional/tools/neovim/config | :e init.lua<CR>"
        ),
        dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
    }
    local function footer()
        return "github.com/averagebit"
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Function"
    dashboard.section.header.opts.hl = "Function"
    dashboard.section.buttons.opts.hl = "Function"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
end

return M
