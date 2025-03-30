local on_attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  local bufmap = function(lhs, rhs, desc)
    local opts = { desc = desc, buffer = bufnr }
    vim.keymap.set('n', lhs, rhs, opts)
  end

  -- foldmethod
  vim.opt.foldmethod = "expr"
  vim.opt.foldlevel = 99

  vim.lsp.inlay_hint.enable()
  bufmap("gt", vim.lsp.buf.type_definition, "Goto type definition")
  bufmap("gd", vim.lsp.buf.definition, "Goto definition")
  bufmap("gD", vim.lsp.buf.type_definition, "Goto declaration")

  if client and client:supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspCommands", {});
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

    bufmap("<leader>W", ":noautocmd w<cr>", "Write without formatting")
    bufmap("<leader>cf", vim.lsp.buf.format, "Format File")

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
  {
    "williamboman/mason.nvim",
    dependencies = {
      "j-hui/fidget.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
      "mrcjkb/rustaceanvim"
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

          -- rustaceanvim
          ["rust_analyzer"] = function() end
        }
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = on_attach
      })
    end

  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
