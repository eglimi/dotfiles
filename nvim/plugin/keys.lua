-- Package management
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update plugins" })

-- General keymaps
vim.keymap.set('n', '<esc>', "<cmd>nohlsearch<cr>", { desc = "Cancel hlsearch" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Picker
vim.keymap.set('n', '<leader>f', function() require('mini.pick').builtin.files() end, { desc = "mini.pick find files" })
vim.keymap.set('n', '<leader>b', function() require('mini.pick').builtin.buffers() end, { desc = "mini.pick buffer" })
vim.keymap.set('n', '<leader>r', function() require('mini.pick').builtin.resume() end, { desc = "mini.pick resume" })
vim.keymap.set('n', '<leader>/', function() require('mini.pick').builtin.grep_live() end, { desc = "mini.pick live grep" })
vim.keymap.set('n', '<leader>sw', function() require('mini.pick').builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "mini.pick find word under cursor" })

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

-- Utils
vim.keymap.set({"n"}, "<leader>ut", function() require("mini.trailspace").trim() end, { desc = "Trim trailing whitespace" })

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
