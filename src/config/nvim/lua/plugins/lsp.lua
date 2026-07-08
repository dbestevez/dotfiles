--vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup', 'fuzzy' }

local blink = require('blink.cmp')

vim.diagnostic.config({
    virtual_text = false,
    float = {
        border = 'rounded',
        source = 'if_many',
        focusable = false,
    },
})

vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = 'cursor',
        })
    end,
})

local function lsp_definition(cmd)
    return function()
        if cmd then
            vim.cmd(cmd)
        end

        vim.lsp.buf.definition()
    end
end

local function on_attach(client, bufnr)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
        buffer = bufnr,
        desc = 'Go to definition',
    })

    vim.keymap.set('n', 'gdh', lsp_definition('split'), {
        buffer = bufnr,
        desc = 'Go to definition in horizontal split',
    })

    vim.keymap.set('n', 'gdv', lsp_definition('vsplit'), {
        buffer = bufnr,
        desc = 'Go to definition in vertical split',
    })

    vim.keymap.set('n', 'gdt', lsp_definition('tab split'), {
        buffer = bufnr,
        desc = 'Go to definition in new tab',
    })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
        buffer = bufnr,
        desc = 'Hover',
    })

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
        buffer = bufnr,
        desc = 'Rename',
    })

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
        buffer = bufnr,
        desc = 'Code action',
    })
end

vim.lsp.config('phpactor', {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = {
        '.git',
        'composer.json',
        '.phpactor.json',
        '.phpactor.yml',
    },
    capabilities = blink.get_lsp_capabilities(),
    on_attach = on_attach,
    init_options = {
        ['indexer.exclude_patterns'] = {
            '/vendor/',
            '/var/cache/',
        },
        ['php_code_sniffer.enabled'] = true,
        ['php_code_sniffer.show_diagnostics'] = true,
        ['language_server_phpstan.enabled'] = true,
        ['language_server_psalm.enabled'] = false,
    },
})

vim.lsp.enable('phpactor')
