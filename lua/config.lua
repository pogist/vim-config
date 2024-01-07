local M = {}

---Async check and clone lazy.nvim repository if needed
---@param path string location where lazy.nvim repo should be cloned
---@param on_done function called when lazy.nvim is ready
function M.bootstrap_lazy(path, on_done)
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
        on_done()
      end)
    end)
  else
    on_done()
  end
end

---Initialize all plugins and configurations
---@param opts table general config options
function M.init(opts)
  M.bootstrap_lazy(opts.lazypath, function()
    vim.opt.rtp:prepend(opts.lazypath)
    require("lazy").setup("plugins")
  end)
end

return M
