-- We use mini.deps for dependency management
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	add('nvim-lua/plenary.nvim')
	add({
		source = 'nvim-treesitter/nvim-treesitter',
		checkout = 'main',
		-- Perform action after every checkout
		hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
	})

	-- Install parsers and avoid annyoing install message.
	require("nvim-treesitter").install( { "rust","elixir","cpp","zig","go","lua","javascript","json","html","css","dockerfile","markdown","toml","cmake" } )

	add({
		source = 'nvim-treesitter/nvim-treesitter-textobjects',
		checkout = 'main',
	})
end)

now(function()
	-- mini modules
	-- text editing
	local spec_treesitter = require('mini.ai').gen_spec.treesitter
	require('mini.ai').setup({
		custom_textobjects = {
			f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
			c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
		}
	})
	require('mini.align').setup({})
	require('mini.completion').setup({})
	require('mini.splitjoin').setup()
	require('mini.surround').setup({})

	-- general workflow
	require('mini.bracketed').setup({})
	require('mini.diff').setup({})
	require('mini.files').setup()
	require('mini.git').setup({})

	-- appearance
	require('mini.cursorword').setup({})
	-- require('mini.snippets').setup({})
	require('mini.indentscope').setup({
		draw = {
			delay = 50,
			animation = function() return 0 end,
		},
		symbol = '⋮',
	})
	require('mini.icons').setup({})
	require('mini.notify').setup({})
	require('mini.statusline').setup({
		set_vim_settings = false
	})
	require('mini.trailspace').setup({})
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

later(function()
	add({
		source = 'olimorris/codecompanion.nvim',
		depends = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
		}
	})

	local prompt = [[You are a code-focused AI programming assistant that is an expert in this programming language.
You must
- Keep your answers short.
- Don't repeat code, just show the changes.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Never ask a follow-up question at the end.
- Never praise the user about the question.
- Use Markdown formatting.
- Minimize additional prose unless clarification is needed.
]]

	if vim.env.NVIM_AI == "copilot" then
		-- Configure Copilot
		require('codecompanion').setup({
			opts = { system_prompt = prompt },
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = { model = { default = "claude-sonnet-4" } }
					})
				end
			}
		})
	elseif vim.env.NVIM_AI == "gemini" then
		-- Configure Gemini
		require('codecompanion').setup({
			opts = { system_prompt = prompt },
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
