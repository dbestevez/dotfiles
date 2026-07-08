let g:indentLine_setColors  = 1
let g:indentLine_color_term = 8

set fillchars+=vert:\▎
set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "flat"

" Editor
call Themer("Cursor",                       g:none,    g:color24, "NONE")
call Themer("CursorLine",                   g:none,    g:color0,  "NONE")
call Themer("CursorLineNR",                 g:color15, g:color0,  "NONE")
call Themer("LineNr",                       g:color18, g:none,    "NONE")
call Themer("multiple_cursors_cursor",      g:none,    g:color11, "NONE")
call Themer("Normal",                       g:color15, g:none,    "NONE")

" Number column
call Themer("CursorColumn",                 g:none,    g:color5,  "NONE")
call Themer("FoldColumn",                   g:color6,  g:none,    "NONE")
call Themer("Folded",                       g:color6,  g:none,    "NONE")
call Themer("SignColumn",                   g:color6,  g:none,    "NONE")

" Delimiter
call Themer("ColorColumn",                  g:none,    g:color17, "NONE")
call Themer("VertSplit",                    g:color0,  g:color16, "NONE")
call Themer("TabLine",                      g:none,    g:none,    "NONE")
call Themer("TabLineFill",                  g:none,    g:none,    "NONE")
call Themer("TabLineSel",                   g:none,    g:none,    "NONE")

" Fillchars
call Themer("WinSeparator",                 g:color17, g:none,    "NONE")
call Themer("Folded",                       g:color30, g:none,    "NONE")
call Themer("EndOfBuffer",                  g:color18, g:none,    "NONE")

" File Navigation/Searching
call Themer("CurSearch",                    g:color24, g:color18, "underline")
call Themer("Directory",                    g:color11, g:none,    "NONE")
call Themer("IncSearch",                    g:color24, g:color18, "NONE")
call Themer("Search",                       g:color24, g:color18, "NONE")

" Completion menu
call Themer("Pmenu",                        g:none,    g:color0,  "NONE")
call Themer("PmenuSel",                     g:none,    g:color6,  "NONE")

" Status
call Themer("StatusLine",                   g:color15, g:color0,  "NONE")
call Themer("StatusLineNC",                 g:none,    g:color0,  "NONE")
call Themer("Title",                        g:color9,  g:none,    "NONE")

" Visual aid
call Themer("MatchParen",                   g:color9,  g:none,    "NONE")
call Themer("NonText",                      g:color4,  g:color16, "NONE")
call Themer("Visual",                       g:color24, g:color18, "NONE")
call Themer("Todo",                         g:color4,  g:none,    "NONE")
call Themer("Underlined",                   g:none,    g:none,    "underline")
call Themer("Error",                        g:none,    g:color9,  "NONE")
call Themer("ErrorMsg",                     g:none,    g:color9,  "NONE")
call Themer("WarningMsg",                   g:color11, g:none,    "NONE")
call Themer("SpecialKey",                   g:color11, g:color8,  "NONE")

" Diff
call Themer("DiffAdd",                      g:color10, g:none,    "NONE")
call Themer("DiffDelete",                   g:color9,  g:none,    "NONE")
call Themer("DiffChange",                   g:color3,  g:none,    "NONE")
call Themer("DiffText",                     g:color3,  g:color8,  "NONE")

" Types
call Themer("Boolean",                      g:color4,  g:none,    "NONE")
call Themer("Character",                    g:color2,  g:none,    "NONE")
call Themer("Constant",                     g:color5,  g:none,    "italic")
call Themer("Float",                        g:color5,  g:none,    "NONE")
call Themer("Function",                     g:color6,  g:none,    "NONE")
call Themer("Identifier",                   g:color15, g:none,    "NONE")
call Themer("Number",                       g:color5,  g:none,    "NONE")
call Themer("String",                       g:color3,  g:none,    "NONE")

" Language constructs
call Themer("Comment",                      g:color30, g:none,    "NONE")
call Themer("Conditional",                  g:color12, g:none,    "NONE")
call Themer("Debug",                        g:color4,  g:none,    "NONE")
call Themer("Delimiter",                    g:color15, g:none,    "NONE")
call Themer("Exception",                    g:color4,  g:none,    "NONE")
call Themer("Keyword",                      g:color4,  g:none,    "NONE")
call Themer("Noise",                        g:color20, g:none,    "NONE")
call Themer("Label",                        g:color11, g:none,    "NONE")
call Themer("Operator",                     g:color13, g:none,    "NONE")
call Themer("Repeat",                       g:color4,  g:none,    "NONE")
call Themer("Special",                      g:color11, g:none,    "NONE")
call Themer("SpecialChar",                  g:color24, g:none,    "bold")
call Themer("SpecialComment",               g:color4,  g:none,    "NONE")
call Themer("Statement",                    g:color4,  g:none,    "NONE")
call Themer("Tag",                          g:color11, g:none,    "NONE")

" Neomake
call Themer("NeomakeWarning",               g:color11, g:color16, "NONE")
call Themer("NeomakeError",                 g:color9,  g:color16, "NONE")
call Themer("NeomakeInfo",                  g:color4,  g:color16, "NONE")

