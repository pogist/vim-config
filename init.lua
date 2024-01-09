require("config").init({
  path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
  load_modules = {
    "options",
    lazy = {},
    very_lazy = {
      "autocmds",
      "keymaps",
    },
  },
})
