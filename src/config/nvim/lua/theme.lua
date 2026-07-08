local palette = require('theme.colors')
local highlights = require('theme.highlights')(palette)

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end
