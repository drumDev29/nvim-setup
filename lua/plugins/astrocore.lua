-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
--https://github.com/AstroNvim/astrocore#%EF%B8%8F-configuration
--

return {
  "AstroNvim/astrocore",

  opts = {

    mappings = {
      n = {
        ["<C-t>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
        ["<Leader><Leader>"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
          end,
          desc = "Select buffer from tabline",
        },
      },
      t = {
        ["<C-t>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      i = {
        ["<C-t>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      v = {
        ["<C-t>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
    },
  },
  specs = {
    { "telescope.nvim", optional = true, enabled = false },
  }
}
