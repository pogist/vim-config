local M = {}

function M.get_default_caps()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )
end

M.default_config = nil
function M.register(name, config)
  if not M.default_config then
    M.default_config = { capabilities = M.get_default_caps() }
  end
  require("lspconfig")[name].setup(vim.tbl_deep_extend("force", M.default_config, config))
end

M.progress = {
  augroup = nil,
  client = {
    id = nil,
    current = nil,
  },
}
function M.enable_progress()
  if not M.progress.augroup then
    M.progress.augroup =
      vim.api.nvim_create_augroup("pogist_lsp_progress", { clear = true })
  end
  vim.api.nvim_create_autocmd("LspProgress", {
    group = M.progress.augroup,
    callback = function(args)
      local client_id = args.data.client_id
      if M.progress.client.id ~= client_id then
        M.progress.client = {
          id = client_id,
          current = vim.lsp.get_client_by_id(client_id),
        }
      end
      local message = { "[" .. M.progress.client.current.name .. "]:" }
      local value = args.data.result.value
      if value.title then
        table.insert(message, value.title)
      end
      if value.message then
        table.insert(message, value.message)
      end
      if value.kind == "end" then
        table.insert(message, "✔")
        vim.defer_fn(function()
          vim.api.nvim_echo({ { "" } }, false, {})
        end, 3000)
      end
      vim.api.nvim_echo({ { table.concat(message, " ") } }, false, {})
    end,
  })
end

function M.setup(opts)
  if opts and opts.progress and opts.progress.enable then
    M.enable_progress()
  end
  local servers = require("lsp.servers")
  for name, server in pairs(servers) do
    local config_type = type(server.config)
    if config_type == "table" then
      M.register(name, server.config)
    elseif config_type == "function" then
      server.config(function(config)
        M.register(name, config)
      end)
    end
  end
end

return M
