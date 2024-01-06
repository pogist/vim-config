local M = {}

function M.get_default_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )
end

function M.setup_servers(servers)
  local common_opts = { capabilities = M.get_default_capabilities() }
  for server, server_opts in pairs(servers) do
    require("lspconfig")[server].setup(
      vim.tbl_deep_extend("force", common_opts, server_opts)
    )
  end
end

function M.config(opts)
  M.setup_servers(opts.servers)
end

return M
