return {
  'echasnovski/mini.nvim',
  config = function()
    require("mini.icons").setup {}
    require("mini.surround").setup {}
    require("mini.pairs").setup {}

    require("mini.files").setup {
      mappings = {
        go_in_plus = "l",
        go_out_plus = "h",
      },
    }
    vim.keymap.set("n", "<leader>e", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end,
      { desc = "Files" })
    vim.keymap.set("n", "-", function() require("mini.files").open(nil, false) end, { desc = "Files" })
  end
}
