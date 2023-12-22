require("options")

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- lazy.nvim setup
require("lazy").setup("plugins")
