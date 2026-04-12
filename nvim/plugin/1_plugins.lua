--require("vim._extui").enable({
--	enable = true,
--	msg = { target = "msg", }
--})

vim.pack.add({
	-- libs, utils
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/yorickpeterse/nvim-window",
	"https://github.com/jamessan/vim-gnupg",
	"https://github.com/clabby/difftastic.nvim",
	-- treesitter, lsp
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	-- mini
	"https://github.com/echasnovski/mini.nvim",
	-- nav, picker, etc
	-- "https://github.com/comfysage/artio.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/nmac427/guess-indent.nvim",
	"https://github.com/aaronik/treewalker.nvim",
	-- vcs
	-- "https://github.com/yannvanhalewyn/jujutsu.nvim",
	-- ai
	"https://github.com/olimorris/codecompanion.nvim",
	-- Run bun install -g mcp-hub@latest to update
	-- "https://github.com/ravitemer/mcphub.nvim",
	-- theme
	{ src = "https://github.com/everviolet/nvim", name = "evergarden" },
	{ src = "https://github.com/sainnhe/gruvbox-material" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
}, { load = true })


local function setup_treesitter()
	local ts_parsers = { "rust","elixir","cpp","zig","go","lua","javascript","json","html","css","dockerfile","markdown","typst","toml","cmake","yaml" }
	local ts = require("nvim-treesitter")
	ts.install(ts_parsers)
	vim.api.nvim_create_autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
		callback = function(args)
			local spec = args.data.spec
			if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
				vim.schedule(function()
					ts.update()
				end)
			end
		end,
	})

	require("tiny-inline-diagnostic").setup()
end

local function setup_mini()
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
	require('mini.pick').setup({})

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

	vim.ui.select = require('mini.pick').ui_select
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
	require('guess-indent').setup()
end

local function setup_vcs()
end

local function setup_utils()
	require("toggleterm").setup({ direction = "tab" })
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazyjj = Terminal:new({ cmd = "jjui", hidden = true })
	function _lazyjj_toggle() lazyjj:toggle() end

	require("gitportal").setup({
		git_provider_map = {
			["git@ssh.code.roche.com"] = {
				provider = "gitlab",
				base_url = "https://code.roche.com/"
			}
		}
	})
	require("difftastic-nvim").setup({
		download = true, -- Auto-download pre-built binary
	})
end

local function setup_ai()
	local prompt = [[You are a code-focused AI programming assistant that is an expert in this programming language.
You must
- Keep your answers short.
- Use Markdown formatting.
- When writing text or documentation, don't use bold text and don't use colons in prose.
- Don't repeat code, just show the changes.
- Only return code that's directly relevant to the task at hand. You may omit code that isn’t necessary for the solution.
- Never ask a follow-up question at the end.
- Post a concise task summary only when clearly useful. In all other cases, just show "Done" as a summary. In all cases, keep it minimal.
- Never praise the user about the question.
- Minimize additional prose unless clarification is needed.
- If you show code examples without an explicit request for a programming language, use Rust (preferred) or Golang.
- I almost always work with jj instead of Git. Try jj first and Git second if you need VCS info.
]]

	if vim.env.NVIM_AI == "copilot" then
		require('codecompanion').setup({
			ignore_warnings = true,
			interactions = {
				chat = {
					adapter = "copilot",
					opts = { system_prompt = function() return prompt end },
					tools = {
						["run_command"] = {
							opts = {
								allowed_in_yolo_mode = true,   -- allow in yolo mode
								require_approval_before = false, -- skip pre-approval entirely
								require_cmd_approval = false,
							},
						},
						["ask_questions"] = {
							enabled = false,
						},
					},
				},
				inline = { adapter = "copilot" },
			},
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = { model = { default = "claude-opus-4.6" } }
						})
					end,
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							url = "https://eu.build-cli.roche.com/proxy/v1/messages",
							env = {
								api_key = "cmd:~/.local/bin/build-cli auth token",
							},
							headers = {
								["x-api-key"] = "",
								["Authorization"] = "Bearer ${api_key}",
								["x-build-cli-tool"] = "claude",
							},
							schema = {
								model = { default = "claude-opus-4-6" },
							},
						})
					end,
				},
			},
			extensions = { }
		})
	elseif vim.env.NVIM_AI == "gemini" then
		-- Configure Gemini
		require('codecompanion').setup({
			interactions = {
				chat = {
					adapter = "gemini",
					opts = { system_prompt = function() return prompt end },
				},
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

setup_utils()
setup_treesitter()
setup_mini()
setup_nav()
setup_vcs()
setup_ai()
setup_theme()
