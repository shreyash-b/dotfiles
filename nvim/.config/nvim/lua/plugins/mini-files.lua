return {
  "echasnovski/mini.files",
  enabled = false,
  config = function()
    local mini = require("mini.files")
    mini.setup()

    vim.keymap.set("n", "-", mini.open)
  end
}
