local action_state = require('telescope.actions.state')
local actions      = require('telescope.actions')
local builtin      = require('telescope.builtin')
local config       = require('telescope.config').values
local finders      = require('telescope.finders')
local lga_actions  = require('telescope-live-grep-args.actions')
local make_entry   = require('telescope.make_entry')
local pickers      = require('telescope.pickers')
local tabs         = require('telescope-tabs')
local telescope    = require('telescope')
local sorters      = require('telescope.sorters')

local function open_multiple(command)
    return function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()

        if vim.tbl_isempty(selections) then
            selections = { action_state.get_selected_entry() }
        end

        actions.close(prompt_bufnr)

        for _, entry in ipairs(selections) do
            local path = entry.path or entry.filename

            if path then
                vim.cmd(command .. ' ' .. vim.fn.fnameescape(path))
            end
        end
    end
end

local function fd_regex_picker()
    pickers.new({}, {
        prompt_title = 'Find files (fd)',

        finder = finders.new_job(
            function(prompt)
                if prompt == '' then
                    prompt = '.'
                end

                return { 'fd', '--type', 'f', prompt }
            end,
            make_entry.gen_from_file({})
        ),

        sorter = sorters.empty(),
        previewer = config.file_previewer({}),

        attach_mappings = function(_, map)
            map('i', '<C-v>', open_multiple('vsplit'))
            map('n', '<C-v>', open_multiple('vsplit'))

            map('i', '<C-h>', open_multiple('split'))
            map('n', '<C-h>', open_multiple('split'))

            map('i', '<C-t>', open_multiple('tabedit'))
            map('n', '<C-t>', open_multiple('tabedit'))

            return true
        end,
    }):find()
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-v>'] = open_multiple('vsplit'),
                ['<C-h>'] = open_multiple('split'),
                ['<C-t>'] = open_multiple('tabedit')
            },
            n = {
                ['<C-v>'] = open_multiple('vsplit'),
                ['<C-h>'] = open_multiple('split'),
                ['<C-t>'] = open_multiple('tabedit')
            }
        }
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = { -- extend mappings
        i = {
          ['<C-k>'] = lga_actions.quote_prompt(),
          ['<C-i>'] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ['<C-space>'] = lga_actions.to_fuzzy_refine,
        },
      },
    }
})

telescope.load_extension('live_grep_args')

vim.keymap.set('n', '<C-p>',      builtin.find_files,                    { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fd', fd_regex_picker,                       { desc = 'Telescope find files with regex'})
vim.keymap.set('n', '<leader>lb', builtin.buffers,                       { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>lh', builtin.help_tags,                     { desc = 'Telescope tags' })
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols,          { buffer = bufnr, desc = 'Document symbols' })
vim.keymap.set('n', '<leader>lt', tabs.list_tabs,                        { desc = 'Find tabs' })
vim.keymap.set('n', '<leader>lw', builtin.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = 'Workspace symbols' })

vim.keymap.set('n', '<leader>rg', function()
    telescope.extensions.live_grep_args.live_grep_args({
        prompt_title = 'Find files (rg)',
    })
end, { desc = 'Telescope live grep' })


vim.keymap.set('n', '<leader>lr', function()
    builtin.lsp_references({
        show_line = false,
        include_declaration = true,
        jump_type = 'auto',
    })
end, { buffer = bufnr, desc = 'References' })
