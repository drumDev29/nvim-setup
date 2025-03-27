-- This function is taken from LazyVim: https://github.com/LazyVim/LazyVim/blob/cb223553ff73eb2f37ffb5dc0bb75b76a4677faf/lua/lazyvim/plugins/extras/editor/mini-files.lua
local function map_split(buf_id, lhs, direction, close_on_file)
  local files = require "mini.files"
  local should_close = close_on_file == nil and true or close_on_file

  local rhs = function()
    local cur_target = files.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)

    files.set_target_window(new_target)
    files.go_in { close_on_file = should_close }
  end

  local desc = "Open in " .. direction .. " split"
  if should_close then desc = desc .. " and close" end
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

return {
  "echasnovski/mini.files",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>e"] = {
              function()
                if not require("mini.files").close() then require("mini.files").open() end
              end,
              desc = "Explorer",
            },
            ["<Leader>E"] = {
              function()
                if not require("mini.files").close() then require("mini.files").open(vim.api.nvim_buf_get_name(0)) end
              end,
              desc = "Explorer (current buffer)",
            },
          },
        },
      },
    },
  },
  specs = {
    { "neo-tree.nvim", optional = true, enabled = false },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          splits = {
            {
              event = "User",
              pattern = "MiniFilesBufferCreate",
              desc = "Create mappings to modify target window via split",
              callback = function(args)
                local buf_id = args.data.buf_id

                map_split(buf_id, "<C-w>s", "belowright horizontal")
                map_split(buf_id, "<C-w>v", "belowright vertical")
                map_split(buf_id, "<C-w>t", "tab")

                map_split(buf_id, "<C-w>S", "belowright horizontal", false)
                map_split(buf_id, "<C-w>V", "belowright vertical", false)
                map_split(buf_id, "<C-w>T", "tab", false)
              end,
            },
          },
        },
      },
    },
  },
  opts = {
    mappings = {
      synchronize = "<C-s>",
    },
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 25,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 50,
    },
  },
}
