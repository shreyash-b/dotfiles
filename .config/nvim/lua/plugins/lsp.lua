local on_attach = function(client, bufnr)
  local bufmap = function(lhs, rhs, desc)
    local opts = { desc = desc, buffer = bufnr }
    vim.keymap.set('n', lhs, rhs, opts)
  end

  bufmap('gD', vim.lsp.buf.declaration, "Goto Declaration")
  bufmap('gd', vim.lsp.buf.definition, "Goto Definition")
  bufmap('gt', vim.lsp.buf.type_definition, "Goto Type Definition")
  bufmap('gi', vim.lsp.buf.implementation, "Goto Implementation")
  bufmap('gr', vim.lsp.buf.references, "Show References")
  bufmap('gs', vim.lsp.buf.signature_help, "Signature help")
  bufmap('K', vim.lsp.buf.hover, "Toggle Documentation")
  bufmap('<leader>lw', vim.lsp.buf.document_symbol, "Document Symbols")
  bufmap('<leader>lW', vim.lsp.buf.workspace_symbol, "Workspace Symbols")
  bufmap('<leader>la', vim.lsp.buf.code_action, "Code Action")
  bufmap('<leader>lr', vim.lsp.buf.rename, "Rename Symbol")
  bufmap('<leader>lf', vim.lsp.buf.format, "Format Code")
  bufmap('<leader>li', vim.lsp.buf.incoming_calls, "Incoming Calls")
  bufmap('<leader>lh', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    "Toogle Inlay Hints")

  if client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspCommands", {});
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

    bufmap("<leader>qW", ":noautocmd w", "Write without formatting")

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end
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
        ignore_done_already = true,
        display = {
          done_ttl = 1
        }
      },
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
