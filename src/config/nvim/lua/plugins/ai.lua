local ai = require('mini.ai')

local function php_function(ai_type)
    return function()
        local parser = vim.treesitter.get_parser(0, 'php')
        local tree = parser:parse()[1]
        local root = tree:root()

        local query = vim.treesitter.query.parse('php', [[
            (function_definition) @function.outer
            (method_declaration) @function.outer

            (function_definition
              body: (_) @function.inner)

            (method_declaration
              body: (_) @function.inner)
        ]])

        local capture = ai_type == 'a' and 'function.outer' or 'function.inner'
        local regions = {}

        for id, node in query:iter_captures(root, 0, 0, -1) do
            if query.captures[id] == capture then
                local sr, sc, er, ec = node:range()

                table.insert(regions, {
                    from = { line = sr + 1, col = sc + 1 },
                    to = { line = er + 1, col = ec },
                })
            end
        end

        return regions
    end
end

ai.setup({
    n_lines = 500,
    custom_textobjects = {
        F = function(ai_type)
            return php_function(ai_type)()
        end,
    },
})
