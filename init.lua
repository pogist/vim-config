-- load options before plugins
require("options")

-- load plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=main",
    lazypath,
  }, { stdout = false, stderr = false, text = false }, function()
    vim.schedule(function()
      vim.opt.rtp:prepend(lazypath)
      require("lazy").setup("plugins")
    end)
  end)
else
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup("plugins")
end

-- lazy load custom mappings
local group = vim.api.nvim_create_augroup("user_lazy_mappings", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "VeryLazy",
  callback = function()
    require("autocmds")
    require("keymaps")
  end,
})
