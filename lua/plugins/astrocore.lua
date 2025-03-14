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
        ["<C-p>"] = { '"0p', desc = "Paste from yank register" },
      },
      t = {
        ["<C-t>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      i = {
        ["<C-t>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      },
      v = {
        ["<C-t>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        ["<C-p>"] = { '"0p', desc = "Paste from yank register" },
      },
    },
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
    },
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
          end,
        },
      },
    },
  },
  require("toggleterm").setup {
    shell = "powershell.exe",
  },
}
