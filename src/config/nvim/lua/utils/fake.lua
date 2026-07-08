local M = {}

local function gen(name)
    return vim.fn['fake#gen'](name)
end

local function int(...)
    return vim.fn['fake#int'](...)
end

local function chars(...)
    return vim.fn['fake#chars'](...)
end

local function choice(list)
    return list[int(0, #list - 1) + 1]
end

local function words(min, max)
    local out = {}

    for _ = 1, int(min, max) do
        out[#out + 1] = gen('nonsense')
    end

    return table.concat(out, ' ')
end

M.age = function()
    return tostring(math.floor(110 * vim.fn['fake#betapdf'](1.0, 1.45)))
end

M.sex = function()
    return choice({ 'male', 'female' })
end

M.name = function()
    return int(1) == 1 and gen('male_name') or gen('female_name')
end

M.fullname = function()
    return M.name() .. ' ' .. gen('surname')
end

M.tld = function()
    return vim.fn['fake#get'](vim.fn['fake#load']('gtld'), vim.fn['fake#betapdf'](0.2, 3.0))
end

M.domain = function()
    return (gen('surname') .. '.' .. M.tld()):lower():gsub('%s+', '-')
end

M.email = function()
    return (M.name() .. '@' .. gen('surname') .. '.' .. M.tld()):lower():gsub('%s+', '-')
end

M.sentence = function()
    return vim.fn['fake#capitalize'](words(3, 15)) .. chars(1, '..............!?')
end

M.paragraph = function()
    local out = {}

    for _ = 1, int(3, 10) do
        out[#out + 1] = M.sentence()
    end

    return table.concat(out, ' ')
end

M.text = function()
    local out = {}

    for _ = 1, int(3, 6) do
        out[#out + 1] = M.paragraph()
    end

    return table.concat(out, '--')
end

return M
