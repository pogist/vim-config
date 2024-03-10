-- automatically set ruby filetype for Cocoapods
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("Cocoapods", { clear = true }),
  pattern = { "*.podspec", "Podfile" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})
