return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>f",  group = "Find" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find buffer" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",    desc = "Find keymaps" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
    })
  end
}
