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

-- vim.keymap.set('n', '<leader>f', function() require('mini.pick').builtin.files() end, { desc = "mini.pick find files" })
-- vim.keymap.set('n', '<leader>b', function() require('mini.pick').builtin.buffers() end, { desc = "mini.pick buffer" })
-- vim.keymap.set('n', '<leader>r', function() require('mini.pick').builtin.resume() end, { desc = "mini.pick resume" })
-- vim.keymap.set('n', '<leader>/', function() require('mini.pick').builtin.grep_live() end, { desc = "mini.pick live grep" })
-- vim.keymap.set('n', '<leader>sw', function() require('mini.pick').builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "mini.pick find word under cursor" })

-- nvim-window
vim.keymap.set('n', '<leader>w', function() require('nvim-window').pick() end, { desc = "Telescope pick window" })

-- file explorer
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "+", require("mini.files").open, { desc = "Open mini.files explorer" })

-- Git
vim.keymap.set("n", "<leader>gl", "<cmd>0G log --oneline --graph --all --decorate<cr>", { desc = "Git log pretty" })
vim.keymap.set("n", "<leader>gdm", ":DiffviewOpen --imply-local master...HEAD<cr>", { desc = "Diffview diff to master" })
vim.keymap.set("n", "<leader>gdn", ":DiffviewOpen --imply-local main...HEAD<cr>", { desc = "Diffview diff to main" })
vim.keymap.set("n", "<leader>gdf", ":DiffviewFileHistory %<cr>", { desc = "Diffview file history" })
vim.keymap.set("n", "<leader>gdc", ":DiffviewClose<cr>", { desc = "Diffview close" })
vim.keymap.set("n", "<leader>gdd", function() require("mini.diff").toggle_overlay() end, { desc = "Toggle diff overlay" })
local rhs = '<cmd>lua MiniGit.show_at_cursor()<CR>'
vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Git show at cursor' })

-- Formatting Markdown table in visual mode
vim.keymap.set("v", "<space>ft", ":'<,'>EasyAlign *|<CR>", { desc = "Align Markdown table" })

-- Escape in terminal mode
vim.keymap.set('t', [[<Esc>]], [[<C-\><C-n>]], { desc = "Escape terminal mode" } )

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = { "git" },
    command = "setlocal foldmethod=syntax",
})

autocmd("FileType", {
    pattern = { "markdown", "c", "cpp" },
    callback = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldlevel = 5
    end
})
autocmd("FileType", {
    pattern = { "minideps-confirm" },
    command = "setlocal foldlevel=0"
})

autocmd("FileType", {
    pattern = { "json" },
    command = "set formatprg=jq",
})
