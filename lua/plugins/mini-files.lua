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
              desc = "Explorer (current file)",
            },
          },
        },
      },
    },
  },
  specs = {
    { "neo-tree.nvim", optional = true, enabled = false },
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
