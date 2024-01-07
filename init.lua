-- load options before plugins
require("options")

local config = require("config")
config.init({
  lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
})

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
