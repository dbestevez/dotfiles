local builtin      = require('telescope.builtin')
local actions      = require('telescope.actions')
local action_state = require('telescope.actions.state')
local lga_actions  = require("telescope-live-grep-args.actions")
local telescope    = require('telescope')

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
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = lga_actions.to_fuzzy_refine,
        },
      },
    }
})

telescope.load_extension('live_grep_args')

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>lb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set("n", "<leader>lg", telescope.extensions.live_grep_args.live_grep_args, { desc = 'Telescope live grep' })
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
