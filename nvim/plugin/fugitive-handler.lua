-- Handler for fugitive's GBrowse command
-- It opens the current file in the correct branch. No other features are supported.

FugitiveHandler = {}

function FugitiveHandler.roche_ado(opts)
	if string.find(opts.remote, "azure") == nil then
		return ""
	end

	-- Main url
	url = string.gsub(opts.remote, "^(git@ssh.dev.azure.com:v3)/(%w+)/(%w+)/(%S+)$", "https://dev.azure.com/%2/%3/_git/%4")

	-- Add path
	url = url .. "?path=/" .. opts.path

	-- branch
	url = url .. "&version=GB" .. opts.commit
	return url
end

function FugitiveHandler.roche_gitlab(opts)
	if string.find(opts.remote, "code.roche.com") == nil then
		return ""
	end

	-- Main url
	url = string.gsub(opts.remote, "^(git@ssh.code.roche.com):([%w-]+/[%w/-]+).git", "https://code.roche.com/%2")

	-- branch
	url = url .. "/-/tree/" .. opts.commit

	-- Add path
	url = url .. "/" .. opts.path
	return url
end

-- To debug, use print and inspect
-- print(vim.inspect(url))
local handlers = {}
if vim.g.fugitive_browse_handlers ~= nil then
	handlers = vim.api.nvim_get_var('fugitive_browse_handlers')
end
table.insert(handlers, FugitiveHandler.roche_ado)
table.insert(handlers, FugitiveHandler.roche_gitlab)
vim.api.nvim_set_var('fugitive_browse_handlers', handlers)

vim.api.nvim_create_user_command(
	'Browse',
	function (opts)
		vim.fn.system { 'xdg-open', opts.fargs[1] }
	end,
	{ nargs = 1 }
)
