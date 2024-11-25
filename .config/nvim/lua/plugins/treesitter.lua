return {
  "nvim-treesitter/nvim-treesitter",

  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "rust", "lua" },
      highlight = {
        enabled = true
      }
    })
  end
}
