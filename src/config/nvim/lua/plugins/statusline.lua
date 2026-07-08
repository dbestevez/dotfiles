local statusline = require('mini.statusline')

local function current_mode_name()
    local mode = vim.fn.mode(1)

    if mode == 'n' then return 'Normal' end
    if mode == 'i' then return 'Insert' end
    if mode == 'v' or mode == 'V' or mode == '\22' then return 'Visual' end
    if mode == 'R' then return 'Replace' end
    if mode == 'c' then return 'Command' end

    return 'Normal'
end

local function diagnostics(severity)
    local severities = vim.diagnostic.severity
    local errors     = #vim.diagnostic.get(0, { severity = severity })

    if errors > 0 then
        return vim.diagnostic.severity[severity]:sub(1, 1) .. ':' .. errors
    end

    return ''
end

local function location()
    local pos = vim.api.nvim_win_get_cursor(0)
    return string.format('%d:%d', pos[1], pos[2] + 1)
end

local function is_special_file()
    local name = vim.fn.expand('%:t')
    local ft = vim.bo.filetype

    return name:match('NERD_tree')
        or ft == 'vimfiler'
        or ft == 'TelescopePrompt'
end

local function mode_icon()
    local mode = vim.fn.mode(1)
    local name = vim.fn.expand('%:t')

    if name == '__Tagbar__' then return '' end
    if name == '__Gundo__' or name == '__Gundo_Preview__' then return '' end
    if name:match('NERD_tree') then return '󰙅' end

    local icons = {
        n = '',
        i = '󰏫',
        R = '',
        c = '',
        v = '󰫙',
        V = '󰫙',
        ['\22'] = '󰿚', -- Ctrl-V / visual block
    }

    return icons[mode] or mode
end

local function paste_icon()
    return vim.o.paste and '' or ''
end

local function readonly_icon()
    if vim.bo.filetype ~= 'help' and vim.bo.readonly then
        return ''
    end

    return ''
end

local function modified_icon()
    if vim.bo.filetype == 'help' then
        return ''
    end

    if vim.bo.modified then
        return '+'
    end

    if not vim.bo.modifiable then
        return '-'
    end

    return ''
end

local function filename()
    if is_special_file() then
        return ''
    end

    local short_name = vim.fn.expand('%:t')
    local full_name = vim.fn.expand('%:~:.')

    local name = full_name ~= '' and full_name or '[No Name]'

    if vim.api.nvim_win_get_width(0) <= 100 then
        name = short_name ~= '' and short_name or '[No Name]'
    end

    local icon = ''
    local ok_devicons, devicons = pcall(require, 'nvim-web-devicons')
    if ok_devicons and short_name ~= '' then
        local file_icon = devicons.get_icon(short_name, vim.fn.expand('%:e'), { default = true })
        icon = file_icon and (file_icon .. ' ') or ''
    end

    return table.concat({
        icon,
        name,
        readonly_icon() ~= '' and (' ' .. readonly_icon()) or '',
        modified_icon() ~= '' and (' ' .. modified_icon()) or '',
    })
end

local function git_branch()
    if is_special_file() then
        return ''
    end

    local branch = vim.b.gitsigns_head
    if branch and branch ~= '' and branch ~= 'master' then
        return '󰊢 ' .. branch
    end

    return '󰊢'
end

local function debug_status()
    if vim.g.debug and vim.g.debug ~= 0 then
        return ' ' .. tostring(vim.g.debug):gsub('\n', '')
    end

    return ''
end

statusline.setup({
    content = {
        active = function()
            local mode = current_mode_name()
            local _, mode_hl = statusline.section_mode({ trunc_width = 120 })
            --local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local location = location()
            local percent = '%2p%%'
            local severities = vim.diagnostic.severity

            return statusline.combine_groups({
                { hl = 'MiniStatusLine' .. mode, strings = { mode_icon(), paste_icon() } },
                { hl = 'MiniStatuslineHighlight' .. mode, strings = { git_branch() } },
                { hl = 'MiniStatuslineText' .. mode, strings = { filename() } },
                '%=',
                { hl = 'MiniStatuslineTextReplace', strings = { diagnostics(severities.ERROR) } },
                { hl = 'MiniStatuslineTextVisual', strings = { diagnostics(severities.WARN) } },
                { hl = 'MiniStatuslineTextInsert', strings = { diagnostics(severities.HINT) } },
                { hl = 'MiniStatuslineTextCommand', strings = { diagnostics(severities.INFO) } },
                { hl = 'MiniStatuslineText' .. mode, strings = { percent } },
                { hl = 'MiniStatuslineHighlight' .. mode, strings = { location } },
            })
        end,

        inactive = function()
            return statusline.combine_groups({
                { hl = 'MiniStatuslineInactive', strings = { filename() } },
            })
        end,
    },
})
