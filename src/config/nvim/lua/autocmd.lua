-- Creates directory if it does not exist
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end

    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        if vim.bo[args.buf].filetype == 'php' then
            vim.bo[args.buf].indentexpr = 'GetPhpIndent()'
            return
        end

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        require('utils.preserve').run(require('utils.trim').whitespaces)
    end
})
