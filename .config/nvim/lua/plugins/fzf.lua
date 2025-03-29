return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("fzf-lua").setup {}

    vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
    vim.keymap.set("n", "<leader>bf", "<cmd>FzfLua buffers<cr>", { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>lg", "<cmd>FzfLua live_grep<cr>", { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>cs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Search Document Symbols" })
    vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<cr>", { desc = "Find Help" })
  end

}
