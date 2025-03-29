-- General LSP config
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Mappings.
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
end

nmap('<space>cf', function() vim.lsp.buf.format { async = true } end, 'LSP format buffer')

-- Enable lsp servers
vim.lsp.enable({ "typos", "rust_analyzer", "clangd", "elixir" })
