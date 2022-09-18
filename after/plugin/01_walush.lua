local lush = L "lush"
if not lush then
  return
end
local hsl = lush.hsl

-- set font for gui mode
vim.opt.guifont = "Inconsolata Nerd Font Mono:h14"

local function get_xresources_color(color_name)
  local command = io.popen("xrdb -query | grep " .. color_name .. " -m 1 | cut -f 2")
  local color = nil
  if command then
    color = command:read "*l"
  end
  return color
end

local xres = {
  fg = get_xresources_color "foreground" or "#c5c8c6",
  bg = get_xresources_color "background" or "#1d1f21",
  color0 = get_xresources_color "color0" or "#282a2e",
  color1 = get_xresources_color "color1" or "#a54242",
  color2 = get_xresources_color "color2" or "#8c9440",
  color3 = get_xresources_color "color3" or "#de935f",
  color4 = get_xresources_color "color4" or "#5f819d",
  color5 = get_xresources_color "color5" or "#85678f",
  color6 = get_xresources_color "color6" or "#5e8d87",
  color7 = get_xresources_color "color7" or "#707880",
  color8 = get_xresources_color "color8" or "#373b41",
  color9 = get_xresources_color "color9" or "#cc6666",
  color10 = get_xresources_color "color10" or "#b5bd68",
  color11 = get_xresources_color "color11" or "#f0c674",
  color12 = get_xresources_color "color12" or "#81a2be",
  color13 = get_xresources_color "color13" or "#b294bb",
  color14 = get_xresources_color "color14" or "#8abeb7",
  color15 = get_xresources_color "color15" or "#c5c8c6",
}

for name, color in pairs(xres) do
  xres[name] = hsl(color)
end
xres.none = "NONE"

