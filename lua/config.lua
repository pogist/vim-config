local util = require("util")

local M = {
  lazy = {
    repo = "https://github.com/folke/lazy.nvim.git",
    path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
  },
}

function M.setup_lazy()
  vim.opt.rtp:prepend(M.lazy.path)
  require("lazy").setup("plugins", {
    defaults = {
      version = false,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
end

function M.load_plugins()
  if not util.is_dir(M.lazy.path) then
    util.git_clone(M.lazy.repo, M.lazy.path, function()
      M.setup_lazy()
    end)
  else
    M.setup_lazy()
  end
end

function M.setup()
  require("options")
  require("autocmds")
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
      require("autocmds.lazy")
      require("keymaps")
    end,
  })
  M.load_plugins()
end

return M
