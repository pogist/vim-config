local M = {}

function M.has_word_at_cursor()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
  return not current_line:sub(col, col):match("%s")
end

return M
