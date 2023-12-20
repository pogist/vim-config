-- set autoindent expandtab tabstop=2 shiftwidth=2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- lazy.nvim

-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=main",
    lazypath,
  }, { text = true }, function() end)
end
vim.opt.rtp:prepend(lazypath)

-- setup
require("lazy").setup("plugins")
