return {
  "michaelb/sniprun",
  opts = {},
  -- doesn't work, go to install file and run this yourself
  -- build = "bash ./install.sh 1",
  config = function()
    require("sniprun").setup {
      interpreter_options = {
        TypeScript_original = {
          interpreter = "node",
        },
      },
    }
  end,
  keys = {
    { "<leader>r", ":'<,'>SnipRun<CR>", mode = { "v" }, desc = "SnipRun" },
  },
}
