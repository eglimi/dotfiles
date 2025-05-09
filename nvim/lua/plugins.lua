-- We use mini.deps for dependency management
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	add('nvim-lua/plenary.nvim')
end)

now(function()
	-- mini modules
	require('mini.cursorword').setup({})
	require('mini.completion').setup({})
	require('mini.surround').setup({})
	require('mini.trailspace').setup({})
	require('mini.align').setup({})
	require('mini.bracketed').setup({})
	require('mini.icons').setup({})
	-- require('mini.snippets').setup({})
	local indentscope = require('mini.indentscope')
	indentscope.setup({
		draw = {
			delay = 50,
			animation = indentscope.gen_animation.none(),
		},
		symbol = '⋮',
	})
	require('mini.statusline').setup({
		set_vim_settings = false
	})
	require('mini.notify').setup({})
	require('mini.diff').setup({})
	require('mini.git').setup({})
	require('mini.ai').setup({})

end)

now(function()
	add('stevearc/oil.nvim')
	require('oil').setup({
		keymaps = {
			["."] = "actions.open_cmdline",
		},
		win_options = {
			conceallevel = 0,
		},
	})
	add('stevearc/quicker.nvim')
	require('quicker').setup()
end)

now(function()
	add({
		source = 'junegunn/fzf',
		checkout = 'master',
		hooks = {
			post_install = function(opts) vim.fn.system(string.format('%s/install --bin', opts.path)) end,
			post_checkout = function(opts) vim.fn.system(string.format('%s/install --bin', opts.path)) end,
		},
	})
	add('ibhagwan/fzf-lua')
	require("fzf-lua").setup({
		winopts = {
			height = 0.95,
			width = 0.90,
			preview = {
				vertical = "down:70%",
				layout = "vertical",
			},
		},
		keymap = {
			fzf = {
				["ctrl-q"] = "select-all",
			},
		},
	})
	require('fzf-lua').register_ui_select()
end)

now(function()
	add({
		source = 'nvim-treesitter/nvim-treesitter',
		-- Use 'master' while monitoring updates in 'main'
		checkout = 'master',
		monitor = 'main',
		-- Perform action after every checkout
		hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
	})
	require('nvim-treesitter.configs').setup({
		ensure_installed = { "cpp","markdown","cmake","css","dockerfile","elixir","go","html","javascript","json","lua","rust","toml","vimdoc" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				local max_filesize = 200 * 1024 -- 200 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = false,
				node_incremental = "v",
				scope_incremental = false,
				node_decremental = "V",
			},
		},
	})
end)

later(function()
	add({
		source = 'olimorris/codecompanion.nvim',
		depends = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
		}
	})

	if vim.env.NVIM_AI == "copilot" then
		-- Configure Copilot
		require('codecompanion').setup({
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = { model = { default = "claude-3.7-sonnet" } }
					})
				end
			}
		})
	elseif vim.env.NVIM_AI == "gemini" then
		-- Configure Gemini
		require('codecompanion').setup({
			strategies = {
				chat = { adapter = "gemini" },
				inline = { adapter = "gemini" },
			},
		})
	end

	require('lsp')
end)

later(function()
	add('tpope/vim-fugitive')
	require("fugitive-handler")
	add('junegunn/gv.vim')
	add('yorickpeterse/nvim-window')
end)

later(function()
	-- Colorscheme
	--add("rmehri01/onenord.nvim")
	--add("EdenEast/nightfox.nvim")
	-- add("rebelot/kanagawa.nvim")
	add("sainnhe/gruvbox-material")
	-- add("sainnhe/everforest")
	--add("folke/tokyonight.nvim")
	-- add("catppuccin/nvim")
end)

now(function()
	add('jamessan/vim-gnupg')
	add('junegunn/vim-easy-align')
	add('nmac427/guess-indent.nvim')
	require('guess-indent').setup({})
end)
