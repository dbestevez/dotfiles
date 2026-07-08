return function(context)
    if not context.lang:find('twig', 1, true) then
        return {}
    end

    return {
        {
            prefix = 'v',
            desc = 'Dump',
            body = [[<pre>{var_dump(${1:params})}</pre>]]
        }
    }
end