" C like
call Themer("Define",                       g:color5,  g:none,    "NONE")
call Themer("Include",                      g:color6,  g:none,    "NONE")
call Themer("Macro",                        g:color5,  g:none,    "NONE")
call Themer("PreCondit",                    g:color5,  g:none,    "NONE")
call Themer("PreProc",                      g:color4,  g:none,    "NONE")
call Themer("StorageClass",                 g:color14, g:none,    "NONE")
call Themer("Type",                         g:color4,  g:none,    "NONE")
call Themer("Typedef",                      g:color11, g:none,    "NONE")

" CSS
call Themer("cssClassName",                 g:color6,  g:none,    "NONE")
call Themer("cssClassNameDot",              g:color6,  g:none,    "NONE")
call Themer("cssValueName",                 g:color5,  g:none,    "NONE")
call Themer("cssValueNumber",               g:color5,  g:none,    "NONE")
call Themer("cssValueLength",               g:color5,  g:none,    "NONE")
call Themer("cssVendor",                    g:color4,  g:none,    "NONE")
call Themer("cssFunctionName",              g:color5,  g:none,    "NONE")
call Themer("cssUnitDecorators",            g:color3,  g:none,    "NONE")
call Themer("cssCommonAttr",                g:color4,  g:none,    "NONE")
call Themer("cssAttrRegion",                g:color4,  g:none,    "NONE")
call Themer("cssAttrComma",                 g:color15, g:none,    "NONE")
call Themer("cssNoise",                     g:color4,  g:none,    "NONE")
call Themer("cssColor",                     g:color5,  g:none,    "NONE")
call Themer("cssPseudoClassFn",             g:color6,  g:none,    "NONE")
call Themer("cssPseudoClassId",             g:color6,  g:none,    "NONE")
call Themer("cssSelectorOp",                g:color15, g:none,    "NONE")

" HTML
call Themer("htmlTag",                      g:color4,  g:none,    "NONE")
call Themer("htmlTagName",                  g:color4,  g:none,    "NONE")
call Themer("htmlArg",                      g:color14, g:none,    "NONE")

" Javascript
call Themer("jsFunction",                   g:color11, g:none,    "NONE")
call Themer("jsFuncCall",                   g:color2,  g:none,    "NONE")
call Themer("jsObjectProp",                 g:color13, g:none,    "NONE")
call Themer("jsThis",                       g:color1,  g:none,    "NONE")
call Themer("jsNull",                       g:color9,  g:none,    "NONE")

" PHP
call Themer("phpClass",                     g:color14, g:none,    "NONE")
call Themer("phpClassNamespaceSeparator",   g:color13, g:none,    "NONE")
call Themer("phpClasses",                   g:color14, g:none,    "NONE")
call Themer("phpComment",                   g:color19, g:none,    "NONE")
call Themer("phpConstants",                 g:color9,  g:none,    "italic")
call Themer("phpControlStructure",          g:color10, g:none,    "NONE")
call Themer("phpDocComment",                g:color19, g:none,    "NONE")
call Themer("phpDocIdentifier",             g:color19, g:none,    "italic")
call Themer("phpDocParam",                  g:color19, g:none,    "italic")
call Themer("phpDocTags",                   g:color19, g:none,    "NONE")
call Themer("phpFunction",                  g:color10, g:none,    "NONE")
call Themer("phpInclude",                   g:color13, g:none,    "bold")
call Themer("phpFunctions",                 g:color14, g:none,    "NONE")
call Themer("phpKeyword",                   g:color13, g:none,    "NONE")
call Themer("phpKeywords",                  g:color15, g:none,    "NONE")
call Themer("phpMethod",                    g:color10, g:none,    "NONE")
call Themer("phpMethodsVar",                g:color15, g:none,    "NONE")
call Themer("phpNew",                       g:color13, g:none,    "bold")
call Themer("phpNewObject",                 g:color14, g:none,    "NONE")
call Themer("phpOperator",                  g:color13, g:none,    "NONE")
call Themer("phpParent",                    g:color15, g:none,    "NONE")
call Themer("phpStructureKeyword",          g:color10, g:none,    "NONE")
call Themer("phpTryCatch",                  g:color6,  g:none,    "NONE")
call Themer("phpTryCatchedException",       g:color9,  g:none,    "NONE")
call Themer("phpTryFinally",                g:color9,  g:none,    "NONE")
call Themer("phpTryStart",                  g:color9,  g:none,    "NONE")
call Themer("phpType",                      g:color12, g:none,    "italic")
call Themer("phpUseNamespaceSeparator",     g:color13, g:none,    "NONE")
call Themer("phpVarSelector",               g:color13, g:none,    "bold")
call Themer("phpVariable",                  g:color12, g:none,    "NONE")

" YAML
call Themer("yamlConstant",                 g:color9,  g:none,    "NONE")
call Themer("yamlBlockMappingKey",          g:color14, g:none,    "NONE")
call Themer("yamlFlowMappingKey",           g:color14, g:none,    "NONE")
call Themer("yamlKeyValueDelimiter",        g:color15, g:none,    "NONE")
call Themer("yamlFlowIndicator",            g:color15, g:none,    "NONE")
call Themer("yamlBlockCollectionItemStart", g:color15, g:none,    "NONE")
