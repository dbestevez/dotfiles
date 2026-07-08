local treesitter = require('nvim-treesitter')

treesitter.setup()
treesitter.install({
    'lua',
    'vim',
    'vimdoc',
    'php',
    'twig',
    'javascript',
    'json',
    'yaml',
    'bash',
})

local disabled_ts_filetypes = {
  php = true,
  twig = true
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if disabled_ts_filetypes[ft] then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
