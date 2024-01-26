local M = {
  default_config = nil,
}

function M.get_default_caps()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )
end

function M.register(name, config)
  if not M.default_config then
    M.default_config = { capabilities = M.get_default_caps() }
  end
  require("lspconfig")[name].setup(
    vim.tbl_deep_extend("force", M.default_config, config)
  )
end

function M.setup()
  local servers = require("lsp.servers")
  for name, opts in pairs(servers) do
    opts.config(function(config)
      M.register(name, config)
    end)
  end
end

return M
