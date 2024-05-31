return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
  },

  config = function()
    local on_attach = function(_, bufnr)
    end

    require("neodev").setup()
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        }
      }
    })
    require'lspconfig'.jdtls.setup{
      on_attach = on_attach,
      cmd = { 'jdtls' },
    }
    local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
    require'lspconfig'.html.setup {
      capabilities = capabilities,
    }
    require'lspconfig'.cssls.setup {
      capabilities = capabilities,
    }
    require'lspconfig'.jsonls.setup {
      capabilities = capabilities,
    }
    require'lspconfig'.emmet_language_server.setup{}
    require("lspconfig").tailwindcss.setup({
      on_attach = on_attach,
    })
  end
}
