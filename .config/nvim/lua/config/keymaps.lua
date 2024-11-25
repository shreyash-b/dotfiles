local wk = require("which-key")

-- Session Management
wk.add({
  { "<leader>q",  group = "[Q]uit" },
  { "<leader>qq", "<cmd>qa<cr>",   desc = "Quit session" },
})
