return {
  "rebelot/heirline.nvim",
  dependencies = { "NStefan002/screenkey.nvim" },
  opts = function(_, opts)
    vim.g.screenkey_statusline_component = true
    local status = require "astroui.status"
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      }, -- add the mode text
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.builder {
        { provider = function() return require("screenkey").get_keys() end },
        padding = { right = 1, left = 1 },
        surround = { separator = "center" },
      },
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
    }
    opts.winbar = {}
    opts.tabline = {
      status.heirline.make_buflist(status.component.tabline_file_info {
        filename = {
          fname = function(nr)
            local fullPath = vim.fn.getbufinfo(nr)[1].name
            local dirName = vim.fn.fnamemodify(fullPath, ":p:h:t")
            local fileName = vim.fn.fnamemodify(fullPath, ":t")
            return dirName .. "/" .. fileName
          end,
          modify = "",
        },
      }),
      status.component.fill(),
    }
  end,
}
