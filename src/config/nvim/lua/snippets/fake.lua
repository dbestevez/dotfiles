local fake = require('utils.fake')

local function gen(name)
    return vim.fn['fake#gen'](name)
end

local function wrap(text, width)
    width = width or 70
    return vim.fn.substitute(text, '\\v(.{' .. width .. '}\\S*)\\s+', '\\1\n', 'g')
end

return function()
    return {
        { prefix = 'date', body = os.date('%Y-%m-%d %H:%M:%S'), desc = 'current date' },

        { prefix = 'fkage', body = fake.age(), desc = 'fake age' },
        { prefix = 'fkcountry', body = gen('country'), desc = 'fake country' },
        { prefix = 'fkdomain', body = fake.domain(), desc = 'fake domain' },
        { prefix = 'fkemail', body = fake.email(), desc = 'fake email' },

        {
            prefix = 'fkfloat',
            body = string.format('%.4f', vim.fn['fake#float']()),
            desc = 'fake float',
        },

        { prefix = 'fkfoo', body = gen('foobar'), desc = 'fake foobar' },
        { prefix = 'fkfullname', body = fake.fullname(), desc = 'fake full name' },

        {
            prefix = 'fkint',
            body = tostring(vim.fn['fake#int']()),
            desc = 'fake int',
        },

        { prefix = 'fkjob', body = gen('job'), desc = 'fake job' },
        { prefix = 'fkname', body = fake.name(), desc = 'fake name' },

        {
            prefix = 'fkparagraph',
            body = wrap(fake.paragraph()),
            desc = 'fake paragraph',
        },

        {
            prefix = 'fkpassword',
            body = vim.fn['fake#chars'](8),
            desc = 'fake password',
        },

        { prefix = 'fksentence', body = fake.sentence(), desc = 'fake sentence' },
        { prefix = 'fksex', body = fake.sex(), desc = 'fake sex' },

        {
            prefix = 'fksint',
            body = tostring(vim.fn['fake#int'](0, 1000)),
            desc = 'fake small int',
        },

        { prefix = 'fkuser', body = fake.name():lower(), desc = 'fake username' },

        {
            prefix = 'fktext',
            body = wrap(fake.text()):gsub('%-%-', '\n\n'),
            desc = 'fake text',
        },

        { prefix = 'fkword', body = gen('word'), desc = 'fake word' },
    }
end
