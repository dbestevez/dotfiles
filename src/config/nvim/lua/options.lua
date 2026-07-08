-- Basics
vim.g.mapleader = ' '
vim.opt.laststatus = 2
vim.opt.mouse = 'a'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.updatetime = 250
vim.opt.backupcopy = 'yes'
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Colors
vim.opt.background = 'dark'
vim.opt.colorcolumn = table.concat(vim.fn.range(81, 120), ',')
vim.opt.guicursor = ''
vim.opt.termguicolors = true

-- Spaces & Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- UI Layout
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.previewheight = 15
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf:append({ 'usetab', 'newtab' })
vim.opt.ttyfast = true
vim.opt.wildmenu = true

-- Fold
vim.opt.foldenable = true
vim.opt.foldlevelstart = 20
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 20

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
