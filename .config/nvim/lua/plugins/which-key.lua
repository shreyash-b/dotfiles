return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix"
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>c", group = "Code" },
      { "<leader>b", group = "Buffer" }
    })
  end
}
