return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  build = "cargo build --release",

  opts = {
    keymap = {
      preset = "super-tab"
    },
    signature = { enabled = true }
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  -- opts_extend = { "sources.default" }
}
