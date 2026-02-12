-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then
        return
      end
      configs.setup({
        ensure_installed = { "lua", "javascript", "typescript", "tsx", "html", "css", "astro", "json" },
        highlight = { enable = true },
      })
    end,
  },
}
