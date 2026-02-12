-- Modular Neovim Configuration (Catppuccin Mocha + Web Dev)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load basic settings
require("config.options")

-- Load plugins via lazy.nvim
require("lazy").setup("plugins")

-- Load keymaps (after plugins so which-key is available)
require("config.keymaps")
