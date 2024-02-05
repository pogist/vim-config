return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      events = {
        "BufReadPost",
        "BufWritePost",
        "InsertLeave",
        "TextChanged",
      },
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
        condition = {
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
        },
      },
    },
    config = function(_, opts)
      local util = require("util")
      local lint = require("lint")

      local bufname = vim.api.nvim_buf_get_name(0)
      local function is_satisfied(condition)
        return vim.fs.find(condition, { path = bufname, upward = true })[1] ~= nil
      end

      local linters_by_ft = {}
      for _, config in ipairs(opts) do
        if not config.condition or is_satisfied(config.condition) then
          for _, filetype in ipairs(config.filetypes) do
            linters_by_ft[filetype] = config.linter
          end
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
