-- lua/plugins/lsp.lua
return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
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
        ensure_installed = { "eslint", "astro", "html", "cssls", "tailwindcss" }
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "eslint", "astro", "html", "cssls", "tailwindcss" }
      for _, lsp in ipairs(servers) do
        if vim.lsp.config then
          vim.lsp.config(lsp, {
            install = {
              auto_install = true,
            },
            capabilities = capabilities,
          })
        else
          require("lspconfig")[lsp].setup({
            capabilities = capabilities,
          })
        end
      end

      -- Diagnostic UI Styling
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },
}
