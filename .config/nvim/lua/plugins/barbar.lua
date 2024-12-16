return {
  'romgrk/barbar.nvim',
  enabled = true,
  dependencies = {
    'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },

  opts = {
    no_name_title = "Empty Buffer",
  },

  init = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>b",  group = "Buffer" },
      { "<leader>bd", "<cmd>BufferClose<cr>",             desc = "Close" },
      { "<leader>ba", "<cmd>BufferCloseAllButPinned<cr>", desc = "Close All" },
      { "<leader>bP", "<cmd>BufferPin<cr>",               desc = "Close Pin" },
      { "<leader>bn", "<cmd>BufferNext<cr>",              desc = "Next Buffer" },
      { "L",          "<cmd>BufferNext<cr>",              desc = "Next Buffer" },
      { "<leader>bp", "<cmd>BufferPrevious<cr>",          desc = "Previous Buffer" },
      { "H",          "<cmd>BufferPrevious<cr>",          desc = "Previous Buffer" },

      -- { "<leader>qb", "<cmd>BufferClose<cr>",             desc = "Close Buffer" },
    })
  end,

  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
