-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright", "gopls", "clangd", "rust_analyzer" }
local nvlsp = require "nvchad.configs.lspconfig"

local opts = { noremap = true, silent = true }

local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- keymap("n", "gd", "<cmd>Telescope lsp_definitions jump_type=never ignore_filename=false<cr>", opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references include_current_line=false include_declaration=false<cr>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations jump_type=never ignore_filename=false<cr>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>b", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

require("lsp-format").setup {}

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  require("lsp-format").on_attach(client, bufnr)
end


-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = nvlsp.on_attach,
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    underline = true,
  })
