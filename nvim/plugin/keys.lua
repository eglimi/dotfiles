-- Package management
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update plugins" })

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

-- treewalker
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<cmd>Treewalker Right<cr>', { silent = true })

vim.keymap.set('n', '<A-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<A-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
vim.keymap.set('n', '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true })

-- nvim-window
vim.keymap.set('n', '<leader>w', function() require('nvim-window').pick() end, { desc = "Telescope pick window" })

-- file explorer
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "+", require("mini.files").open, { desc = "Open mini.files explorer" })

-- GitPortal
vim.keymap.set("n", "<leader>gb", function() require("gitportal").open_file_in_browser() end, { desc = "Open file in browser" })

-- Copilot / AI
vim.keymap.set({"n"}, "<leader>ac", function() require("codecompanion").chat() end, { desc = "New AI chat" })
vim.keymap.set({"n"}, "<leader>at", function() require("codecompanion").toggle() end, { desc = "Toggle AI chat" })

-- Toggles
vim.keymap.set({"n"}, "<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}),{0}) end, { desc = "Toggle inlay Hints" })

-- Escape in terminal mode
-- vim.keymap.set('t', "<esc><esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" } )

-- More consistent behaviour of cr
local keycode = vim.keycode or function(x)
  return vim.api.nvim_replace_termcodes(x, true, true, true)
end
local keys = {
  ['cr']        = keycode('<CR>'),
  ['ctrl-y']    = keycode('<C-y>'),
  ['ctrl-y_cr'] = keycode('<C-y><CR>'),
}

-- jjui
vim.keymap.set("n", "<leader>jj", "<cmd>lua _lazyjj_toggle()<CR>", {noremap = true, silent = true})
