return {
  'VonHeikemen/fine-cmdline.nvim',
  enabled = false,
  requires = {
    { 'MunifTanjim/nui.nvim' }
  },
  config = function()
    require("fine-cmdline").setup({
      popup = {
        relative = "editor"
      }
    })

    vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
  end
}
