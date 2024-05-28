local home = vim.env.HOME

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf=bufnr })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gD', vim.lsp.buf.declaration, 'goto declaration')
  nmap('gd', vim.lsp.buf.definition, 'goto definition')
  nmap('gi', vim.lsp.buf.implementation, 'goto implementation')
  nmap('<space>rn', vim.lsp.buf.rename, 'rename')
  nmap('gr', vim.lsp.buf.references, 'references')
  nmap('ca', vim.lsp.buf.code_action, 'code action')
  nmap('<space>D', vim.lsp.buf.type_definition, 'type definition')
  nmap('<space>e', vim.diagnostic.open_float, 'open diagnostic float')
  nmap('<space>q', vim.diagnostic.setloclist, 'Add buffer diagnostic to loclist')
  nmap('<space>cf', function() vim.lsp.buf.format { async = true } end, 'LSP format buffer')

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = false,
      update_in_insert = false,
    })
end

local lspconfig = require('lspconfig')

local servers = { 'clangd', 'gopls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    autostart = false,
  }
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
}

require 'lspconfig'.ltex.setup {
  on_attach = on_attach,
  autostart = false,
  cmd = { home .. "/programs/ltex-ls/bin/ltex-ls" },
  settings = {
    ltex = {
      language = "en-GB",
      additionalRules = { languageModel = home .."/programs/ltex-ngram", },
    },
  },
}

require('lspconfig').typos_lsp.setup({
  on_attach = on_attach,
  autostart = true,
  init_options = {
    -- Custom config. Used together with any workspace config files, taking precedence for
    config = home .. '/.config/typos-lsp/typos.toml',
    -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
    -- Defaults to error.
    diagnosticSeverity = "Info"
  }
})

require 'lspconfig'.lua_ls.setup {
  cmd = { home .. "/.local/bin/lua-language-server/bin/lua-language-server" },
  autostart = false,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.uv.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
