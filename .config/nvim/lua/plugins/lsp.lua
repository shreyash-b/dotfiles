local on_attach = function(_, bufnr)
  require("config.lazy")
  -- require("lsp-format").on_attach(client)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = bufnr })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Goto Definition", buffer = bufnr })
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "Goto Type Definition", buffer = bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Goto Implementation", buffer = bufnr })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Show References", buffer = bufnr })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Toggle Documentation", buffer = bufnr })
  vim.keymap.set('n', '<leader>lw', vim.lsp.buf.document_symbol, { desc = "Document Symbols", buffer = bufnr })
  vim.keymap.set('n', '<leader>lW', vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols", buffer = bufnr })
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format Code", buffer = bufnr })
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.incoming_calls, { desc = "Incoming Calls", buffer = bufnr })
  vim.keymap.set('n', '<leader>lh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "Toogle Inlay Hints", buffer = bufnr })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "lukas-reineke/lsp-format.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "onsails/lspkind.nvim"
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
      },

      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach
          }
        end,
      }
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      }),

      mapping = {

        -- ... Your other mappings ...
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })
  end
}
