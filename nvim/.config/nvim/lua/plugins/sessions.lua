return {
  {
    "folke/persistence.nvim",
    enabled = false,
    event = "VimEnter",
    opts = {},
    init = function()
      -- Restore the pervious sessiog
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
        callback = function()
          if vim.fn.getcwd() ~= vim.env.HOME then
            require("persistence").load()
          end
        end,
        nested = true,
      })

      local wk = require("which-key")
      wk.add(
        { "<leader>sr", function() require("persistence").load() end, desc = "[R]estore session" }
      )
    end,
  },
}
