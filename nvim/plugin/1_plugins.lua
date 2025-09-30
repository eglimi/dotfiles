vim.pack.add({
	-- libs
	"https://github.com/nvim-lua/plenary.nvim",
	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	-- mini
	"https://github.com/echasnovski/mini.nvim",
	-- nav, picker, etc
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/quicker.nvim",
	-- vcs
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/martintrojer/jj-fugitive",
	"https://github.com/junegunn/gv.vim",
	-- utils
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/yorickpeterse/nvim-window",
	"https://github.com/jamessan/vim-gnupg",
	"https://github.com/junegunn/vim-easy-align",
	"https://github.com/nmac427/guess-indent.nvim",
	-- ai
	"https://github.com/olimorris/codecompanion.nvim",
	-- theme
	{ src = "https://github.com/everviolet/nvim", name = "evergarden" },
}, { load = true })


local function setup_treesitter()
	local ts_parsers = { "rust","elixir","cpp","zig","go","lua","javascript","json","html","css","dockerfile","markdown","toml","cmake" }
	local ts = require("nvim-treesitter")
	ts.install(ts_parsers)
	local autocmd = vim.api.nvim_create_autocmd
	autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
		callback = function(args)
			local spec = args.data.spec
			if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
				vim.schedule(function()
					ts.update()
				end)
			end
		end,
	})
end

local function setup_mini()
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
end

local function setup_nav()
	require('oil').setup({
		watch_for_changes = true,
		keymaps = {
			["."] = "actions.open_cmdline",
			["<C-p>"] = {"actions.preview", opts = {split = "belowright"} },
			["<C-s>"] = {"actions.select", opts = {vertical = true, split = "belowright"} },
		},
	})
	require('quicker').setup()
	require('guess-indent').setup({})

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
end

local function setup_utils()
	require("toggleterm").setup({ direction = "tab" })
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazyjj = Terminal:new({ cmd = "jjui", hidden = true })
	function _lazyjj_toggle() lazyjj:toggle() end
end

local function setup_ai()
	local prompt = [[You are a code-focused AI programming assistant that is an expert in this programming language.
You must
- Keep your answers short.
- Don't repeat code, just show the changes.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Never ask a follow-up question at the end.
- Never praise the user about the question.
- Use Markdown formatting.
- Minimize additional prose unless clarification is needed.
- If you show code examples without an explicit request for a programming language, use Rust (preferred) or Golang.
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
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = { model = { default = "claude-sonnet-4.5" } }
						})
					end
				}
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
end

local function setup_theme()
	-- alternatives: everforest, gruvbox-material
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
end

setup_treesitter()
setup_mini()
setup_nav()
setup_utils()
setup_ai()
setup_theme()
