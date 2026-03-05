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
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
  
  { "<leader>x", group = "trouble" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
  { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
  
  { "<leader>s", group = "sessions" },
  { "<leader>ss", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
  { "<leader>sa", "<cmd>SessionSave<cr>", desc = "Save Session" },
  
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
