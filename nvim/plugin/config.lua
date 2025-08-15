vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.clipboard = "unnamed"

-- Global options
vim.opt.termguicolors = true
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.colorcolumn = "100"
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "0"
vim.opt.breakindent = true

vim.opt.list = true
vim.opt.listchars = "tab:▸.,lead:›,trail:×"

vim.opt.tabstop = 4
--vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.undofile = true

vim.opt.wrap = true

vim.opt.mouse = ""
-- Disable netrw, we use oil
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- statusbar and winbar
-- Use the global statusbar and show the filename in the winbar
vim.opt.laststatus = 3
vim.opt.winbar = '%=%m %t%='

vim.opt.completeopt = "menuone,noselect,popup"

vim.opt.winborder = "rounded"

vim.opt.background = "dark"
vim.cmd('colorscheme evergarden')
