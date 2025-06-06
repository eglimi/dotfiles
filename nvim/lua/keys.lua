-- General keymaps
vim.keymap.set('n', '<esc>', "<cmd>nohlsearch<cr>", { desc = "Cancel hlsearch" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- fzf
vim.keymap.set('n', 'tt', ':FzfLua<CR>', { desc = "Open FzfLua" } )
vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { desc = "fzf find files" })
vim.keymap.set('n', '<leader>b', require('fzf-lua').buffers, { desc = "fzf buffers" })
vim.keymap.set('n', '<leader>r', require('fzf-lua').resume, { desc = "Resume last picker" })
vim.keymap.set('n', '<leader>/', require('fzf-lua').live_grep_native, { desc = "fzf live grep" })
vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = "fzf search word under cursor" })
vim.keymap.set('n', '<leader>sf', function() require('fzf-lua').files({ query = vim.fn.expand("<cword>") }) end, { desc = "fzf search filename under the cursor" })

-- nvim-window
vim.keymap.set('n', '<leader>w', function() require('nvim-window').pick() end, { desc = "Telescope pick window" })

-- file explorer
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "+", require("mini.files").open, { desc = "Open mini.files explorer" })

-- Git
vim.g.fugitive_summary_format = "%cs || %<(20,trunc)%an || %s"
vim.keymap.set("n", "<leader>gg", "<cmd>0G<cr>", { desc = "Git open interactive view" })
vim.keymap.set("n", "<leader>gll", "<cmd>0G log --oneline --graph --all --decorate<cr>", { desc = "Git log pretty" })
vim.keymap.set("n", "<leader>glf", "<cmd>0Gclog<cr>", { desc = "Git log current file" })
vim.keymap.set("n", "<leader>gb",  "<cmd>GBrowse<cr>", { desc = "GBrowse" })
vim.keymap.set("n", "<leader>gdv", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff in vertical split" })
vim.keymap.set("n", "<leader>gdd", function() require("mini.diff").toggle_overlay() end, { desc = "Toggle diff overlay" })
local rhs = '<cmd>lua MiniGit.show_at_cursor()<CR>'
vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Git show at cursor' })

-- Copilot / AI
vim.keymap.set({"n"}, "<leader>ac", function() require("codecompanion").chat() end, { desc = "New AI chat" })
vim.keymap.set({"n"}, "<leader>at", function() require("codecompanion").toggle() end, { desc = "Toggle AI chat" })

-- Toggles
vim.keymap.set({"n"}, "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0}) end, { desc = "Toggle inlay Hints" })

-- Treesitter
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)

-- Formatting and preview Markdown
local function preview_markdown()
    local file_path = vim.api.nvim_buf_get_name(0)
    require('plenary.job'):new({
        command = 'inlyne',  -- Replace 'xdg-open' with the external tool you want to use
        args = { file_path },
    }):start()
end
vim.keymap.set("v", "<leader>ft", ":'<,'>EasyAlign *|<CR>", { desc = "Markdown align table" })
vim.keymap.set('n', '<leader>pm', preview_markdown, { desc = "Markdown preview file" })

-- Escape in terminal mode
vim.keymap.set('t', [[<Esc>]], [[<C-\><C-n>]], { desc = "Escape terminal mode" } )

-- More consistent behaviour of cr
local keycode = vim.keycode or function(x)
  return vim.api.nvim_replace_termcodes(x, true, true, true)
end
local keys = {
  ['cr']        = keycode('<CR>'),
  ['ctrl-y']    = keycode('<C-y>'),
  ['ctrl-y_cr'] = keycode('<C-y><CR>'),
}

-- lazygit / lazyjj
vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>jj", "<cmd>lua _lazyjj_toggle()<CR>", {noremap = true, silent = true})

-- Reload nvim
vim.keymap.set('n', '<leader>sr', function()
    -- Clear module cache
    for name,_ in pairs(package.loaded) do
        if name:match('jujutsu') then
            package.loaded[name] = nil
        end
    end

    -- Source init file
    vim.cmd('source ' .. vim.fn.stdpath('config') .. '/init.lua')
    vim.notify('Neovim config reloaded!', vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = 'Reload neovim config' })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = { "*" },
    callback = function(details)
        local bufnr = details.buf
        if not pcall(vim.treesitter.start, bufnr) then return end
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldlevel = 5
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})
autocmd("FileType", {
    pattern = { "minideps-confirm" },
    command = "setlocal foldlevel=0"
})
autocmd("FileType", {
    pattern = { "git" },
    callback = function(details)
        vim.wo.foldmethod = 'syntax'
        vim.wo.foldlevel = 1
    end
})
autocmd("FileType", {
    pattern = { "json" },
    command = "set formatprg=jq",
})

