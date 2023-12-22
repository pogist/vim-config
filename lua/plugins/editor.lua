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
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      -- Autocommand that detects if NvimTree is the only visible window
      -- when entering it's a buffer. This is useful to detect if the user
      -- is leaving the editor with the tree still open and auto close it.
      local group = vim.api.nvim_create_augroup("nvimtree_auto_close", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        callback = function()
          local layout = vim.api.nvim_call_function("winlayout", {})
          if layout[1] == "leaf" then
            local buf = vim.api.nvim_win_get_buf(layout[2])
            local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
            if buf_ft:match("NvimTree") ~= nil and layout[3] == nil then
              vim.cmd("confirm quit")
            end
          end
        end,
      })
    end,
  },
}
