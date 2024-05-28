require("obsidian").setup({
  --event = {
  --  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --  -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --  "BufReadPre " .. vim.fn.expand "~" .. "/private/notes/**.md",
  --  "BufNewFile " .. vim.fn.expand "~" .. "/private/notes/**.md",
  --},
  disable_frontmatter = true,

  workspaces = {
    {
      name = "notes",
      path = "~/private/notes",
    },
  },

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "daily",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y/%B/%d-%b-%Y",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%d %B %Y",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },

  ui = {
    enable = false,
  },
})
