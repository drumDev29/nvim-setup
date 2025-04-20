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
        claude = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-3-7-sonnet-latest",
              },
            },
            env = {
              api_key = vim.env.ANTHROPIC_API_KEY,
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "o1-preview-2024-09-12",
              },
            },
            env = {
              api_key = vim.env.OPENAI_API_KEY,
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
            schema = {
              model = {
                default = "deepseek-r1:14b",
              },
            },
            env = {
              url = "http://localhost:11434",
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              sync = true,
            },
          })
        end,
        openai_mini = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "o1-mini-2024-09-12",
              },
            },
            env = {
              api_key = vim.env.OPENAI_API_KEY,
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "claude",
        },
      },
    }
  end,
  keys = {
    { "<leader>a", "", desc = "AI Tools" },
    { "<leader>a", "", mode = "v", desc = "AI Tools" },
    { "<leader>ac", function() vim.cmd "CodeCompanionChat" end, desc = "Start Chat" },
  },
}
