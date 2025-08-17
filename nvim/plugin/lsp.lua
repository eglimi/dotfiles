-- General LSP config

vim.lsp.config('*', {
  capabilities = MiniCompletion.get_lsp_capabilities()
})

vim.lsp.config("*", {
  root_markers = { ".git", ".jj" },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
          labelDetailsSupport = false,
        }
      }
    }
  }
})

vim.diagnostic.config({
  virtual_text = { current_line = true }
})

-- Mappings.
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
end

nmap('<space>cf', function() vim.lsp.buf.format { async = true } end, 'LSP format buffer')

-- Enable lsp servers
vim.lsp.enable({ "typos", "rust_analyzer", "clangd", "elixir" })
