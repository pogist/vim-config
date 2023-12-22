return {
  {
    "nvim-tree/nvim-tree.lua",
    version = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<C-n>",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
      },
    },
    opts = {
      diagnostics = { enable = true },
      git = { ignore = false },
      view = {
        adaptive_size = true,
        relativenumber = true,
        centralize_selection = true,
      },
      renderer = {
        add_trailing = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- set plugin's default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- override some of plugin's default mappings
        local opts = { buffer = bufnr, noremap = true, nowait = true, silent = true }
        vim.keymap.set("n", "s", api.node.open.vertical, opts)
        vim.keymap.set("n", "Z", api.node.run.system, opts)
      end,
    },
  },
}
