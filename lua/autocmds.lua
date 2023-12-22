local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
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
  group = augroup("autoclose_tree"),
  callback = function()
    local winid = require("nvim-tree.api").tree.winid()
    if winid ~= nil then
      local layout = vim.fn.winlayout()[2]
      if not layout[3] then
        vim.api.nvim_win_close(winid, false)
      end
    end
  end,
})
