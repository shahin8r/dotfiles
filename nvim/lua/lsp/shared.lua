local M = {}

local mappings = require('mappings')

M.on_attach = mappings.lspconfig.on_attach
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

---Merge shared defaults with a specific server configuration.
---@param overrides table?
function M.with_defaults(overrides)
  return vim.tbl_deep_extend('force', {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }, overrides or {})
end

return M
