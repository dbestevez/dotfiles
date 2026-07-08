local snippets = require('mini.snippets')

snippets.setup({
    snippets = {
        require('snippets.php'),
        require('snippets.twig'),
        require('snippets.fake'),
        snippets.gen_loader.from_file('~/.config/nvim/snippets/global.json'),
        snippets.gen_loader.from_lang(),
    },
})

vim.keymap.set({ 'i', 's' }, '<Esc>', function()
    if snippets.session.get() ~= nil then
        vim.schedule(function()
            snippets.session.stop()
        end)
    end

    return vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
end, {
    expr = true,
    desc = 'Stop snippet session and leave insert mode',
})
