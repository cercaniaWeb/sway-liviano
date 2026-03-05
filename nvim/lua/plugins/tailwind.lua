-- lua/plugins/tailwind.lua
return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        enabled = true, -- Colorize color classes
        kind = "inline", -- "inline", "foreground" or "background"
        inline_symbol = "󱓻 ",
      },
      conceal = {
        enabled = false, -- Conceal tailwind classes
      },
    }
  },
}
