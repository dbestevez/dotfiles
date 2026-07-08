local M = {}

function M.whitespaces()
    vim.cmd([[%s/\s\+$//e]])
end

return M
