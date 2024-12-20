local on_attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

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

  bufmap('<leader>lq', vim.diagnostic.setqflist, "Toogle Diagnostic Quickfix")
  bufmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
  bufmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')

  if client and client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspCommands", {});
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

    bufmap("<leader>W", ":noautocmd w", "Write without formatting")

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
    -- "hrsh7th/cmp-nvim-lsp",
    "saghen/blink.cmp"
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

    local capabilities = require("blink-cmp").get_lsp_capabilities()

    ---@diagnostic disable: missing-fields
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,
      }
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = on_attach
    })
  end
}
