local function augroup(name)
  return vim.api.nvim_create_augroup("User" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CloseFtWithQ"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- autoclose nvim-tree if it's the last window on screen
vim.api.nvim_create_autocmd("QuitPre", {
  group = augroup("NvimTreeAutoClose"),
  callback = function()
    local api = package.loaded["nvim-tree.api"]
    if not api then
      api = require("nvim-tree.api")
    end
    local winid = api.tree.winid()
    if winid ~= nil then
      local layout = vim.fn.winlayout()[2]
      if not layout[3] then
        vim.api.nvim_win_close(winid, false)
      end
    end
  end,
})
