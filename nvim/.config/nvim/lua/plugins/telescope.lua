return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope-ui-select.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
  },

  init = function()
    require("telescope").load_extension("ui-select")

    vim.keymap.set("n", "<leader>f", function() end, { desc = "Telescope" })
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<cr>", { desc = "File" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffer" })
    vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
  end
}
