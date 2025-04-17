return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    opts.dashboard = {
      preset = {
        keys = {
          { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
          { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
          { key = "w", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "Find Word  " },
          { key = "e", action = "<Leader>e", icon = get_icon("FolderOpen", 0, true), desc = "Explorer  " },
          { key = "a", action = "<Leader>ac", icon = get_icon("Environment", 0, true), desc = "AI Chat  " },
          { key = "s", action = "<Leader>S.", icon = get_icon("Refresh", 0, true), desc = "Last Session  " },
        },
        header = table.concat({
          "██╗  ██╗██╗   ██╗██╗     ███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗",
          "██║ ██╔╝╚██╗ ██╔╝██║     ██╔════╝████╗  ██║██║   ██║██║████╗ ████║",
          "█████╔╝  ╚████╔╝ ██║     █████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║",
          "██╔═██╗   ╚██╔╝  ██║     ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║  ██╗   ██║   ███████╗███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
        }, "\n"),
      },
      sections = {
        { section = "header", padding = 5 },
        { section = "keys", gap = 1, padding = 3 },
        { section = "startup" },
      },
    }
  end,
}
