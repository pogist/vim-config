-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CloseFtWithQ", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "query",
    "sagadiagnostic",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- autoclose nvim-tree if it's the last window on screen
vim.api.nvim_create_autocmd("QuitPre", {
  group = vim.api.nvim_create_augroup("NvimTreeAutoClose", { clear = true }),
  callback = function()
    local api = require("nvim-tree.api")
    local winid = api.tree.winid()
    if winid ~= nil then
      local layout = vim.fn.winlayout()[2]
      if not layout[3] then
        vim.api.nvim_win_close(winid, false)
      end
    end
  end,
})
