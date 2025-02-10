-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  config = function()
    require("codecompanion").setup {
      opts = {
        system_prompt = function(opts)
          return "You are a helpful coding assistant that is always "
            .. "extremely concise and to the point. Whenever I ask "
            .. "for code you will only return the code. Whenever I "
            .. "ask for an update to the code you will only return "
            .. "the part of the code that has changed. If a part of "
            .. "the code needs explaining, add a short comment inside "
            .. "of the code."
        end,
      },
      adapters = {
        azure_openai = function()
          local s = require("codecompanion.adapters").extend("openai", {
            url = "http://localhost:2000/?resource=af-openai-nc-prod&deployment=af-openainc-o1mini-prod&api_version=2024-08-01-preview",
            schema = {
              model = {
                default = "af-openainc-o1mini-prod",
              },
            },
          })
          return s
        end,
      },
      strategies = {
        chat = {
          adapter = "azure_openai",
        },
      },
    }
  end,
  keys = {
    { "<leader>a", "", desc = "Code Companion" },
    { "<leader>a", "", mode = "v", desc = "Code Companion" },
    { "<leader>ac", function() vim.cmd "CodeCompanionChat" end, desc = "Start Chat" },
  },
}
