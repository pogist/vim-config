return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      {
        formatter = { "trim_whitespace" },
        filetypes = { "_" },
      },
      {
        formatter = { "stylua" },
        filetypes = { "lua" },
      },
      {
        formatter = { { "prettierd", "prettier" } },
        filetypes = {
          "html",
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "json",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "yaml",
        },
      },
    },
    config = function(_, opts)
      local formatters_by_ft = {}
      for _, config in ipairs(opts) do
        for _, filetype in ipairs(config.filetypes) do
          formatters_by_ft[filetype] = config.formatter
        end
      end
      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        format_on_save = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
    end,
  },
}
