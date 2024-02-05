local M = {}

function M.has_word_at_cursor()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
  return not current_line:sub(col, col):match("%s")
end

function M.exists(filename)
  local stat = vim.uv.fs_stat(filename)
  return stat and stat.type or false
end

function M.is_dir(filename)
  return M.exists(filename) == "directory"
end

function M.git_clone(repo, path, callback)
  vim.system({
    "git",
    "clone",
    "--branch=main",
    "--filter=blob:none",
    repo,
    path,
  }, { stdout = false, stderr = false, text = false }, vim.schedule_wrap(callback))
end

function M.debounce(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

return M
