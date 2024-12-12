local on_attach = function(_, buffer)
  local map = function(lhs, rhs, desc)
    local opts = { desc = desc, buffer = buffer }
    vim.keymap.set('n', lhs, rhs, opts)
  end

  map('gD', vim.lsp.buf.declaration, "Goto Declaration")
  map('gd', vim.lsp.buf.definition, "Goto Definition")
  map('gt', vim.lsp.buf.type_definition, "Goto Type Definition")
  map('gi', vim.lsp.buf.implementation, "Goto Implementation")
  map('gr', vim.lsp.buf.references, "Show References")
  map('gs', vim.lsp.buf.signature_help, "Signature help")
  map('K', vim.lsp.buf.hover, "Toggle Documentation")
  map('<leader>lw', vim.lsp.buf.document_symbol, "Document Symbols")
  map('<leader>lW', vim.lsp.buf.workspace_symbol, "Workspace Symbols")
  map('<leader>la', vim.lsp.buf.code_action, "Code Action")
  map('<leader>lr', vim.lsp.buf.rename, "Rename Symbol")
  map('<leader>lf', vim.lsp.buf.format, "Format Code")
  map('<leader>li', vim.lsp.buf.incoming_calls, "Incoming Calls")
  map('<leader>lh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "Toogle Inlay Hints")
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    require("mason").setup()
    require("fidget").setup {
      progress = {
        ignore_already_done = true
      }
    }

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach
          }
        end
      }
    })
  end
}
