return {
  "echasnovski/mini.files",
  config = function()
    local mini = require("mini.files")
    mini.setup()

    vim.keymap.set("n", "-", mini.open)
  end
}
