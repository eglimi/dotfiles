local wezterm = require "wezterm"
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

config.default_prog = { "/bin/zsh" }

front_end = "WebGL"

-- config.font = wezterm.font("Hack")
-- config.font = wezterm.font("Codelia")
config.font = wezterm.font("Comic Code")
config.font_size = 16.0

config.color_scheme = "Gruvbox Dark (Gogh)"

config.colors = {
	cursor_bg = "#E91E63",
	tab_bar = {
		background = "#928374",
		active_tab = {
			bg_color = "#D79921",
			fg_color = "#9D0006",
		},
		inactive_tab = {
			bg_color = "#3C3836",
			fg_color = "#B57614",
		}
	},
}

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
config.window_decorations = "TITLE|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 5000
config.audible_bell = "Disabled"

-- keys
config.disable_default_key_bindings = true
config.leader = { key = "j", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {

	-- font size
	{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
	{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
	{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },

	-- copy / paste
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },

	-- scrolling
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-10) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(10) },
	{ key = "f", mods = "LEADER", action = act.Search{CaseInSensitiveString=""} },
	{ key = "s", mods = "LEADER", action = act.QuickSelect },

	-- panes
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "H", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "J", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "K", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "L", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },


	-- tabs
	{ key = "c", mods = "LEADER", action = act.SpawnCommandInNewTab({
		cwd = "~",
		domain = "CurrentPaneDomain",
	})
	},
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER", action = act.ActivateLastTab },
	{ key = "z", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	-- { key = "RightArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	-- { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
}

for i = 1, 9 do
  -- LEADER + number to activate that tab
  table.insert(config.keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
end

table.insert(config.keys, {
	key = ",", mods = "LEADER",
	action = act.PromptInputLine {
		description = 'Enter new name for tab',
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	}
})

-- start maximize. Useful when not working on a tiling wm.
-- On Ubuntu, use Win-Up / Down to maximize and toggle
-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- Use default local domain
-- config.unix_domains = {
--   { name = 'unix' },
-- }
-- config.default_gui_startup_args = { 'connect', 'unix' }

return config
