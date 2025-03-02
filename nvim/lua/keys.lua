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
vim.g.fugitive_summary_format = "%cs || %<(20,trunc)%an || %s"
vim.keymap.set("n", "<leader>gg", "<cmd>0G<cr>", { desc = "Git open interactive view" })
vim.keymap.set("n", "<leader>gll", "<cmd>0G log --oneline --graph --all --decorate<cr>", { desc = "Git log pretty" })
vim.keymap.set("n", "<leader>glf", "<cmd>0Gclog<cr>", { desc = "Git log current file" })
vim.keymap.set("n", "<leader>gb",  "<cmd>GBrowse<cr>", { desc = "GBrowse" })
vim.keymap.set("n", "<leader>gdv", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff in vertical split" })
-- vim.keymap.set("n", "<leader>gdm", ":DiffviewOpen --imply-local master...HEAD<cr>", { desc = "Diffview diff to master" })
-- vim.keymap.set("n", "<leader>gdn", ":DiffviewOpen --imply-local main...HEAD<cr>", { desc = "Diffview diff to main" })
-- vim.keymap.set("n", "<leader>gdf", ":DiffviewFileHistory %<cr>", { desc = "Diffview file history" })
-- vim.keymap.set("n", "<leader>gdc", ":DiffviewClose<cr>", { desc = "Diffview close" })
vim.keymap.set("n", "<leader>gdd", function() require("mini.diff").toggle_overlay() end, { desc = "Toggle diff overlay" })
local rhs = '<cmd>lua MiniGit.show_at_cursor()<CR>'
vim.keymap.set({ 'n', 'x' }, '<leader>gs', rhs, { desc = 'Git show at cursor' })

-- Copilot / AI
vim.keymap.set({"n"}, "<leader>ac", function() require("CopilotChat").open() end, { desc = "New AI chat" })
vim.keymap.set({"n"}, "<leader>at", function() require("CopilotChat").toggle() end, { desc = "Toggle AI chat" })
vim.keymap.set({"n"}, "<leader>am", function() require("CopilotChat").select_model() end, { desc = "Select AI model" })

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

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    return keys['cr']
  end
end

vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })

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

