-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

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
vim.opt.foldcolumn = "auto:1"
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

require('plugins')

-- Colorscheme
now(function()
  -- Some favorites
	-- add("neanias/everforest-nvim")
	-- require("everforest").setup({ background = "hard", italics = true,  })
	-- add("sainnhe/gruvbox-material")
	add( { source = "everviolet/nvim", name = "evergarden" })
	require("evergarden").setup({
		theme = {variant = "spring"}, -- spring, summer, fall, winter
		style = {search = {"standout"}, incsearch = {"standout", "italic"}, comment = {}},
		editor = {float = {invert_border = false}},
		overrides = function(colors)
			return {
				WinSeparator = {fg = colors.blue},
				WinBar = {style = {"italic", "bold"}},
			}
		end,
	})

	vim.o.background = "dark"
  vim.cmd('colorscheme evergarden')
end)

require("keys")
require("emojis")
