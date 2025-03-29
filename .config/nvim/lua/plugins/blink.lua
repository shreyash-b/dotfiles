return {
  {
    "saghen/blink.cmp",
    dependencies = { "folke/lazydev.nvim", "xzbdmw/colorful-menu.nvim" },
    version = "*",
    opts = {
      completion = {
        trigger = {
          show_on_trigger_character = true
        },
        documentation = {
          auto_show = true
        },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },

      },
      keymap = {
        preset = "super-tab"
      },
      signature = {
        enabled = true
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  }
}