local walush = lush(function()
  return {

    -- git
    DiffAdd { fg = xres.color15, bg = hsl "#002800" }, -- DiffAdd    xxx ctermfg=0 ctermbg=4 guibg=DarkBlue
    DiffChange { DiffAdd }, -- DiffChange xxx ctermfg=0 ctermbg=5 guibg=DarkMagenta
    DiffDelete { fg = xres.color15, bg = hsl "#3f0001" }, -- DiffDelete xxx ctermfg=0 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
    DiffText { fg = DiffChange.fg, bg = hsl "#006000", gui = "bold" }, -- DiffText   xxx cterm=bold ctermfg=0 ctermbg=9 gui=bold guibg=Red

    -- Diagnostics
    DiagnosticError { fg = DiffDelete.bg.lighten(35) }, -- DiagnosticError            xxx ctermfg=1 guifg=Red
    DiagnosticWarn { fg = DiagnosticError.fg.ro(50) }, -- DiagnosticWarn             xxx ctermfg=3 guifg=Orange
    DiagnosticWarning { DiagnosticWarn },
    DiagnosticInfo { fg = xres.color15, bg = xres.bg.lighten(15) }, -- DiagnosticInfo             xxx ctermfg=4 guifg=LightBlue
    DiagnosticHint { fg = xres.color7 }, -- DiagnosticHint             xxx ctermfg=7 guifg=LightGrey
    DiagnosticUnderlineError { fg = DiagnosticError.fg, gui = "underline" }, -- DiagnosticUnderlineError   xxx cterm=underline gui=underline guisp=Red
    DiagnosticUnderlineWarn { fg = DiagnosticWarn.fg, gui = "underline" }, -- DiagnosticUnderlineWarn    xxx cterm=underline gui=underline guisp=Orange
    DiagnosticUnderlineInfo { fg = DiagnosticInfo.fg, gui = "underline" }, -- DiagnosticUnderlineInfo    xxx cterm=underline gui=underline guisp=LightBlue
    DiagnosticUnderlineHint { fg = DiagnosticHint.fg, gui = "underline" }, -- DiagnosticUnderlineHint    xxx cterm=underline gui=underline guisp=LightGrey
    DiagnosticVirtualTextError { DiagnosticError }, -- DiagnosticVirtualTextError xxx links to DiagnosticError
    DiagnosticVirtualTextWarn { DiagnosticWarn }, -- DiagnosticVirtualTextWarn  xxx links to DiagnosticWarn
    DiagnosticVirtualTextInfo { DiagnosticInfo }, -- DiagnosticVirtualTextInfo  xxx links to DiagnosticInfo
    DiagnosticVirtualTextHint { DiagnosticHint }, -- DiagnosticVirtualTextHint  xxx links to DiagnosticHint
    DiagnosticFloatingError { DiagnosticError }, -- DiagnosticFloatingError    xxx links to DiagnosticError
    DiagnosticFloatingWarn { DiagnosticWarn }, -- DiagnosticFloatingWarn     xxx links to DiagnosticWarn
    DiagnosticFloatingInfo { DiagnosticInfo }, -- DiagnosticFloatingInfo     xxx links to DiagnosticInfo
    DiagnosticFloatingHint { DiagnosticHint }, -- DiagnosticFloatingHint     xxx links to DiagnosticHint
    DiagnosticSignError { DiagnosticError }, -- DiagnosticSignError        xxx links to DiagnosticError
    DiagnosticSignWarn { DiagnosticWarn }, -- DiagnosticSignWarn         xxx links to DiagnosticWarn
    DiagnosticSignInfo { DiagnosticInfo }, -- DiagnosticSignInfo         xxx links to DiagnosticInfo
    DiagnosticSignHint { DiagnosticHint }, -- DiagnosticSignHint         xxx links to DiagnosticHint

    -- General
    SpecialKey { fg = xres.color13, bg = xres.color0 },
    TermCursor { gui = "reverse" },
    NonText { fg = xres.color12, bg = xres.bg },
    EndOfBuffer { NonText },
    Directory { fg = xres.color11, bg = xres.bg },
    ErrorMsg { fg = xres.color0, bg = xres.color9 },
    Search { fg = xres.color0, bg = xres.color12 },
    MoreMsg { fg = xres.color15, bg = xres.bg },
    ModeMsg { fg = xres.none, bg = xres.none, gui = "bold" },
    LineNr { fg = xres.color7, bg = xres.color0 },
    LineNrAbove { LineNr },
    LineNrBelow { LineNr },
    CursorLineNr { fg = xres.color15, bg = xres.color6, gui = "bold" },
    Type { fg = xres.color13, bg = xres.bg, gui = "bold" },
    Question { Type },
    StatusLine { fg = xres.color15, bg = xres.color8, gui = "bold" },
    StatusLineNC { fg = xres.color15, bg = xres.color8 },
    Comment { fg = xres.color4, bg = xres.color0 },
    SignColumn { fg = xres.color12, bg = xres.color8 },
    VertSplit { fg = xres.color0, bg = xres.color8, gui = "reverse" },
    Title { fg = xres.fg.lighten(25), bg = xres.bg },
    WildMenu { fg = xres.color0, bg = xres.color11 },
    Keyword { fg = xres.color13 },
    Pmenu { fg = xres.color15, bg = xres.bg },
    PmenuSel { fg = xres.none, bg = xres.bg.lighten(15) },
    PmenuSbar { fg = xres.fg.lighten(25) },
    PmenuThumb { fg = xres.fg, bg = xres.color15 },
    QuickFixLine { Search },
    Substitute { Search },
    Whitespace { NonText },
    MsgSeparator { StatusLine },
    NormalFloat { Pmenu },
    Label { Type },
    Operator { Type },
    StorageClass { Type },
    Structure { Type },
    NvimNumberPrefix { Type },
    NvimOptionSigil { Type },
    Normal { fg = xres.color15, bg = xres.color0 },
    NvimTreePopup { Normal },
    NvimTreeNormal { Normal },
    DapUIFrameName { Normal },
    DapUIValue { Normal },
    DapUIVariable { Normal },
    NvimSpacing { Normal },
    Delimiter { fg = xres.color15, bg = xres.color8 },
    NvimParenthesis { Delimiter },
    NvimColon { Delimiter },
    NvimComma { Delimiter },
    NvimArrow { Delimiter },
    Constant { fg = xres.color11, bg = xres.bg },
    String { Constant },
    Character { Constant },
    Visual { fg = xres.color0, bg = xres.color14 },
    Function { fg = xres.color15, bg = xres.bg },
    Special { fg = xres.color9 },
    Tag { Special },
    Debug { Special },
    PreProc { fg = xres.color10 },
    Include { PreProc },
    Define { PreProc },
    Macro { PreProc },
    PreCondit { PreProc },
    Conditional { fg = xres.color11 },
    Repeat { Conditional },
    Statement { fg = xres.color10, gui = "bold" },
    Method {},
    Boolean { Statement },
    FloatBorder { Pmenu },
    FloatTitle { Normal },
    SpecialChar { fg = xres.color12, bg = xres.color8 },
    SpecialComment { fg = xres.color11, bg = xres.color8 },
    FoldColumn { fg = xres.color14, bg = xres.bg },
    Folded { FoldColumn },
    WarningMsg { fg = xres.color10 }, -- WarningMsg           xxx ctermfg=10 guifg=Red
    Conceal { fg = xres.color7 }, -- Conceal              xxx ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
    SpellBad { fg = xres.color8, bg = xres.color9 }, -- SpellBad             xxx ctermfg=8 ctermbg=9 gui=undercurl guisp=Red
    SpellCap { bg = xres.color12.da(25), gui = "undercurl" }, -- SpellCap             xxx ctermbg=12 gui=undercurl guisp=Blue
    SpellRare { bg = xres.color13.da(55), gui = "undercurl" }, -- SpellRare            xxx ctermbg=13 gui=undercurl guisp=Magenta
    SpellLocal { bg = xres.color8, gui = "undercurl" }, -- SpellLocal           xxx ctermbg=14 gui=undercurl guisp=Cyan
    CursorColumn {}, -- CursorColumn         xxx ctermbg=242 guibg=Grey40
    CursorLine { bg = xres.color0 }, -- CursorLine           xxx ctermbg=0 guibg=Grey40
    ColorColumn { bg = xres.color1 }, -- ColorColumn          xxx ctermbg=1 guibg=DarkRed
    NormalNC {}, -- NormalNC             xxx cleared
    MsgArea {}, -- MsgArea              xxx cleared
    RedrawDebugNormal { gui = "reverse" }, -- RedrawDebugNormal    xxx cterm=reverse gui=reverse
    RedrawDebugClear { bg = xres.color11.ro(180).lighten(70) }, -- RedrawDebugClear     xxx ctermbg=11 guibg=Yellow
    RedrawDebugComposed { bg = xres.color10.da(50) }, -- RedrawDebugComposed  xxx ctermbg=10 guibg=Green
    RedrawDebugRecompose { bg = xres.color9.da(50) }, -- RedrawDebugRecompose xxx ctermbg=9 guibg=Red
    Cursor { fg = xres.bg, bg = xres.fg }, -- Cursor               xxx guifg=bg guibg=fg
    lCursor { fg = xres.bg, bg = xres.fg }, -- lCursor              xxx guifg=bg guibg=fg
    FloatShadow { fg = xres.fg.lighten(15), bg = xres.bg.lighten(15) }, -- FloatShadow          xxx guibg=Black blend=80
    FloatShadowThrough { fg = xres.color15, bg = xres.bg }, -- FloatShadowThrough   xxx guibg=Black blend=100
    Error { DiagnosticError }, -- Error                xxx ctermfg=0 ctermbg=1 guifg=White guibg=Red
    Todo { fg = xres.color14, bg = xres.color8 }, -- Todo                 xxx ctermfg=15 ctermbg=8 guifg=Blue guibg=Yellow
    Number { fg = xres.color12 }, -- Number               xxx ctermfg=12
    Float { fg = xres.color12 }, -- Float                xxx ctermfg=14 guifg=#88AAEE
    Identifier { fg = xres.color12 }, -- Identifier           xxx ctermfg=12 guifg=#40ffff
    Exception { fg = xres.color10, bg = xres.color0 }, -- Exception            xxx ctermfg=10 ctermbg=0 guifg=Red guibg=White
    Typedef { fg = xres.color10, bg = xres.color8 }, -- Typedef              xxx ctermfg=10 ctermbg=8 gui=italic guifg=White guibg=Blue
    MatchParen { fg = xres.color12, bg = xres.color8 }, -- MatchParen           xxx ctermfg=12 ctermbg=8 guibg=DarkCyan
    Underlined { fg = xres.color12, gui = "underline" }, -- Underlined           xxx cterm=underline ctermfg=12 gui=underline guifg=#80a0ff
    Ignore { fg = xres.color0.lighten(15) }, -- Ignore               xxx ctermfg=0 guifg=bg
    User1 { fg = xres.color15, bg = xres.color6 }, -- User1                xxx ctermfg=15 ctermbg=6
    User2 { fg = xres.color15, bg = xres.color8 }, -- User2                xxx ctermfg=15 ctermbg=8
    StatusLineTerm { fg = xres.color0 }, -- StatusLineTerm       xxx ctermfg=0
    StatusLineTermNC { fg = xres.color15, bg = xres.color8 }, -- StatusLineTermNC     xxx ctermfg=15 ctermbg=8
    YCMWarningSection { fg = xres.color0, bg = xres.color4 }, -- YCMWarningSection    xxx ctermfg=0 ctermbg=4
    debugPC {}, --  debugPC             xxx cleared

    -- groups for lsp document highlights see `vim.lsp.buf.document_highlight`
    LspReferenceText { bg = xres.color0.lighten(10) },
    LspReferenceRead { SpecialKey },
    LspReferenceWrite { fg = LspReferenceRead.fg.darken(25), bg = LspReferenceRead.bg },
    LspInfoBorder { FloatBorder },
    LspInfoTitle { FloatTitle },
    LspInfoList { fg = xres.color3, bg = xres.bg },
    LspInfoTip { fg = xres.color10, bg = xres.bg },

    -- diff
    diffOnly { Constant }, -- diffOnly       xxx links to Constant
    diffIdentical { Constant }, -- diffIdentical  xxx links to Constant
    diffDiffer { Constant }, -- diffDiffer     xxx links to Constant
    diffBDiffer { Constant }, -- diffBDiffer    xxx links to Constant
    diffIsA { Constant }, -- diffIsA        xxx links to Constant
    diffNoEOL { Constant }, -- diffNoEOL      xxx links to Constant
    diffCommon { Constant }, -- diffCommon     xxx links to Constant
    diffRemoved { DiffDelete }, -- diffRemoved    xxx links to Special
    diffAdded { DiffAdd }, -- diffAdded      xxx links to Identifier
    diffChanged { DiffChange }, -- diffChanged    xxx links to PreProc
    diffSubname { PreProc }, -- diffSubname    xxx links to PreProc
    diffLine { Statement }, -- diffLine       xxx links to Statement
    diffFile { Type }, -- diffFile       xxx links to Type
    diffOldFile { fg = DiffDelete.bg.lighten(20) }, -- diffOldFile    xxx links to diffFile
    diffNewFile { fg = DiffAdd.bg.lighten(20) }, -- diffNewFile    xxx links to diffFile
    diffIndexLine { PreProc }, -- diffIndexLine  xxx links to PreProc
    diffComment { Comment }, -- diffComment    xxx links to Comment

    -- Gitsigns
    GitSignsDelete { fg = diffOldFile.fg.lighten(30) }, -- GitSignsDelete           xxx links to DiffDelete
    GitSignsDeleteNr { fg = GitSignsDelete.fg }, -- GitSignsDeleteNr         xxx links to GitSignsDelete
    GitSignsAdd { fg = diffNewFile.fg.lighten(15) }, -- GitSignsAdd              xxx links to DiffAdd
    GitSignsAddNr { fg = GitSignsAdd.fg }, -- GitSignsAddNr            xxx links to GitSignsAdd
    GitSignsChange { fg = GitSignsAdd.fg.ro(300).lighten(10) }, -- GitSignsAdd              xxx links to DiffAdd
    GitSignsChangeNr { fg = GitSignsChange.fg }, -- GitSignsAddNr            xxx links to GitSignsAdd
    GitSignsCurrentLineBlame { fg = NonText.fg.lighten(15) }, -- GitSignsCurrentLineBlame xxx links to NonText

    -- Nvim groups
    NvimString { String },
    NvimStringBody { NvimString },
    NvimStringQuote { NvimString },
    NvimStringSpecial { SpecialChar },
    NvimSingleQuote { NvimStringQuote },
    NvimSingleQuotedBody { NvimStringBody },
    NvimSingleQuotedQuote { NvimStringSpecial },
    NvimDoubleQuote { NvimStringQuote },
    NvimDoubleQuotedBody { NvimStringBody },
    NvimDoubleQuotedEscape { NvimStringSpecial },
    NvimInternalError { fg = xres.color9, bg = xres.color9.da(50) }, -- NvimInternalError                      xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
    NvimAssignment { Operator }, -- NvimAssignment                         xxx links to Operator
    NvimPlainAssignment { NvimAssignment }, -- NvimPlainAssignment                    xxx links to NvimAssignment
    NvimAugmentedAssignment { NvimAssignment }, -- NvimAugmentedAssignment                xxx links to NvimAssignment
    NvimAssignmentWithAddition { NvimAugmentedAssignment }, -- NvimAssignmentWithAddition             xxx links to NvimAugmentedAssignment
    NvimAssignmentWithSubtraction { NvimAugmentedAssignment }, -- NvimAssignmentWithSubtraction          xxx links to NvimAugmentedAssignment
    NvimAssignmentWithConcatenation { NvimAugmentedAssignment }, -- NvimAssignmentWithConcatenation        xxx links to NvimAugmentedAssignment
    NvimOperator { Operator }, -- NvimOperator                           xxx links to Operator
    NvimUnaryOperator { NvimOperator }, -- NvimUnaryOperator                      xxx links to NvimOperator
    NvimUnaryPlus { NvimUnaryOperator }, -- NvimUnaryPlus                          xxx links to NvimUnaryOperator
    NvimUnaryMinus { NvimUnaryOperator }, -- NvimUnaryMinus                         xxx links to NvimUnaryOperator
    NvimNot { NvimUnaryOperator }, -- NvimNot                                xxx links to NvimUnaryOperator
    NvimBinaryOperator { NvimOperator }, -- NvimBinaryOperator                     xxx links to NvimOperator
    NvimComparison { NvimBinaryOperator }, -- NvimComparison                         xxx links to NvimBinaryOperator
    NvimComparisonModifier { NvimComparison }, -- NvimComparisonModifier                 xxx links to NvimComparison
    NvimBinaryPlus { NvimBinaryOperator }, -- NvimBinaryPlus                         xxx links to NvimBinaryOperator
    NvimBinaryMinus { NvimBinaryOperator }, -- NvimBinaryMinus                        xxx links to NvimBinaryOperator
    NvimConcat { NvimBinaryOperator }, -- NvimConcat                             xxx links to NvimBinaryOperator
    NvimConcatOrSubscript { NvimConcat }, -- NvimConcatOrSubscript                  xxx links to NvimConcat
    NvimOr { NvimBinaryOperator }, -- NvimOr                                 xxx links to NvimBinaryOperator
    NvimAnd { NvimBinaryOperator }, -- NvimAnd                                xxx links to NvimBinaryOperator
    NvimMultiplication { NvimBinaryOperator }, -- NvimMultiplication                     xxx links to NvimBinaryOperator
    NvimDivision { NvimBinaryOperator }, -- NvimDivision                           xxx links to NvimBinaryOperator
    NvimMod { NvimBinaryOperator }, -- NvimMod                                xxx links to NvimBinaryOperator
    NvimTernary { NvimOperator }, -- NvimTernary                            xxx links to NvimOperator
    NvimTernaryColon { NvimTernary }, -- NvimTernaryColon                       xxx links to NvimTernary
    NvimLambda { NvimParenthesis }, -- NvimLambda                             xxx links to NvimParenthesis
    NvimNestingParenthesis { NvimParenthesis }, -- NvimNestingParenthesis                 xxx links to NvimParenthesis
    NvimCallingParenthesis { NvimParenthesis }, -- NvimCallingParenthesis                 xxx links to NvimParenthesis
    NvimSubscript { NvimParenthesis }, -- NvimSubscript                          xxx links to NvimParenthesis
    NvimSubscriptBracket { NvimSubscript }, -- NvimSubscriptBracket                   xxx links to NvimSubscript
    NvimSubscriptColon { NvimSubscript }, -- NvimSubscriptColon                     xxx links to NvimSubscript
    NvimCurly { NvimString }, -- NvimCurly                              xxx links to NvimSubscript
    NvimContainer { NvimParenthesis }, -- NvimContainer                          xxx links to NvimParenthesis
    NvimDict { NvimContainer }, -- NvimDict                               xxx links to NvimContainer
    NvimList { NvimContainer }, -- NvimList                               xxx links to NvimContainer
    NvimIdentifier { Identifier }, -- NvimIdentifier                         xxx links to Identifier
    NvimIdentifierScope { NvimIdentifier }, -- NvimIdentifierScope                    xxx links to NvimIdentifier
    NvimIdentifierScopeDelimiter { NvimIdentifier }, -- NvimIdentifierScopeDelimiter           xxx links to NvimIdentifier
    NvimIdentifierName { NvimIdentifier }, -- NvimIdentifierName                     xxx links to NvimIdentifier
    NvimIdentifierKey { NvimIdentifier }, -- NvimIdentifierKey                      xxx links to NvimIdentifier
    NvimRegister { SpecialChar }, -- NvimRegister                           xxx links to SpecialChar
    NvimNumber { Number }, -- NvimNumber                             xxx links to Number
    NvimFloat { NvimNumber }, -- NvimFloat                              xxx links to NvimNumber
    NvimOptionName { NvimIdentifier }, -- NvimOptionName                         xxx links to NvimIdentifier
    NvimOptionScope { NvimIdentifierScope }, -- NvimOptionScope                        xxx links to NvimIdentifierScope
    NvimOptionScopeDelimiter { NvimIdentifierScopeDelimiter }, -- NvimOptionScopeDelimiter               xxx links to NvimIdentifierScopeDelimiter
    NvimEnvironmentSigil { NvimOptionSigil }, -- NvimEnvironmentSigil                   xxx links to NvimOptionSigil
    NvimEnvironmentName { NvimIdentifier }, -- NvimEnvironmentName                    xxx links to NvimIdentifier
    NvimFigureBrace { NvimInternalError }, -- NvimFigureBrace                        xxx links to NvimInternalError
    NvimSingleQuotedUnknownEscape { NvimInternalError }, -- NvimSingleQuotedUnknownEscape          xxx links to NvimInternalError
    NvimInvalidSingleQuotedUnknownEscape { NvimInternalError }, -- NvimInvalidSingleQuotedUnknownEscape   xxx links to NvimInternalError
    NvimInvalid { Error }, -- NvimInvalid                            xxx links to Error
    NvimInvalidAssignment { NvimInvalid }, -- NvimInvalidAssignment                  xxx links to NvimInvalid
    NvimInvalidPlainAssignment { NvimInvalidAssignment }, -- NvimInvalidPlainAssignment             xxx links to NvimInvalidAssignment
    NvimInvalidAugmentedAssignment { NvimInvalidAssignment }, -- NvimInvalidAugmentedAssignment         xxx links to NvimInvalidAssignment
    NvimInvalidAssignmentWithAddition { NvimInvalidAugmentedAssignment }, -- NvimInvalidAssignmentWithAddition      xxx links to NvimInvalidAugmentedAssignment
    NvimInvalidAssignmentWithSubtraction { NvimInvalidAugmentedAssignment }, -- NvimInvalidAssignmentWithSubtraction   xxx links to NvimInvalidAugmentedAssignment
    NvimInvalidAssignmentWithConcatenation { NvimInvalidAugmentedAssignment }, -- NvimInvalidAssignmentWithConcatenation xxx links to NvimInvalidAugmentedAssignment
    NvimInvalidOperator { NvimInvalid }, -- NvimInvalidOperator                    xxx links to NvimInvalid
    NvimInvalidUnaryOperator { NvimInvalidOperator }, -- NvimInvalidUnaryOperator               xxx links to NvimInvalidOperator
    NvimInvalidUnaryPlus { NvimInvalidUnaryOperator }, -- NvimInvalidUnaryPlus                   xxx links to NvimInvalidUnaryOperator
    NvimInvalidUnaryMinus { NvimInvalidUnaryOperator }, -- NvimInvalidUnaryMinus                  xxx links to NvimInvalidUnaryOperator
    NvimInvalidNot { NvimInvalidUnaryOperator }, -- NvimInvalidNot                         xxx links to NvimInvalidUnaryOperator
    NvimInvalidBinaryOperator { NvimInvalidOperator }, -- NvimInvalidBinaryOperator              xxx links to NvimInvalidOperator
    NvimInvalidComparison { NvimInvalidBinaryOperator }, -- NvimInvalidComparison                  xxx links to NvimInvalidBinaryOperator
    NvimInvalidComparisonModifier { NvimInvalidComparison }, -- NvimInvalidComparisonModifier          xxx links to NvimInvalidComparison
    NvimInvalidBinaryPlus { NvimInvalidBinaryOperator }, -- NvimInvalidBinaryPlus                  xxx links to NvimInvalidBinaryOperator
    NvimInvalidBinaryMinus { NvimInvalidBinaryOperator }, -- NvimInvalidBinaryMinus                 xxx links to NvimInvalidBinaryOperator
    NvimInvalidConcat { NvimInvalidBinaryOperator }, -- NvimInvalidConcat                      xxx links to NvimInvalidBinaryOperator
    NvimInvalidConcatOrSubscript { NvimInvalidConcat }, -- NvimInvalidConcatOrSubscript           xxx links to NvimInvalidConcat
    NvimInvalidOr { NvimInvalidBinaryOperator }, -- NvimInvalidOr                          xxx links to NvimInvalidBinaryOperator
    NvimInvalidAnd { NvimInvalidBinaryOperator }, -- NvimInvalidAnd                         xxx links to NvimInvalidBinaryOperator
    NvimInvalidMultiplication { NvimInvalidBinaryOperator }, -- NvimInvalidMultiplication              xxx links to NvimInvalidBinaryOperator
    NvimInvalidDivision { NvimInvalidBinaryOperator }, -- NvimInvalidDivision                    xxx links to NvimInvalidBinaryOperator
    NvimInvalidMod { NvimInvalidBinaryOperator }, -- NvimInvalidMod                         xxx links to NvimInvalidBinaryOperator
    NvimInvalidTernary { NvimInvalidOperator }, -- NvimInvalidTernary                     xxx links to NvimInvalidOperator
    NvimInvalidTernaryColon { NvimInvalidTernary }, -- NvimInvalidTernaryColon                xxx links to NvimInvalidTernary
    NvimInvalidDelimiter { NvimInvalid }, -- NvimInvalidDelimiter                   xxx links to NvimInvalid
    NvimInvalidParenthesis { NvimInvalidDelimiter }, -- NvimInvalidParenthesis                 xxx links to NvimInvalidDelimiter
    NvimInvalidLambda { NvimInvalidParenthesis }, -- NvimInvalidLambda                      xxx links to NvimInvalidParenthesis
    NvimInvalidNestingParenthesis { NvimInvalidParenthesis }, -- NvimInvalidNestingParenthesis          xxx links to NvimInvalidParenthesis
    NvimInvalidCallingParenthesis { NvimInvalidParenthesis }, -- NvimInvalidCallingParenthesis          xxx links to NvimInvalidParenthesis
    NvimInvalidSubscript { NvimInvalidParenthesis }, -- NvimInvalidSubscript                   xxx links to NvimInvalidParenthesis
    NvimInvalidSubscriptBracket { NvimInvalidSubscript }, -- NvimInvalidSubscriptBracket            xxx links to NvimInvalidSubscript
    NvimInvalidSubscriptColon { NvimInvalidSubscript }, -- NvimInvalidSubscriptColon              xxx links to NvimInvalidSubscript
    NvimInvalidCurly { NvimInvalidSubscript }, -- NvimInvalidCurly                       xxx links to NvimInvalidSubscript
    NvimInvalidContainer { NvimInvalidParenthesis }, -- NvimInvalidContainer                   xxx links to NvimInvalidParenthesis
    NvimInvalidDict { NvimInvalidContainer }, -- NvimInvalidDict                        xxx links to NvimInvalidContainer
    NvimInvalidList { NvimInvalidContainer }, -- NvimInvalidList                        xxx links to NvimInvalidContainer
    NvimInvalidValue { NvimInvalid }, -- NvimInvalidValue                       xxx links to NvimInvalid
    NvimInvalidIdentifier { NvimInvalidValue }, -- NvimInvalidIdentifier                  xxx links to NvimInvalidValue
    NvimInvalidIdentifierScope { NvimInvalidIdentifier }, -- NvimInvalidIdentifierScope             xxx links to NvimInvalidIdentifier
    NvimInvalidIdentifierScopeDelimiter { NvimInvalidIdentifier }, -- NvimInvalidIdentifierScopeDelimiter    xxx links to NvimInvalidIdentifier
    NvimInvalidIdentifierName { NvimInvalidIdentifier }, -- NvimInvalidIdentifierName              xxx links to NvimInvalidIdentifier
    NvimInvalidIdentifierKey { NvimInvalidIdentifier }, -- NvimInvalidIdentifierKey               xxx links to NvimInvalidIdentifier
    NvimInvalidColon { NvimInvalidDelimiter }, -- NvimInvalidColon                       xxx links to NvimInvalidDelimiter
    NvimInvalidComma { NvimInvalidDelimiter }, -- NvimInvalidComma                       xxx links to NvimInvalidDelimiter
    NvimInvalidArrow { NvimInvalidDelimiter }, -- NvimInvalidArrow                       xxx links to NvimInvalidDelimiter
    NvimInvalidRegister { NvimInvalidValue }, -- NvimInvalidRegister                    xxx links to NvimInvalidValue
    NvimInvalidNumber { NvimInvalidValue }, -- NvimInvalidNumber                      xxx links to NvimInvalidValue
    NvimInvalidFloat { NvimInvalidNumber }, -- NvimInvalidFloat                       xxx links to NvimInvalidNumber
    NvimInvalidNumberPrefix { NvimInvalidNumber }, -- NvimInvalidNumberPrefix                xxx links to NvimInvalidNumber
    NvimInvalidOptionSigil { NvimInvalidIdentifier }, -- NvimInvalidOptionSigil                 xxx links to NvimInvalidIdentifier
    NvimInvalidOptionName { NvimInvalidIdentifier }, -- NvimInvalidOptionName                  xxx links to NvimInvalidIdentifier
    NvimInvalidOptionScope { NvimInvalidIdentifierScope }, -- NvimInvalidOptionScope                 xxx links to NvimInvalidIdentifierScope
    NvimInvalidOptionScopeDelimiter { NvimInvalidIdentifierScopeDelimiter }, -- NvimInvalidOptionScopeDelimiter        xxx links to NvimInvalidIdentifierScopeDelimiter
    NvimInvalidEnvironmentSigil { NvimInvalidOptionSigil }, -- NvimInvalidEnvironmentSigil            xxx links to NvimInvalidOptionSigil
    NvimInvalidEnvironmentName { NvimInvalidIdentifier }, -- NvimInvalidEnvironmentName             xxx links to NvimInvalidIdentifier
    NvimInvalidString { NvimInvalidValue }, -- NvimInvalidString                      xxx links to NvimInvalidValue
    NvimInvalidStringBody { NvimStringBody }, -- NvimInvalidStringBody                  xxx links to NvimStringBody
    NvimInvalidStringQuote { NvimInvalidString }, -- NvimInvalidStringQuote                 xxx links to NvimInvalidString
    NvimInvalidStringSpecial { NvimStringSpecial }, -- NvimInvalidStringSpecial               xxx links to NvimStringSpecial
    NvimInvalidSingleQuote { NvimInvalidStringQuote }, -- NvimInvalidSingleQuote                 xxx links to NvimInvalidStringQuote
    NvimInvalidSingleQuotedBody { NvimInvalidStringBody }, -- NvimInvalidSingleQuotedBody            xxx links to NvimInvalidStringBody
    NvimInvalidSingleQuotedQuote { NvimInvalidStringSpecial }, -- NvimInvalidSingleQuotedQuote           xxx links to NvimInvalidStringSpecial
    NvimInvalidDoubleQuote { NvimInvalidStringQuote }, -- NvimInvalidDoubleQuote                 xxx links to NvimInvalidStringQuote
    NvimInvalidDoubleQuotedBody { NvimInvalidStringBody }, -- NvimInvalidDoubleQuotedBody            xxx links to NvimInvalidStringBody
    NvimInvalidDoubleQuotedEscape { NvimInvalidStringSpecial }, -- NvimInvalidDoubleQuotedEscape          xxx links to NvimInvalidStringSpecial
    NvimInvalidDoubleQuotedUnknownEscape { NvimInvalidValue }, -- NvimInvalidDoubleQuotedUnknownEscape   xxx links to NvimInvalidValue
    NvimInvalidFigureBrace { NvimInvalidDelimiter }, -- NvimInvalidFigureBrace                 xxx links to NvimInvalidDelimiter
    NvimInvalidSpacing { ErrorMsg }, -- NvimInvalidSpacing                     xxx links to ErrorMsg
    NvimDoubleQuotedUnknownEscape { NvimInvalidValue }, -- NvimDoubleQuotedUnknownEscape          xxx links to NvimInvalidValue

    ElCommand { Constant }, -- ElCommand                       xxx links to Constant
    ElCommandCV { StatusLine }, -- ElCommandCV                     xxx links to StatusLine
    ElCommandEx { StatusLine }, -- ElCommandEx                     xxx links to StatusLine
    ElConfirm { StatusLine }, -- ElConfirm                       xxx links to StatusLine
    ElInsertCompletion { StatusLine }, -- ElInsertCompletion              xxx links to StatusLine
    ElInsert { MsgSeparator }, -- ElInsert                        xxx links to MsgSeparator
    ElMore { StatusLine }, -- ElMore                          xxx links to StatusLine
    ElNormal { Function }, -- ElNormal                        xxx links to Function
    ElNormalOperatorPending { StatusLine }, -- ElNormalOperatorPending         xxx links to StatusLine
    ElPrompt { StatusLine }, -- ElPrompt                        xxx links to StatusLine
    ElReplace { StatusLine }, -- ElReplace                       xxx links to StatusLine
    ElSBlock { StatusLine }, -- ElSBlock                        xxx links to StatusLine
    ElSelect { StatusLine }, -- ElSelect                        xxx links to StatusLine
    ElShell { StatusLine }, -- ElShell                         xxx links to StatusLine
    ElSLine { StatusLine }, -- ElSLine                         xxx links to StatusLine
    ElTerm { StatusLine }, -- ElTerm                          xxx links to StatusLine
    ElVirtualReplace { StatusLine }, -- ElVirtualReplace                xxx links to StatusLine
    ElVisualBlock { StatusLine }, -- ElVisualBlock                   xxx links to StatusLine
    ElVisualLine { StatusLine }, -- ElVisualLine                    xxx links to StatusLine
    ElVisual { StatusLine }, -- ElVisual                        xxx links to StatusLine
    ElCommandInactive { ElCommand }, -- ElCommandInactive               xxx links to ElCommand
    ElCommandCVInactive { ElCommandCV }, -- ElCommandCVInactive             xxx links to ElCommandCV
    ElCommandExInactive { ElCommandEx }, -- ElCommandExInactive             xxx links to ElCommandEx
    ElConfirmInactive { ElConfirm }, -- ElConfirmInactive               xxx links to ElConfirm
    ElInsertCompletionInactive { ElInsertCompletion }, -- ElInsertCompletionInactive      xxx links to ElInsertCompletion
    ElInsertInactive { ElInsert }, -- ElInsertInactive                xxx links to ElInsert
    ElMoreInactive { ElMore }, -- ElMoreInactive                  xxx links to ElMore
    ElNormalInactive { ElNormal }, -- ElNormalInactive                xxx links to ElNormal
    ElNormalOperatorPendingInactive { ElNormalOperatorPending }, -- ElNormalOperatorPendingInactive xxx links to ElNormalOperatorPending
    ElPromptInactive { ElPrompt }, -- ElPromptInactive                xxx links to ElPrompt
    ElReplaceInactive { ElReplace }, -- ElReplaceInactive               xxx links to ElReplace
    ElSBlockInactive { ElSBlock }, -- ElSBlockInactive                xxx links to ElSBlock
    ElSelectInactive { ElSelect }, -- ElSelectInactive                xxx links to ElSelect
    ElShellInactive { ElShell }, -- ElShellInactive                 xxx links to ElShell
    ElSLineInactive { ElSLine }, -- ElSLineInactive                 xxx links to ElSLine
    ElTermInactive { ElTerm }, -- ElTermInactive                  xxx links to ElTerm
    ElVirtualReplaceInactive { ElVirtualReplace }, -- ElVirtualReplaceInactive        xxx links to ElVirtualReplace
    ElVisualBlockInactive { ElVisualBlock }, -- ElVisualBlockInactive           xxx links to ElVisualBlock
    ElVisualLineInactive { ElVisualLine }, -- ElVisualLineInactive            xxx links to ElVisualLine
    ElVisualInactive { ElVisual }, -- ElVisualInactive                xxx links to ElVisual

    -- Dap UI
    -- DapUIScope                  xxx guifg=#00F1F5
    -- DapUIType                   xxx guifg=#D484FF
    -- DapUIModifiedValue          xxx gui=bold guifg=#00F1F5
    -- DapUIDecoration             xxx guifg=#00F1F5
    -- DapUIThread                 xxx guifg=#A9FF68
    -- DapUIStoppedThread          xxx guifg=#00f1f5
    -- DapUISource                 xxx guifg=#D484FF
    -- DapUILineNumber             xxx guifg=#00f1f5
    -- DapUIFloatBorder            xxx guifg=#00F1F5
    -- DapUIWatchesEmpty           xxx guifg=#F70067
    -- DapUIWatchesValue           xxx guifg=#A9FF68
    -- DapUIWatchesError           xxx guifg=#F70067
    -- DapUIBreakpointsPath        xxx guifg=#00F1F5
    -- DapUIBreakpointsInfo        xxx guifg=#A9FF68
    -- DapUIBreakpointsCurrentLine xxx gui=bold guifg=#A9FF68
    -- DapUIBreakpointsLine        xxx links to DapUILineNumber

    -- Nvim Tree
    -- NvimTreeExecFile xxx gui=bold guifg=Green
    -- NvimTreeImageFile xxx gui=bold guifg=Purple
    -- NvimTreeIndentMarker xxx guifg=#8094b4
    -- NvimTreeFolderIcon xxx guifg=#8094b4
    -- NvimTreeGitRenamed xxx guifg=Purple
    -- NvimTreeOpenedFile xxx gui=bold guifg=Green
    -- NvimTreeGitStaged xxx guifg=Green
    -- NvimTreeWindowPicker xxx gui=bold guifg=#ededed guibg=#4493c8
    -- NvimTreeFileRenamed xxx links to NvimTreeGitRenamed
    -- NvimTreeFileStaged xxx links to NvimTreeGitStaged
    NvimTreeSpecialFile { fg = xres.color10, gui = "bold,underline" }, -- NvimTreeSpecialFile               xxx gui=bold,underline guifg=10
    NvimTreeGitDeleted { diffOldFile }, -- NvimTreeGitDeleted                xxx guifg=13
    NvimTreeGitNew { diffNewFile }, -- NvimTreeGitNew                    xxx guifg=10
    NvimTreeGitMerge { fg = xres.color12 }, -- NvimTreeGitMerge                  xxx guifg=12
    NvimTreeSymlink { fg = xres.color11, gui = "bold" }, -- NvimTreeSymlink                   xxx gui=bold guifg=11
    NvimTreeRootFolder { fg = xres.color7 }, --                                   xxx guifg=Purple
    NvimTreeGitDirty { fg = xres.color13 }, -- NvimTreeGitDirty                  xxx guifg=13
    NvimTreeSignColumn { NvimTreeNormal }, -- NvimTreeSignColumn                xxx links to NvimTreeNormal
    NvimTreeFileNew { NvimTreeGitNew }, -- NvimTreeFileNew                   xxx links to NvimTreeGitNew
    NvimTreeFileDeleted { NvimTreeGitDeleted }, -- NvimTreeFileDeleted               xxx links to NvimTreeGitDeleted
    NvimTreeVertSplit { VertSplit }, -- NvimTreeVertSplit                 xxx links to VertSplit
    NvimTreeFileMerge { NvimTreeGitMerge }, -- NvimTreeFileMerge                 xxx links to NvimTreeGitMerge
    NvimTreeFolderName { Directory }, -- NvimTreeFolderName                xxx links to Directory
    NvimTreeStatusLineNC { StatusLineNC }, -- NvimTreeStatusLineNC              xxx links to StatusLineNC
    NvimTreeStatusLine { StatusLine }, -- NvimTreeStatusLine                xxx links to StatusLine
    NvimTreeCursorLine { CursorLine }, -- NvimTreeCursorLine                xxx links to CursorLine
    NvimTreeGitIgnored { Comment }, -- NvimTreeGitIgnored                xxx links to Comment
    NvimTreeEndOfBuffer { EndOfBuffer }, -- NvimTreeEndOfBuffer               xxx links to EndOfBuffer
    NvimTreeFileDirty { NvimTreeGitDirty }, -- NvimTreeFileDirty                 xxx links to NvimTreeGitDirty
    NvimTreeNormalNC { NvimTreeNormal }, -- NvimTreeNormalNC                  xxx links to NvimTreeNormal
    NvimTreeOpenedFolderName { Directory }, -- NvimTreeOpenedFolderName          xxx links to Directory
    NvimTreeEmptyFolderName { Directory }, -- NvimTreeEmptyFolderName           xxx links to Directory
    NvimTreeCursorColumn { CursorColumn }, -- NvimTreeCursorColumn              xxx links to CursorColumn
    NvimTreeLspDiagnosticsError { DiagnosticError }, -- NvimTreeLspDiagnosticsError       xxx links to DiagnosticError
    NvimTreeLspDiagnosticsWarning { DiagnosticWarning }, -- NvimTreeLspDiagnosticsWarning     xxx links to DiagnosticWarning
    NvimTreeLspDiagnosticsInformation { DiagnosticInfo }, -- NvimTreeLspDiagnosticsInformation xxx links to DiagnosticInfo
    NvimTreeLspDiagnosticsHint { DiagnosticHint }, -- NvimTreeLspDiagnosticsHint        xxx links to DiagnosticHint

    -- Telescope
    TelescopeSelection { fg = xres.color7, bg = xres.color8.lighten(10) }, -- TelescopeSelection              xxx links to Visual
    TelescopeSelectionCaret { TelescopeSelection }, -- TelescopeSelectionCaret         xxx links to TelescopeSelection
    TelescopeMultiSelection { Type }, -- TelescopeMultiSelection         xxx links to Type
    TelescopeNormal { Normal }, -- TelescopeNormal                 xxx links to Normal
    TelescopePreviewNormal { Normal }, -- TelescopePreviewNormal          xxx links to Normal
    TelescopeBorder { TelescopeNormal }, -- TelescopeBorder                 xxx links to TelescopeNormal
    TelescopePromptBorder { TelescopeBorder }, -- TelescopePromptBorder           xxx links to TelescopeBorder
    TelescopeResultsBorder { TelescopeBorder }, -- TelescopeResultsBorder          xxx links to TelescopeBorder
    TelescopePreviewBorder { TelescopeBorder }, -- TelescopePreviewBorder          xxx links to TelescopeBorder
    TelescopeMatching { Special }, -- TelescopeMatching               xxx links to Special
    TelescopePromptPrefix { Identifier }, -- TelescopePromptPrefix           xxx links to Identifier
    TelescopePreviewLine { Visual }, -- TelescopePreviewLine            xxx links to Visual
    TelescopePreviewMatch { Search }, -- TelescopePreviewMatch           xxx links to Search
    TelescopePreviewPipe { Constant }, -- TelescopePreviewPipe            xxx links to Constant
    TelescopePreviewCharDev { Constant }, -- TelescopePreviewCharDev         xxx links to Constant
    TelescopePreviewDirectory { Directory }, -- TelescopePreviewDirectory       xxx links to Directory
    TelescopePreviewBlock { Constant }, -- TelescopePreviewBlock           xxx links to Constant
    TelescopePreviewLink { Special }, -- TelescopePreviewLink            xxx links to Special
    TelescopePreviewSocket { Statement }, -- TelescopePreviewSocket          xxx links to Statement
    TelescopePreviewRead { Constant }, -- TelescopePreviewRead            xxx links to Constant
    TelescopePreviewWrite { Statement }, -- TelescopePreviewWrite           xxx links to Statement
    TelescopePreviewExecute { String }, -- TelescopePreviewExecute         xxx links to String
    TelescopePreviewHyphen { NonText }, -- TelescopePreviewHyphen          xxx links to NonText
    TelescopePreviewSticky { Keyword }, -- TelescopePreviewSticky          xxx links to Keyword
    TelescopePreviewSize { String }, -- TelescopePreviewSize            xxx links to String
    TelescopePreviewUser { Constant }, -- TelescopePreviewUser            xxx links to Constant
    TelescopePreviewGroup { Constant }, -- TelescopePreviewGroup           xxx links to Constant
    TelescopePreviewDate { Directory }, -- TelescopePreviewDate            xxx links to Directory
    TelescopePreviewMessage { TelescopePreviewNormal }, -- TelescopePreviewMessage         xxx links to TelescopePreviewNormal
    TelescopePreviewMessageFillchar { TelescopePreviewMessage }, -- TelescopePreviewMessageFillchar xxx links to TelescopePreviewMessage
    TelescopeResultsClass { Function }, -- TelescopeResultsClass           xxx links to Function
    TelescopeResultsConstant { Constant }, -- TelescopeResultsConstant        xxx links to Constant
    TelescopeResultsField { Function }, -- TelescopeResultsField           xxx links to Function
    TelescopeResultsFunction { Function }, -- TelescopeResultsFunction        xxx links to Function
    TelescopeResultsMethod { Method }, -- TelescopeResultsMethod          xxx links to Method

    -- Devicons
    DevIconDiff { fg = hsl "#41535b" }, -- DevIconDiff                xxx guifg=#41535b
    DevIconElm { fg = hsl "#519aba" }, -- DevIconElm                 xxx guifg=#519aba
    DevIconJl { fg = hsl "#a270ba" }, -- DevIconJl                  xxx guifg=#a270ba
    DevIconSass { fg = hsl "#f55385" }, -- DevIconSass                xxx guifg=#f55385
    DevIconXcPlayground { fg = hsl "#e37933" }, -- DevIconXcPlayground        xxx guifg=#e37933
    DevIconSln { fg = hsl "#854CC7" }, -- DevIconSln                 xxx guifg=#854CC7
    DevIconR { fg = hsl "#358a5b" }, -- DevIconR                   xxx guifg=#358a5b
    DevIconZshrc { fg = hsl "#89e051" }, -- DevIconZshrc               xxx guifg=#89e051
    DevIconTex { fg = hsl "#3D6117" }, -- DevIconTex                 xxx guifg=#3D6117
    DevIconTor { fg = hsl "#519aba" }, -- DevIconTor                 xxx guifg=#519aba
    DevIconJsx { fg = hsl "#519aba" }, -- DevIconJsx                 xxx guifg=#519aba
    DevIconJson { fg = hsl "#cbcb41" }, -- DevIconJson                xxx guifg=#cbcb41
    DevIconPl { fg = hsl "#519aba" }, -- DevIconPl                  xxx guifg=#519aba
    DevIconMl { fg = hsl "#e37933" }, -- DevIconMl                  xxx guifg=#e37933
    DevIconMarkdown { fg = hsl "#519aba" }, -- DevIconMarkdown            xxx guifg=#519aba
    DevIconCp { fg = hsl "#519aba" }, -- DevIconCp                  xxx guifg=#519aba
    DevIconRmd { fg = hsl "#519aba" }, -- DevIconRmd                 xxx guifg=#519aba
    DevIconZsh { fg = hsl "#89e051" }, -- DevIconZsh                 xxx guifg=#89e051
    DevIconCrystal { fg = hsl "#000000" }, -- DevIconCrystal             xxx guifg=#000000
    DevIconIni { fg = hsl "#6d8086" }, -- DevIconIni                 xxx guifg=#6d8086
    DevIconPyc { fg = hsl "#519aba" }, -- DevIconPyc                 xxx guifg=#519aba
    DevIconCpp { fg = hsl "#519aba" }, -- DevIconCpp                 xxx guifg=#519aba
    DevIconGitConfig { fg = hsl "#41535b" }, -- DevIconGitConfig           xxx guifg=#41535b
    DevIconProcfile { fg = hsl "#a074c4" }, -- DevIconProcfile            xxx guifg=#a074c4
    DevIconDesktopEntry { fg = hsl "#563d7c" }, -- DevIconDesktopEntry        xxx guifg=#563d7c
    DevIconFsscript { fg = hsl "#519aba" }, -- DevIconFsscript            xxx guifg=#519aba
    DevIconClojure { fg = hsl "#8dc149" }, -- DevIconClojure             xxx guifg=#8dc149
    DevIconBashrc { fg = hsl "#89e051" }, -- DevIconBashrc              xxx guifg=#89e051
    DevIconErb { fg = hsl "#701516" }, -- DevIconErb                 xxx guifg=#701516
    DevIconEx { fg = hsl "#a074c4" }, -- DevIconEx                  xxx guifg=#a074c4
    DevIconMli { fg = hsl "#e37933" }, -- DevIconMli                 xxx guifg=#e37933
    DevIconSvelte { fg = hsl "#ff3e00" }, -- DevIconSvelte              xxx guifg=#ff3e00
    DevIconC { fg = hsl "#599eff" }, -- DevIconC                   xxx guifg=#599eff
    DevIconEjs { fg = hsl "#cbcb41" }, -- DevIconEjs                 xxx guifg=#cbcb41
    DevIconJava { fg = hsl "#cc3e44" }, -- DevIconJava                xxx guifg=#cc3e44
    DevIconEdn { fg = hsl "#519aba" }, -- DevIconEdn                 xxx guifg=#519aba
    DevIconGruntfile { fg = hsl "#e37933" }, -- DevIconGruntfile           xxx guifg=#e37933
    DevIconSvg { fg = hsl "#FFB13B" }, -- DevIconSvg                 xxx guifg=#FFB13B
    DevIconXul { fg = hsl "#e37933" }, -- DevIconXul                 xxx guifg=#e37933
    DevIconDart { fg = hsl "#03589C" }, -- DevIconDart                xxx guifg=#03589C
    DevIconCMake { fg = hsl "#6d8086" }, -- DevIconCMake               xxx guifg=#6d8086
    DevIconMustache { fg = hsl "#e37933" }, -- DevIconMustache            xxx guifg=#e37933
    DevIconHxx { fg = hsl "#a074c4" }, -- DevIconHxx                 xxx guifg=#a074c4
    DevIconYaml { fg = hsl "#6d8086" }, -- DevIconYaml                xxx guifg=#6d8086
    DevIconCobol { fg = hsl "#005ca5" }, -- DevIconCobol               xxx guifg=#005ca5
    DevIconCPlusPlus { fg = hsl "#f34b7d" }, -- DevIconCPlusPlus           xxx guifg=#f34b7d
    DevIconGitLogo { fg = hsl "#F14C28" }, -- DevIconGitLogo             xxx guifg=#F14C28
    DevIconJpeg { fg = hsl "#a074c4" }, -- DevIconJpeg                xxx guifg=#a074c4
    DevIconWebpack { fg = hsl "#519aba" }, -- DevIconWebpack             xxx guifg=#519aba
    DevIconVimrc { fg = hsl "#019833" }, -- DevIconVimrc               xxx guifg=#019833
    DevIconHtml { fg = hsl "#e34c26" }, -- DevIconHtml                xxx guifg=#e34c26
    DevIconDoc { fg = hsl "#185abd" }, -- DevIconDoc                 xxx guifg=#185abd
    DevIconSwift { fg = hsl "#e37933" }, -- DevIconSwift               xxx guifg=#e37933
    DevIconLess { fg = hsl "#563d7c" }, -- DevIconLess                xxx guifg=#563d7c
    DevIconGemspec { fg = hsl "#701516" }, -- DevIconGemspec             xxx guifg=#701516
    DevIconStyl { fg = hsl "#8dc149" }, -- DevIconStyl                xxx guifg=#8dc149
    DevIconBmp { fg = hsl "#a074c4" }, -- DevIconBmp                 xxx guifg=#a074c4
    DevIconLhs { fg = hsl "#a074c4" }, -- DevIconLhs                 xxx guifg=#a074c4
    DevIconSlim { fg = hsl "#e34c26" }, -- DevIconSlim                xxx guifg=#e34c26
    DevIconScala { fg = hsl "#cc3e44" }, -- DevIconScala               xxx guifg=#cc3e44
    DevIconTerminal { fg = hsl "#31B53E" }, -- DevIconTerminal            xxx guifg=#31B53E
    DevIconGemfile { fg = hsl "#701516" }, -- DevIconGemfile             xxx guifg=#701516
    DevIconGulpfile { fg = hsl "#cc3e44" }, -- DevIconGulpfile            xxx guifg=#cc3e44
    DevIconCoffee { fg = hsl "#cbcb41" }, -- DevIconCoffee              xxx guifg=#cbcb41
    DevIconAi { fg = hsl "#cbcb41" }, -- DevIconAi                  xxx guifg=#cbcb41
    DevIconDefault { fg = hsl "#6d8086" }, -- DevIconDefault             xxx guifg=#6d8086
    DevIconLua { fg = hsl "#51a0cf" }, -- DevIconLua                 xxx guifg=#51a0cf
    DevIconGif { fg = hsl "#a074c4" }, -- DevIconGif                 xxx guifg=#a074c4
    DevIconVagrantfile { fg = hsl "#1563FF" }, -- DevIconVagrantfile         xxx guifg=#1563FF
    DevIconJpg { fg = hsl "#a074c4" }, -- DevIconJpg                 xxx guifg=#a074c4
    DevIconMdx { fg = hsl "#519aba" }, -- DevIconMdx                 xxx guifg=#519aba
    DevIconIco { fg = hsl "#cbcb41" }, -- DevIconIco                 xxx guifg=#cbcb41
    DevIconFsharp { fg = hsl "#519aba" }, -- DevIconFsharp              xxx guifg=#519aba
    DevIconHpp { fg = hsl "#a074c4" }, -- DevIconHpp                 xxx guifg=#a074c4
    DevIconHaml { fg = hsl "#eaeae1" }, -- DevIconHaml                xxx guifg=#eaeae1
    DevIconNPMIgnore { fg = hsl "#E8274B" }, -- DevIconNPMIgnore           xxx guifg=#E8274B
    DevIconKsh { fg = hsl "#4d5a5e" }, -- DevIconKsh                 xxx guifg=#4d5a5e
    DevIconZshprofile { fg = hsl "#89e051" }, -- DevIconZshprofile          xxx guifg=#89e051
    DevIconGitModules { fg = hsl "#41535b" }, -- DevIconGitModules          xxx guifg=#41535b
    DevIconLicense { fg = hsl "#cbcb41" }, -- DevIconLicense             xxx guifg=#cbcb41
    DevIconXls { fg = hsl "#207245" }, -- DevIconXls                 xxx guifg=#207245
    DevIconAwk { fg = hsl "#4d5a5e" }, -- DevIconAwk                 xxx guifg=#4d5a5e
    DevIconGo { fg = hsl "#519aba" }, -- DevIconGo                  xxx guifg=#519aba
    DevIconXml { fg = hsl "#e37933" }, -- DevIconXml                 xxx guifg=#e37933
    DevIconNix { fg = hsl "#7ebae4" }, -- DevIconNix                 xxx guifg=#7ebae4
    DevIconGvimrc { fg = hsl "#019833" }, -- DevIconGvimrc              xxx guifg=#019833
    DevIconTextScene { fg = hsl "#a074c4" }, -- DevIconTextScene           xxx guifg=#a074c4
    DevIconRs { fg = hsl "#dea584" }, -- DevIconRs                  xxx guifg=#dea584
    DevIconPhp { fg = hsl "#a074c4" }, -- DevIconPhp                 xxx guifg=#a074c4
    DevIconHtm { fg = hsl "#e34c26" }, -- DevIconHtm                 xxx guifg=#e34c26
    DevIconPm { fg = hsl "#519aba" }, -- DevIconPm                  xxx guifg=#519aba
    DevIconClojureC { fg = hsl "#8dc149" }, -- DevIconClojureC            xxx guifg=#8dc149
    DevIconHeex { fg = hsl "#a074c4" }, -- DevIconHeex                xxx guifg=#a074c4
    DevIconDockerfile { fg = hsl "#384d54" }, -- DevIconDockerfile          xxx guifg=#384d54
    DevIconMjs { fg = hsl "#f1e05a" }, -- DevIconMjs                 xxx guifg=#f1e05a
    DevIconCson { fg = hsl "#cbcb41" }, -- DevIconCson                xxx guifg=#cbcb41
    DevIconDsStore { fg = hsl "#41535b" }, -- DevIconDsStore             xxx guifg=#41535b
    DevIconImportConfiguration { fg = hsl "#ECECEC" }, -- DevIconImportConfiguration xxx guifg=#ECECEC
    DevIconGitIgnore { fg = hsl "#41535b" }, -- DevIconGitIgnore           xxx guifg=#41535b
    DevIconMixLock { fg = hsl "#a074c4" }, -- DevIconMixLock             xxx guifg=#a074c4
    DevIconDropbox { fg = hsl "#0061FE" }, -- DevIconDropbox             xxx guifg=#0061FE
    DevIconMd { fg = hsl "#519aba" }, -- DevIconMd                  xxx guifg=#519aba
    DevIconClojureJS { fg = hsl "#519aba" }, -- DevIconClojureJS           xxx guifg=#519aba
    DevIconPpt { fg = hsl "#cb4a32" }, -- DevIconPpt                 xxx guifg=#cb4a32
    DevIconRss { fg = hsl "#FB9D3B" }, -- DevIconRss                 xxx guifg=#FB9D3B
    DevIconCs { fg = hsl "#596706" }, -- DevIconCs                  xxx guifg=#596706
    DevIconExs { fg = hsl "#a074c4" }, -- DevIconExs                 xxx guifg=#a074c4
    DevIconEex { fg = hsl "#a074c4" }, -- DevIconEex                 xxx guifg=#a074c4
    DevIconBat { fg = hsl "#C1F12E" }, -- DevIconBat                 xxx guifg=#C1F12E
    DevIconProlog { fg = hsl "#e4b854" }, -- DevIconProlog              xxx guifg=#e4b854
    DevIconJs { fg = hsl "#cbcb41" }, -- DevIconJs                  xxx guifg=#cbcb41
    DevIconVue { fg = hsl "#8dc149" }, -- DevIconVue                 xxx guifg=#8dc149
    DevIconHs { fg = hsl "#a074c4" }, -- DevIconHs                  xxx guifg=#a074c4
    DevIconBashProfile { fg = hsl "#89e051" }, -- DevIconBashProfile         xxx guifg=#89e051
    DevIconZig { fg = hsl "#f69a1b" }, -- DevIconZig                 xxx guifg=#f69a1b
    DevIconBinaryGLTF { fg = hsl "#FFB13B" }, -- DevIconBinaryGLTF          xxx guifg=#FFB13B
    DevIconDump { fg = hsl "#dad8d8" }, -- DevIconDump                xxx guifg=#dad8d8
    DevIconCss { fg = hsl "#563d7c" }, -- DevIconCss                 xxx guifg=#563d7c
    DevIconNodeModules { fg = hsl "#E8274B" }, -- DevIconNodeModules         xxx guifg=#E8274B
    DevIconPsb { fg = hsl "#519aba" }, -- DevIconPsb                 xxx guifg=#519aba
    DevIconTextResource { fg = hsl "#cbcb41" }, -- DevIconTextResource        xxx guifg=#cbcb41
    DevIconZshenv { fg = hsl "#89e051" }, -- DevIconZshenv              xxx guifg=#89e051
    DevIconConfigRu { fg = hsl "#701516" }, -- DevIconConfigRu            xxx guifg=#701516
    DevIconOpenTypeFont { fg = hsl "#ECECEC" }, -- DevIconOpenTypeFont        xxx guifg=#ECECEC
    DevIconFs { fg = hsl "#519aba" }, -- DevIconFs                  xxx guifg=#519aba
    DevIconRake { fg = hsl "#701516" }, -- DevIconRake                xxx guifg=#701516
    DevIconWebmanifest { fg = hsl "#f1e05a" }, -- DevIconWebmanifest         xxx guifg=#f1e05a
    DevIconFsx { fg = hsl "#519aba" }, -- DevIconFsx                 xxx guifg=#519aba
    DevIconRproj { fg = hsl "#358a5b" }, -- DevIconRproj               xxx guifg=#358a5b
    DevIconRlib { fg = hsl "#dea584" }, -- DevIconRlib                xxx guifg=#dea584
    DevIconGodotProject { fg = hsl "#6d8086" }, -- DevIconGodotProject        xxx guifg=#6d8086
    DevIconMaterial { fg = hsl "#B83998" }, -- DevIconMaterial            xxx guifg=#B83998
    DevIconPyd { fg = hsl "#519aba" }, -- DevIconPyd                 xxx guifg=#519aba
    DevIconPy { fg = hsl "#3572A5" }, -- DevIconPy                  xxx guifg=#3572A5
    DevIconD { fg = hsl "#427819" }, -- DevIconD                   xxx guifg=#427819
    DevIconPsd { fg = hsl "#519aba" }, -- DevIconPsd                 xxx guifg=#519aba
    DevIconLeex { fg = hsl "#a074c4" }, -- DevIconLeex                xxx guifg=#a074c4
    DevIconH { fg = hsl "#a074c4" }, -- DevIconH                   xxx guifg=#a074c4
    DevIconFavicon { fg = hsl "#cbcb41" }, -- DevIconFavicon             xxx guifg=#cbcb41
    DevIconPromptPs1 { fg = hsl "#4d5a5e" }, -- DevIconPromptPs1           xxx guifg=#4d5a5e
    DevIconPp { fg = hsl "#302B6D" }, -- DevIconPp                  xxx guifg=#302B6D
    DevIconBash { fg = hsl "#89e051" }, -- DevIconBash                xxx guifg=#89e051
    DevIconPng { fg = hsl "#a074c4" }, -- DevIconPng                 xxx guifg=#a074c4
    DevIconWebp { fg = hsl "#a074c4" }, -- DevIconWebp                xxx guifg=#a074c4
    DevIconConf { fg = hsl "#6d8086" }, -- DevIconConf                xxx guifg=#6d8086
    DevIconDb { fg = hsl "#dad8d8" }, -- DevIconDb                  xxx guifg=#dad8d8
    DevIconGDScript { fg = hsl "#6d8086" }, -- DevIconGDScript            xxx guifg=#6d8086
    DevIconVim { fg = hsl "#019833" }, -- DevIconVim                 xxx guifg=#019833
    DevIconErl { fg = hsl "#B83998" }, -- DevIconErl                 xxx guifg=#B83998
    DevIconBabelrc { fg = hsl "#cbcb41" }, -- DevIconBabelrc             xxx guifg=#cbcb41
    DevIconHrl { fg = hsl "#B83998" }, -- DevIconHrl                 xxx guifg=#B83998
    DevIconPdf { fg = hsl "#b30b00" }, -- DevIconPdf                 xxx guifg=#b30b00
    DevIconRakefile { fg = hsl "#701516" }, -- DevIconRakefile            xxx guifg=#701516
    DevIconRb { fg = hsl "#701516" }, -- DevIconRb                  xxx guifg=#701516
    DevIconGitlabCI { fg = hsl "#e24329" }, -- DevIconGitlabCI            xxx guifg=#e24329
    DevIconScss { fg = hsl "#f55385" }, -- DevIconScss                xxx guifg=#f55385
    DevIconSh { fg = hsl "#4d5a5e" }, -- DevIconSh                  xxx guifg=#4d5a5e
    DevIconSml { fg = hsl "#e37933" }, -- DevIconSml                 xxx guifg=#e37933
    DevIconSql { fg = hsl "#dad8d8" }, -- DevIconSql                 xxx guifg=#dad8d8
    DevIconConfiguration { fg = hsl "#ECECEC" }, -- DevIconConfiguration       xxx guifg=#ECECEC
    DevIconSuo { fg = hsl "#854CC7" }, -- DevIconSuo                 xxx guifg=#854CC7
    DevIconMakefile { fg = hsl "#6d8086" }, -- DevIconMakefile            xxx guifg=#6d8086
    DevIconHh { fg = hsl "#a074c4" }, -- DevIconHh                  xxx guifg=#a074c4
    DevIconYml { fg = hsl "#6d8086" }, -- DevIconYml                 xxx guifg=#6d8086
    DevIconPyo { fg = hsl "#519aba" }, -- DevIconPyo                 xxx guifg=#519aba
    DevIconGitAttributes { fg = hsl "#41535b" }, -- DevIconGitAttributes       xxx guifg=#41535b
    DevIconSettingsJson { fg = hsl "#854CC7" }, -- DevIconSettingsJson        xxx guifg=#854CC7
    DevIconCsh { fg = hsl "#4d5a5e" }, -- DevIconCsh                 xxx guifg=#4d5a5e
    DevIconFish { fg = hsl "#4d5a5e" }, -- DevIconFish                xxx guifg=#4d5a5e
    DevIconToml { fg = hsl "#6d8086" }, -- DevIconToml                xxx guifg=#6d8086
    DevIconCMakeLists { fg = hsl "#6d8086" }, -- DevIconCMakeLists          xxx guifg=#6d8086
    DevIconFsi { fg = hsl "#519aba" }, -- DevIconFsi                 xxx guifg=#519aba
    DevIconCxx { fg = hsl "#519aba" }, -- DevIconCxx                 xxx guifg=#519aba
    DevIconKotlin { fg = hsl "#F88A02" }, -- DevIconKotlin              xxx guifg=#F88A02
    DevIconGitCommit { fg = hsl "#41535b" }, -- DevIconGitCommit           xxx guifg=#41535b
    DevIconPackedResource { fg = hsl "#6d8086" }, -- DevIconPackedResource      xxx guifg=#6d8086
    DevIconSig { fg = hsl "#e37933" }, -- DevIconSig                 xxx guifg=#e37933
    DevIconOPUS { fg = hsl "#F88A02" }, -- DevIconOPUS                xxx guifg=#F88A02
    DevIconHbs { fg = hsl "#f0772b" }, -- DevIconHbs                 xxx guifg=#f0772b
    DevIconTwig { fg = hsl "#8dc149" }, -- DevIconTwig                xxx guifg=#8dc149
    DevIconTs { fg = hsl "#519aba" }, -- DevIconTs                  xxx guifg=#519aba
    DevIconTsx { fg = hsl "#519aba" }, -- DevIconTsx                 xxx guifg=#519aba

    TabLine { ElNormal }, -- TabLine              xxx ctermfg=15 ctermbg=8 gui=underline guibg=DarkGrey
    TabLineSel { ElInsert }, -- TabLineSel           xxx ctermfg=0 ctermbg=14 gui=bold
    TabLineFill { ElNormal }, -- TabLineFill          xxx ctermfg=15 ctermbg=8 gui=reverse

    NotifyERRORBorder { fg = hsl "#8A1F1F" },
    NotifyWARNBorder { fg = hsl "#79491D" },
    NotifyINFOBorder { fg = hsl "#4F6752" },
    NotifyDEBUGBorder { fg = hsl "#8B8B8B" },
    NotifyTRACEBorder { fg = hsl "#4F3552" },
    NotifyERRORIcon { fg = hsl "#F70067" },
    NotifyWARNIcon { fg = hsl "#F79000" },
    NotifyINFOIcon { fg = hsl "#A9FF68" },
    NotifyDEBUGIcon { fg = hsl "#8B8B8B" },
    NotifyTRACEIcon { fg = hsl "#D484FF" },
    NotifyERRORTitle { fg = hsl "#F70067" },
    NotifyWARNTitle { fg = hsl "#F79000" },
    NotifyINFOTitle { fg = hsl "#A9FF68" },
    NotifyDEBUGTitle { fg = hsl "#8B8B8B" },
    NotifyTRACETitle { fg = hsl "#D484FF" },
    NotifyERRORBody { Normal },
    NotifyWARNBody { Normal },
    NotifyINFOBody { Normal },
    NotifyDEBUGBody { Normal },
    NotifyTRACEBody { Normal },

    -- crates.nvim
    CratesNvimLoading { fg = xres.fg.lighten(25), bg = xres.bg },
    CratesNvimPopupLoading { fg = xres.fg.lighten(25), bg = Pmenu.bg },
    CratesNvimVersion { fg = DiagnosticSignInfo.fg, bg = xres.bg },
    CratesNvimPopupVersion { fg = DiagnosticSignInfo.fg, bg = Pmenu.bg },

    CratesNvimPreRelease { fg = DiagnosticSignWarn.fg, bg = xres.bg },
    CratesNvimPopupPreRelease { fg = DiagnosticSignWarn.fg, bg = Pmenu.bg },

    CratesNvimYanked { fg = DiagnosticSignError.fg, bg = xres.bg },
    CratesNvimPopupYanked { fg = DiagnosticSignError.fg, bg = Pmenu.bg },

    CratesNvimNoMatch { fg = DiagnosticSignWarn.fg, bg = xres.bg.lighten(15) },
    CratesNvimUpgrade { fg = GitSignsAdd.fg, bg = xres.bg.lighten(15) },
    CratesNvimError { fg = DiagnosticSignError.fg, bg = xres.bg.lighten(15) },

    -- cmp completion
    CmpItemMenu { fg = Title.fg, bg = xres.none, gui = "italic" },

    CmpItemKindClass { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
    CmpItemKindStruct { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
    CmpItemKindEnum { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
    CmpItemKindEnumMember { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
    CmpItemKindInterface { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },
    CmpItemKindModule { fg = "#FFFFFF", bg = DevIconGulpfile.fg, gui = "bold" },

    CmpItemKindText { fg = "#FFFFFF", bg = DevIconDefault.fg, gui = "bold" },
    CmpItemKindColor { fg = "#FFFFFF", bg = DevIconDefault.fg, gui = "bold" },

    CmpItemKindEvent { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },
    CmpItemKindFile { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },
    CmpItemKindFolder { fg = "#FFFFFF", bg = DevIconLess.fg, gui = "bold" },

    CmpItemKindKeyword { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
    CmpItemKindMethod { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
    CmpItemKindConstructor { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },
    CmpItemKindFunction { fg = "#FFFFFF", bg = DevIconDoc.fg, gui = "bold" },

    CmpItemKindOperator { fg = "#FFFFFF", bg = DevIconFssScript.fg, gui = "bold" },
    CmpItemKindReference { fg = "#FFFFFF", bg = DevIconFssScript.fg, gui = "bold" },

    CmpItemKindSnippet { fg = "#FFFFFF", bg = SpecialKey.fg, gui = "bold" },

    CmpItemKindField { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindProperty { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindUnit { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindValue { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindVariable { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindConstant { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
    CmpItemKindTypeParameter { fg = "#FFFFFF", bg = DevIconSml.fg, gui = "bold" },
  }
end)

lush(walush)

L"nvim-ts-rainbow"
-- return to use theme colors or hi groups for other plugins
return walush


