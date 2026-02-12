-- lua/plugins/lsp.lua
return {
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "eslint", "astro", "html", "cssls" }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "ts_ls", "eslint", "astro", "html", "cssls" }
      for _, lsp in ipairs(servers) do
        -- Check if vim.lsp.config exists (Neovim 0.11+)
        if vim.lsp.config then
          vim.lsp.config(lsp, {
            capabilities = capabilities,
          })
        else
          lspconfig[lsp].setup({
            capabilities = capabilities,
          })
        end
      end
    end,
  },
}
