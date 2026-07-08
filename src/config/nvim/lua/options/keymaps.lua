-- Disable arrow keys
for _, key in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
    vim.keymap.set({ 'n', 'v', 'o' }, key, '<Nop>')
end

-- Vim shortcuts
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<CR>', function()
    vim.cmd.nohlsearch()
    vim.cmd.normal({ '<CR>', bang = true })
end)

vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')

vim.keymap.set('n', '<leader>php', function()
    vim.bo.filetype = 'php'
end)

vim.keymap.set('n', '<leader>r', function()
    vim.cmd.source(vim.env.MYVIMRC)
end)

vim.keymap.set('n', '<leader>e', function()
    vim.cmd.tabedit(vim.env.MYVIMRC)
end)

-- Split shortcuts
vim.keymap.set('n', '<C-w>-',     '<Cmd>rightbelow new<CR>')
vim.keymap.set('n', '<C-w>|',     '<Cmd>vnew<CR>')
vim.keymap.set('n', '<C-w>t',     '<Cmd>tabnew<CR>')
vim.keymap.set('n', '<C-w><C-h>', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '<C-w><C-l>', '<Cmd>tabnext<CR>')
vim.keymap.set('n', '<C-w><S-h>', '<Cmd>vertical resize -5<CR>')
vim.keymap.set('n', '<C-w><S-j>', '<Cmd>resize +5<CR>')
vim.keymap.set('n', '<C-w><S-k>', '<Cmd>resize -5<CR>')
vim.keymap.set('n', '<C-w><S-l>', '<Cmd>vertical resize +5<CR>')

-- Reindent
vim.keymap.set("n", "<leader>=", function()
    require('utils.preserve').run(function()
        vim.cmd.normal({ "gg=G", bang = true })
    end)
end, {
    desc = "Reindent buffer",
})

-- Terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
