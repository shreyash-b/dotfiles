return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = "echasnovski/mini.nvim",
  opts = {
    options = {
      seperator_style = "slant"
    }
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
    vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
    vim.keymap.set("n", "K", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Previous" })
    vim.keymap.set("n", "J", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Next" })
  end,
}
