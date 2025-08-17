local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = { "*" },
    callback = function(details)
        local bufnr = details.buf
        if not pcall(vim.treesitter.start, bufnr) then return end
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldlevel = 6
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

autocmd("FileType", {
    pattern = { "minideps-confirm" },
    command = "setlocal foldlevel=0"
})

autocmd("FileType", {
    pattern = { "git" },
    callback = function(details)
        vim.wo.foldmethod = 'syntax'
        vim.wo.foldlevel = 1
    end
})

autocmd("FileType", {
    pattern = { "json" },
    command = "set formatprg=jq",
})

