return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
      {
        linter = { "eslint_d" },
        filetypes = {
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
        },
      },
    },
    config = function(_, opts)
      local util = require("util")
      local lint = require("lint")

      local linters_by_ft = {}
      for _, config in ipairs(opts) do
        for _, filetype in ipairs(config.filetypes) do
          linters_by_ft[filetype] = config.linter
        end
      end

      lint.linters_by_ft = linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = util.debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },
}
