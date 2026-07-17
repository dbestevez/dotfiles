require('spider').setup {
	skipInsignificantPunctuation = false,
	subwordMovement = true,
	consistentOperatorPending = false,
	customPatterns = {},
}

vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>")
vim.keymap.set('n', 'cw', 'ce', { remap = true })
vim.keymap.set('n', 'dw', 'de', { remap = true })
