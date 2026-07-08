local function hl(fg, bg, attrs)
  local opts = {}

  if fg then
    opts.fg = fg[1]
    opts.ctermfg = fg[2]
  end

  if bg then
    opts.bg = bg[1]
    opts.ctermbg = bg[2]
  end

  if attrs and attrs ~= 'NONE' then
    for attr in attrs:gmatch('%S+') do
      opts[attr] = true
    end
  end

  return opts
end

return function(p)
  return {

    -- Editor
    Cursor                         = hl(nil, p.color24),
    CursorLine                     = hl(nil, p.color0),
    CursorLineNR                   = hl(p.color15, p.color0),
    LineNr                         = hl(p.color18, nil),
    multiple_cursors_cursor        = hl(nil, p.color11),
    Normal                         = hl(p.color15, nil),

    -- Number column
    CursorColumn                   = hl(nil, p.color5),
    FoldColumn                     = hl(p.color6, nil),
    SignColumn                     = hl(p.color6, nil),

    -- Delimiter
    ColorColumn                    = hl(nil, p.color17),
    VertSplit                      = hl(p.color0, p.color16),
    TabLine                        = hl(nil, nil),
    TabLineFill                    = hl(nil, nil),
    TabLineSel                     = hl(nil, nil),

    -- Fillchars
    WinSeparator                   = hl(p.color17, nil),
    Folded                         = hl(p.color30, nil),
    EndOfBuffer                    = hl(p.color18, nil),

    -- File Navigation/Searching
    CurSearch                      = hl(p.color24, p.color18, 'underline'),
    Directory                      = hl(p.color11, nil),
    IncSearch                      = hl(p.color24, p.color18),
    Search                         = hl(p.color24, p.color18),

    -- Completion menu
    Pmenu                          = hl(nil, p.color0),
    PmenuSel                       = hl(nil, p.color6),

    -- Status
    StatusLine                     = hl(p.color15, p.color0),
    StatusLineNC                   = hl(nil, p.color0),
    Title                          = hl(p.color9, nil),

    -- Visual aid
    MatchParen                     = hl(p.color9, nil),
    NonText                        = hl(p.color4, p.color16),
    Visual                         = hl(p.color24, p.color18),
    Todo                           = hl(p.color4, nil),
    Underlined                     = hl(nil, nil, 'underline'),
    Error                          = hl(nil, p.color9),
    ErrorMsg                       = hl(nil, p.color9),
    WarningMsg                     = hl(p.color11, nil),
    SpecialKey                     = hl(p.color11, p.color8),

    -- Diff
    DiffAdd                        = hl(p.color10, nil),
    DiffDelete                     = hl(p.color9, nil),
    DiffChange                     = hl(p.color3, nil),
    DiffText                       = hl(p.color3, p.color8),

    -- Types
    Boolean                        = hl(p.color4, nil),
    Character                      = hl(p.color2, nil),
    Constant                       = hl(p.color5, nil, 'italic'),
    Float                          = hl(p.color5, nil),
    Function                       = hl(p.color6, nil),
    Identifier                     = hl(p.color15, nil),
    Number                         = hl(p.color5, nil),
    String                         = hl(p.color3, nil),

    -- Language constructs
    Comment                        = hl(p.color30, nil),
    Conditional                    = hl(p.color12, nil),
    Debug                          = hl(p.color4, nil),
    Delimiter                      = hl(p.color15, nil),
    Exception                      = hl(p.color4, nil),
    Keyword                        = hl(p.color4, nil),
    Noise                          = hl(p.color20, nil),
    Label                          = hl(p.color11, nil),
    Operator                       = hl(p.color13, nil),
    Repeat                         = hl(p.color4, nil),
    Special                        = hl(p.color11, nil),
    SpecialChar                    = hl(p.color24, nil, 'bold'),
    SpecialComment                 = hl(p.color4, nil),
    Statement                      = hl(p.color4, nil),
    Tag                            = hl(p.color11, nil),

    -- Neomake
    NeomakeWarning                 = hl(p.color11, p.color16),
    NeomakeError                   = hl(p.color9, p.color16),
    NeomakeInfo                    = hl(p.color4, p.color16),

    -- C like
    Define                         = hl(p.color5, nil),
    Include                        = hl(p.color6, nil),
    Macro                          = hl(p.color5, nil),
    PreCondit                      = hl(p.color5, nil),
    PreProc                        = hl(p.color4, nil),
    StorageClass                   = hl(p.color14, nil),
    Type                           = hl(p.color4, nil),
    Typedef                        = hl(p.color11, nil),

    -- CSS
    cssClassName                   = hl(p.color6, nil),
    cssClassNameDot                = hl(p.color6, nil),
    cssValueName                   = hl(p.color5, nil),
    cssValueNumber                 = hl(p.color5, nil),
    cssValueLength                 = hl(p.color5, nil),
    cssVendor                      = hl(p.color4, nil),
    cssFunctionName                = hl(p.color5, nil),
    cssUnitDecorators              = hl(p.color3, nil),
    cssCommonAttr                  = hl(p.color4, nil),
    cssAttrRegion                  = hl(p.color4, nil),
    cssAttrComma                   = hl(p.color15, nil),
    cssNoise                       = hl(p.color4, nil),
    cssColor                       = hl(p.color5, nil),
    cssPseudoClassFn               = hl(p.color6, nil),
    cssPseudoClassId               = hl(p.color6, nil),
    cssSelectorOp                  = hl(p.color15, nil),

    -- HTML
    htmlTag                        = hl(p.color4, nil),
    htmlTagName                    = hl(p.color4, nil),
    htmlArg                        = hl(p.color14, nil),

    -- Javascript
    jsFunction                     = hl(p.color11, nil),
    jsFuncCall                     = hl(p.color2, nil),
    jsObjectProp                   = hl(p.color13, nil),
    jsThis                         = hl(p.color1, nil),
    jsNull                         = hl(p.color9, nil),

    -- PHP
    phpClass                       = hl(p.color14, nil),
    phpClassNamespaceSeparator     = hl(p.color13, nil),
    phpClasses                     = hl(p.color14, nil),
    phpComment                     = hl(p.color19, nil),
    phpConstants                   = hl(p.color9, nil, 'italic'),
    phpControlStructure            = hl(p.color10, nil),
    phpDocComment                  = hl(p.color19, nil),
    phpDocIdentifier               = hl(p.color19, nil, 'italic'),
    phpDocParam                    = hl(p.color19, nil, 'italic'),
    phpDocTags                     = hl(p.color19, nil),
    phpFunction                    = hl(p.color10, nil),
    phpInclude                     = hl(p.color13, nil, 'bold'),
    phpFunctions                   = hl(p.color14, nil),
    phpKeyword                     = hl(p.color13, nil),
    phpKeywords                    = hl(p.color15, nil),
    phpMethod                      = hl(p.color10, nil),
    phpMethodsVar                  = hl(p.color15, nil),
    phpNew                         = hl(p.color13, nil, 'bold'),
    phpNewObject                   = hl(p.color14, nil),
    phpOperator                    = hl(p.color13, nil),
    phpParent                      = hl(p.color15, nil),
    phpStructureKeyword            = hl(p.color10, nil),
    phpTryCatch                    = hl(p.color6, nil),
    phpTryCatchedException         = hl(p.color9, nil),
    phpTryFinally                  = hl(p.color9, nil),
    phpTryStart                    = hl(p.color9, nil),
    phpType                        = hl(p.color12, nil, 'italic'),
    phpUseNamespaceSeparator       = hl(p.color13, nil),
    phpVarSelector                 = hl(p.color13, nil, 'bold'),
    phpVariable                    = hl(p.color12, nil),

    -- YAML
    yamlConstant                   = hl(p.color9, nil),
    yamlBlockMappingKey            = hl(p.color14, nil),
    yamlFlowMappingKey             = hl(p.color14, nil),
    yamlKeyValueDelimiter          = hl(p.color15, nil),
    yamlFlowIndicator              = hl(p.color15, nil),
    yamlBlockCollectionItemStart   = hl(p.color15, nil),

    -- Statusline
    MiniStatuslineCommand          = hl(p.color0, p.color6, 'bold'),
    MiniStatuslineInsert           = hl(p.color0, p.color2, 'bold'),
    MiniStatuslineNormal           = hl(p.color0, p.color5, 'bold'),
    MiniStatuslineReplace          = hl(p.color0, p.color1, 'bold'),
    MiniStatuslineVisual           = hl(p.color0, p.color11, 'bold'),
    MiniStatuslineHighlightCommand = hl(p.color6, p.color18, 'bold'),
    MiniStatuslineHighlightInsert  = hl(p.color2, p.color18, 'bold'),
    MiniStatuslineHighlightNormal  = hl(p.color5, p.color18, 'bold'),
    MiniStatuslineHighlightReplace = hl(p.color1, p.color18, 'bold'),
    MiniStatuslineHighlightVisual  = hl(p.color11, p.color18, 'bold'),
    MiniStatuslineTextCommand      = hl(p.color6, p.color17, 'bold'),
    MiniStatuslineTextInsert       = hl(p.color2, p.color17, 'bold'),
    MiniStatuslineTextNormal       = hl(p.color5, p.color17, 'bold'),
    MiniStatuslineTextReplace      = hl(p.color1, p.color17, 'bold'),
    MiniStatuslineTextVisual       = hl(p.color11, p.color17, 'bold'),

    -- Tabline
    TabLineSel                     = hl(p.color5, p.color18, 'bold'),
    TabLine                        = hl(p.color19, p.color17),
    TabLineFill                    = hl(p.color18, p.color17),
    MiniTablineModifiedCurrent     = hl(p.color24, p.color13, 'bold'),
    MiniTablineModifiedVisible     = hl(p.color15, p.color0),
    MiniTablineModifiedHidden      = hl(p.color18, nil),
    MiniTablineFill                = hl(nil, p.color0),

    -- Diagnostics
    NormalFloat                    = hl(p.color15, p.color0),
    FloatBorder                    = hl(p.color18, p.color0),
    FloatTitle                     = hl(p.color13, p.color0, 'bold'),
    DiagnosticFloatingError        = hl(p.color9, nil),
    DiagnosticFloatingWarn         = hl(p.color11, nil),
    DiagnosticFloatingInfo         = hl(p.color4, nil),
    DiagnosticFloatingHint         = hl(p.color6, nil),
    DiagnosticFloatingOk           = hl(p.color10, nil),
    DiagnosticSignError            = hl(p.color9, nil),
    DiagnosticSignWarn             = hl(p.color11, nil),
    DiagnosticSignInfo             = hl(p.color4, nil),
    DiagnosticSignHint      = hl(p.color6, nil),
  }
end
