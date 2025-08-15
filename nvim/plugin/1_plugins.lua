-- We use mini.deps for dependency management

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
		watch_for_changes = true,
		keymaps = {
			["."] = "actions.open_cmdline",
			["<C-p>"] = {"actions.preview", opts = {split = "belowright"} },
			["<C-s>"] = {"actions.select", opts = {vertical = true, split = "belowright"} },
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
end)

later(function()
	add("akinsho/toggleterm.nvim")
	require("toggleterm").setup({ direction = "tab" })
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	local lazyjj = Terminal:new({ cmd = "jjui", hidden = true })
	function _lazygit_toggle() lazygit:toggle() end
	function _lazyjj_toggle() lazyjj:toggle() end
end)

later(function()
	add('tpope/vim-fugitive')
	add('junegunn/gv.vim')
	add('yorickpeterse/nvim-window')
	add('martintrojer/jj-fugitive')
end)

now(function()
	add('jamessan/vim-gnupg')
	add('junegunn/vim-easy-align')
	add('nmac427/guess-indent.nvim')
	require('guess-indent').setup({})
end)

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

