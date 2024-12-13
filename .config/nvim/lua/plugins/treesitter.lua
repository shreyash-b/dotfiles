return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "rust", "lua" },
      sync_install = false,
      highlight = { enabled = true },
    })
  end
}
