local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>lb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>lh', builtin.help_tags, { desc = 'Telescope tags' })

vim.keymap.set('n', '<leader>lr', function()
    require('telescope.builtin').lsp_references({
        show_line = false,
        include_declaration = false,
        jump_type = 'auto',
    })
end, { buffer = bufnr, desc = 'References' })

vim.keymap.set('n', '<leader>ls', function()
    require('telescope.builtin').lsp_document_symbols()
end, { buffer = bufnr, desc = 'Document symbols' })

vim.keymap.set('n', '<leader>lt', function()
    require('telescope-tabs').list_tabs()
end, { desc = 'Find tabs' })

vim.keymap.set('n', '<leader>lw', function()
    require('telescope.builtin').lsp_dynamic_workspace_symbols()
end, { buffer = bufnr, desc = 'Workspace symbols' })
