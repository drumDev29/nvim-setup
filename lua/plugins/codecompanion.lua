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
            .. "for assistance you will ever only ever strategize first, "
            ..  "only returning code when I explicitly ask for it. If you return code without me asking, horrible things will happen. Whenever I "
            .. "ask for an update to the code you will only return "
            .. "the part of the code that has changed. Don't overcomment code."
            .. "Avoid returning line numbers in code."
        end,
      },
      adapters = {
        azure_openai = function()
          local resource = "af-openai-nc-prod"
          local model = "af-openainc-o1mini-prod"
          local api_version = "2024-08-01-preview"

          local s = require("codecompanion.adapters").extend("openai", {
            url = "http://localhost:2000/",
            -- /?resource="
            --   .. resource
            --   .. "&deployment="
            --   .. model
            --   .. "&api_version="
            --   .. api_version,
            schema = {
              model = {
                default = model,
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
