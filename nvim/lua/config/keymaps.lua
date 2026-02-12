-- lua/config/keymaps.lua
local wk = require("which-key")

-- Set leader key (already set in init.lua but good for reference)
vim.g.mapleader = " "

wk.add({
  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  
  { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
  
  { "<leader>l", group = "lsp" },
  { "<leader>lf", function() require("conform").format({ lsp_fallback = true }) end, desc = "Format File" },
  
  { "<leader>w", proxy = "<c-w>", group = "windows" },
  
  { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Ask (Chat)" },
  { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Edit" },
  { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Refresh" },
  { "<leader>ai", group = "codeium" },
  { "<leader>aia", "<cmd>Codeium Auth<cr>", desc = "Authenticate" },
  { "<leader>aic", "<cmd>Codeium Chat<cr>", desc = "Chat" },
  { "<leader>aie", "<cmd>Codeium Enable<cr>", desc = "Enable" },
  { "<leader>aid", "<cmd>Codeium Disable<cr>", desc = "Disable" },
})
