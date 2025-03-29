local init = function()
  vim.o.background = "dark"
  vim.cmd.colorscheme "catppuccin"
end

return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = init
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    init = init
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    init = init
  }
}
