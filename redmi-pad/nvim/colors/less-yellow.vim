" kanagawa_less_yellow.vim
" Custom colorscheme inspired by Kanagawa Lotus with less saturated yellows

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "less_yellow"

" Define color palette
let s:bg = '#1f1f28'
let s:fg = '#dcd7ba'
let s:comment = '#727169'
let s:yellow = '#c6a165'       " Less saturated yellow
let s:orange = '#e78a4e'
let s:red = '#e46876'
let s:green = '#98bb6c'
let s:blue = '#7fb4ca'
let s:purple = '#a48ec7'
let s:border = '#363646'
let s:selection = '#2d2a2e'

" UI elements
hi Normal guifg=s:fg guibg=s:bg
hi CursorLine guibg=s:selection
hi CursorLineNr guifg=s:yellow guibg=s:bg
hi LineNr guifg=s:comment guibg=s:bg
hi VertSplit guifg=s:border guibg=s:bg
hi StatusLine guifg=s:fg guibg=s:border
hi StatusLineNC guifg=s:comment guibg=s:border
hi Pmenu guibg=s:border guifg=s:fg
hi PmenuSel guibg=s:selection guifg=s:yellow

" Syntax highlighting
hi Comment guifg=s:comment cterm=italic
hi Constant guifg=s:yellow
hi String guifg=s:green
hi Character guifg=s:yellow
hi Number guifg=s:orange
hi Boolean guifg=s:red
hi Identifier guifg=s:blue
hi Function guifg=s:purple
hi Statement guifg=s:red
hi Keyword guifg=s:red
hi Conditional guifg=s:red
hi Repeat guifg=s:red
hi Operator guifg=s:fg
hi PreProc guifg=s:purple
hi Type guifg=s:yellow
hi Special guifg=s:orange
hi Underlined guifg=s:blue cterm=underline

" Visual mode
hi Visual guibg=s:selection

" Search highlight
hi Search guibg=s:yellow guifg=s:bg
hi IncSearch guibg=s:orange guifg=s:bg

" Diff highlighting
hi DiffAdd guibg='#283b4d' guifg=s:green
hi DiffChange guibg='#3e445e'
hi DiffDelete guibg='#4c3a3a' guifg=s:red
hi DiffText guibg='#4f5b66'

" Git highlighting
hi GitGutterAdd guifg=s:green
hi GitGutterChange guifg=s:orange
hi GitGutterDelete guifg=s:red

