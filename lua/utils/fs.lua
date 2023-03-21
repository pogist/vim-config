local is_windows = vim.loop.os_uname().version:match 'Windows'
local path_separator = is_windows and '\\' or '/'

local M = {}

M.join = function(...)
  return table.concat(vim.tbl_flatten { ... }, path_separator):gsub(path_separator .. '+', path_separator)
end

M.exists = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end

M.read_file_sync = function(path)
  if not M.exists(path) then
    return { path = nil, data = nil }
  end
  local fd = assert(vim.loop.fs_open(path, 'r', 438))
  local stat = assert(vim.loop.fs_fstat(fd))
  local data = assert(vim.loop.fs_read(fd, stat.size, 0))
  assert(vim.loop.fs_close(fd))
  return { path = path, data = tostring(data) }
end

M.read_json_sync = function(path)
  local file = M.read_file_sync(path)
  if not file.path and not file.data then
    return file
  end
  return { path = file.path, data = vim.json.decode(file.data) }
end

return M
