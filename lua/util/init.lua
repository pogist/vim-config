local M = {}

function M.has_word_at_cursor()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
  return not current_line:sub(col, col):match("%s")
end

function M.on(event, callback)
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("On" .. event, { clear = true }),
    pattern = event,
    callback = callback,
  })
end

function M.require_all(mods)
  for _, mod in ipairs(mods) do
    if type(mod) == "string" then
      require(mod)
    end
  end
end

return M
