vim.o.sessionoptions = 'blank,buffers,folds,help,tabpages,winsize,winpos,terminal'

require('auto-session').setup({
    cwd_change_handling = true,
    suppressed_dirs = { '~/', '~/Downloads', '/' },
})
