return {
  {
    "nvim-tree/nvim-tree.lua",
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
        -- set default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- override some default mappings
        local opts = { buffer = bufnr, noremap = true, nowait = true, silent = true }
        vim.keymap.set("n", "s", api.node.open.vertical, opts)
        vim.keymap.set("n", "Z", api.node.run.system, opts)
      end,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })
        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })
        -- Other actions
        -- map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, { desc = "Stage Hunk" })

        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, { desc = "Reset Hunk" })

        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Line" })

        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Diff This ~" })

        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map(
          "n",
          "<leader>tb",
          gs.toggle_current_line_blame,
          { desc = "Toggle Blame Line" }
        )
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })
        -- Text object
        map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      min_count_to_highlight = 2,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "NvimTree",
      },
    },
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
    config = function(_, opts)
      local illuminate = require("illuminate")
      illuminate.configure(opts)

      local function create_maps(buffer)
        vim.keymap.set("n", "]]", function()
          illuminate.goto_next_reference(false)
        end, { desc = "Next Reference", buffer = buffer })
        vim.keymap.set("n", "[[", function()
          illuminate.goto_prev_reference(false)
        end, { desc = "Prev Reference", buffer = buffer })
      end

      create_maps()

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          create_maps(vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "[q",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok and err ~= nil then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
}
