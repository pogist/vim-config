local util = require("util")

local M = {}

---Async check and clone lazy.nvim repository if needed
---@param path string location where lazy.nvim repo should be cloned
---@param callback function called when lazy.nvim is ready
function M.bootstrap(path, callback)
  if not vim.uv.fs_stat(path) then
    vim.system({
      "git",
      "clone",
      "--branch=main",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      path,
    }, { stdout = false, stderr = false, text = false }, function()
      vim.schedule(function()
        callback()
      end)
    end)
  else
    callback()
  end
end

---Initialize all plugins and configurations
---@param opts table general config options
function M.init(opts)
  local mods = opts.load_modules
  util.require_all(mods)
  util.on("LazyLoad", function()
    util.require_all(mods["lazy"])
  end)
  util.on("VeryLazy", function()
    util.require_all(mods["very_lazy"])
  end)
  M.bootstrap(opts.path, function()
    vim.opt.rtp:prepend(opts.path)
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
  end)
end

return M
