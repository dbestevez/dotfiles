local hop = require('hop')

hop.setup({
  keys = 'etovxqpdygfblzhckisuran',
})

local directions = require('hop.hint').HintDirection

vim.keymap.set('', 's', function()
  hop.hint_char1()
end, {remap=true})
