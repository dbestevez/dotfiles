return function(context)
    if not context.lang:find('php', 1, true) then
        return {}
    end

    return {
        {
            prefix = 'class',
            desc = 'Class',
            body = [[<?php

declare(strict_types=1);

namespace ${1:namespace};

class ${2:class}
{
    ${3}
}$0]],
        },

        {
            prefix = 'vdie',
            desc = 'Dump and die',
            body = [[var_dump(${1:this});
die();$0]],
        },

        {
            prefix = 'v',
            desc = 'Dump',
            body = [[var_dump(${1:this});$0]],
        },

        {
            prefix = 'fdoc',
            desc = 'Function doc',
            body = [[/**
 * ${1:description}
 *
 * @param ${2:type} ${3:variable} ${4:Description}
 *
 * @return ${5:type} ${6:Description}
 */
$0]],
        },

        {
            prefix = '@in',
            desc = 'Inherit',
            body = [[/**
 * {@inheritdoc}
 */$0]],
        },

        {
            prefix = 'test',
            desc = 'PHP test',
            body = [[<?php

declare(strict_types=1);

namespace ${1:namespace};

use $1\\${2:class};
use PHPUnit\Framework\TestCase;

/**
 * Defines test cases for $2 class.
 */
class ${2}Test extends TestCase
{
    /**
     * {@inheritdoc}
     */
    public function setUp(): void
    {

    }
}
$0]],
        },

        {
            prefix = 'svdie',
            desc = 'Rich Dump and die',
            body = [[\Symfony\Component\VarDumper\VarDumper::dump(${1:this});
die();$0]],
        },

        {
            prefix = 'sv',
            desc = 'Rich Dump',
            body = [[\Symfony\Component\VarDumper\VarDumper::dump(${1:this});$0]],
        },

        {
            prefix = 'vdoc',
            desc = 'Variable doc',
            body = [[/**
 * ${1:description}
 *
 * @var ${2:type}
 */$0]],
        },
    }
end
