return {
  {
    "williamboman/mason.nvim",
    config = true,
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "bashls", "emmet_language_server", "jsonls", "cssls", "html", "quick_lint_js", "jdtls" },
    },
  },
}
