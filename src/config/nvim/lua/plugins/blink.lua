local blink = require('blink.cmp')

blink.build():pwait()
blink.setup({
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },

        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },

        menu = {
            auto_show = true,
        },
    },

    signature = {
        enabled = true
    },

    snippets = {
        preset = 'mini_snippets',
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
