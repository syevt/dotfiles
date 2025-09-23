set nocompatible
set encoding=utf-8
set clipboard=unnamed
set mouse=a

map <Leader>zzz :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

" Set cursor shape depending on mode

"this will higlight the whole line
autocmd InsertEnter,InsertLeave * set cul!

let &t_SI = "\e[3 q"
let &t_EI = "\e[1 q"
" optional reset cursor on start:
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[1 q"
augroup END
" Other options (replace the number after \e[):
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).

" We don't need this when using treesitter
" syntax enable

"set listchars+=space:␣
" I guess, setting '...,space:...' here makes 'set lcs+=space:...' obsolete
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=tab:>·,trail:~,extends:>,precedes:<
set list
" this one shows spaces with dots
" set lcs+=space:·
" let mapleader = ',' "Swaps default backspace leader with comma
set number      "Let's activate line numbers
set complete=.,w,b,u  "Set desired autocompletion options

"---------Switching between modes-----------"
" Switch to normal mode by double ;;
imap << <esc>
vmap << <esc>

"---------Ignored files and folders---------"
set wildignore+=*\\tmp\\*,*\\node_modules\\*,*.swp,*.log,*.zip,*.exe  " Windows
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.log,*.zip     " MacOSX/Linux

"---------Visuals-------"
set termguicolors

" Nordic
let g:nord_underline_option = 'none'
let g:nord_italic = v:true
let g:nord_italic_comments = v:true
let g:nord_minimal_mode = v:false
let g:nord_alternate_backgrounds = v:true
colorscheme nordic
"---------Enable italics-----------"
set t_ZH=[3m
set t_ZR=[23m

"/higlight line length more than 80 chars
set cc=80
set guioptions-=e

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Set indentation
" by default, the indent is 2 spaces.
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
set expandtab
set smartindent


" Set folding
set foldmethod=indent
set nofoldenable
" set foldlevelstart=1

"---------Search---------"
set hlsearch
set incsearch
set ignorecase smartcase                "For case-insensitive search

"---------Split Management---------"
set splitbelow
set splitright

"---------Mappings---------"

" Format json document in the current buffer
nmap <Leader>fj :%!jq<cr>

"Add simple highlight remover"
nmap <Leader><space> :nohlsearch<cr>

" copy current buffer file path to the clipboard
nnoremap <Leader>cfp :let @+=expand('%:p')<CR>

noremap <Leader>gco :Git checkout<space>
noremap <Leader>gb :Gblame<cr>
noremap <Leader>gd :Gvdiff<Space>
noremap <Leader>gd3 :Gdiffsplit!<cr>
noremap <Leader>ge :Gedit<cr>
noremap <Leader>gw :Gwrite<cr>
noremap <Leader>gwf :Gwrite!<cr>
noremap <Leader>gr :Gread<cr>
noremap <Leader>ge :Gedit<cr>
noremap <Leader>gu :Gdiffupdate<cr>
noremap <Leader>gh :0Gclog<cr>
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

"/
"/ Git signs
"/
lua require('gitsigns').setup({
\  current_line_blame = false,
\})
noremap <Leader>gph :Gitsigns preview_hunk<cr>
noremap <Leader>grh :Gitsigns reset_hunk<cr>

"/
"/ Git blamer
"/
noremap <Leader>gbt :BlamerToggle<cr>
let g:blamer_template = '<author>, <committer-time> - <summary>'
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = '>>> '
let g:blamer_date_format = '%d.%m.%y %H:%M'

"/
"/ Vim-repeat
"/
silent! call repeat#set("\<Plug>Dsurround", v:count)
silent! call repeat#set("\<Plug>Csurround", v:count)
silent! call repeat#set("\<Plug>Yssurround", v:count)

"/
"/ Hop (EasyMotion)
"/
nmap <Leader>s :HopChar1<cr>
nmap <Leader>z :HopChar2<cr>

hi link HopNextKey WarningMsg
" hi HopNextKey guifg=Red guibg=Grey
" hi link HopNextKey1 ctermbg=red ctermfg=yellow
" hi link HopNextKey2 ctermbg=red ctermfg=yellow
hi link HopNextKey1 WarningMsg
hi link HopNextKey2 WarningMsg
lua require'hop'.setup()

"/
" Multiple cursors
"/
let g:multi_cursor_prev_key='<C-z>'
le=t= g:multi_cursor_quit_key='<C-e>'

"/
" Tree Sitter
"/
" One may use `heredoc` with lua configs like
" https://github.com/nvim-lualine/lualine.nvim#configuring-lualine-in-initvim
" lua << END
" require('lualine').setup()
" END
" but that spoils vim syntax highlighting down the file
lua require'nvim-treesitter.configs'.setup{
\  auto_install = true,
\
\  highlight = {
\    enable = true,
\    disable = function(lang, buf)
\      local max_filesize = 100 * 1024
\      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
\      if ok and stats and stats.size > max_filesize then
\        return true
\      end
\    end,
\
\  additional_vim_regex_highlighting = false,
\  },
\}

let g:rainbow_delimiters = {
  \ 'strategy': {
    \ '': rainbow_delimiters#strategy.global,
    \ 'vim': rainbow_delimiters#strategy.local,
  \ },
  \ 'query': {
      \ '': 'rainbow-delimiters',
      \ 'lua': 'rainbow-blocks',
\ },
  \ 'highlight': [
      \ 'RainbowDelimiterViolet',
      \ 'RainbowDelimiterGreen',
      \ 'RainbowDelimiterYellow',
      \ 'RainbowDelimiterBlue',
\ 'RainbowDelimiterCyan',
      \ 'RainbowDelimiterOrange',
      \ 'RainbowDelimiterRed',
  \ ],
\ }

"/
" TypeScript syntax
"/
let g:typescript_ignore_browserwords=0

"/
" Haskell syntax
"/
let g:haskell_classic_highlighting=1
let g:haskell_indent_disable=1

"/
" JSDoc
"/
nmap <silent> <Leader>jd <Plug>(jsdoc)
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_enable_es6=1

"/
" Nclipper
"/
" let g:nclipper_nomap = 1
vmap <c-Y> <Plug>(nclipper-with-filename)

"/
" Markdown
"/
nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>ms <Plug>MarkdownPreviewStop
let g:mkdp_command_for_global = 1
let g:mkdp_browser = 'vivaldi-stable'
" Enable spellcheck for markdown and gitcommit files
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell

"---------Custom Syntax Highlights---------"
" 'gui=italic' or 'cterm=italic'
" 'guifg', 'guibg', 'ctermfg', 'ctermbg'

" This is for `gruvbox`, comment out for any other theme. 'night-owl', for
" instance, have those italics out of the box and doesn't need the tweaks
" below.
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" hi htmlArg gui=italic

" 'return' should pop up from the code, so giving 'em italic explicitly
" without changing the syntax plugin file
" hi Statement gui=italic guifg=red

" hi typescriptImport gui=italic guifg=#458588
" hi typescriptExport gui=italic guifg=#458588
" hi tsxAttrib gui=italic guifg=#fabd2f
" hi Comment gui=italic
" " hi GruvboxBg0 guibg=NONE ctermbg=NONE

" this is for transparency
" hi Normal guibg=NONE ctermbg=NONE

" hi GruvboxGreenSign guibg=NONE ctermbg=NONE
" hi GruvboxAquaSign guibg=NONE ctermbg=NONE
" hi GruvboxRedSign guibg=NONE ctermbg=NONE
" hi GruvboxYellowSign guibg=NONE ctermbg=NONE
" hi GruvboxBlueSign guibg=NONE ctermbg=NONE
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" this is for the night-owl theme
" this is for transparency
" hi ALEWarningSign ctermfg=4 ctermbg=0 guibg=none guifg=DarkYellow

" set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\\;,є',ґ\\,яz,чx,сc,мv,иb,тn,ьm,ю.,./,ЙQ,ЦW,УE,КR,ЕT,НY,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\:,Є\\",Ґ<bar>,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю>,№#
set langmap=й',ц\\,,у.,кp,еy,нf,гg,шc,щr,зl,х=,ї=,ґ\\\,фa,іo,вe,аu,пi,рd,оh,лt,дn,жs,є-,я\\;,чq,сj,мk,иx,тb,ьm,бw,юv

" Notes and Tips
" - Press 'zz' to instantly center the line where the cursor is located.
" - Press 'Ctrl+]' to go to the method's under the cursor definition
" - Press 'Ctrl+^' to go to the previous cursor position
"
" folding shortcuts
" zo -> open fold under cursor
" zO -> open all folds under cursor
" zc -> close...
" zC -> close all ...
" za -> toggle open/close
" zA -> toggle all open/close under cursor
" zm -> increase fold level by 1
" zM -> close all open folds
" zr -> decrease fold level by 1
" zR -> decrease fold level to 0 (all folds open)
"
" vim-surround
" "Hello world!" -> cs"' -> 'Hello world!'
" -> cs'<q> -> <q>Hello world!</q>
" -> cst" -> "Hello world!" ('t' - means 'tag'?)
" -> ds" -> Hello world!
" with the cursor on "Hello" -> ysiw] (iw is a text object) -> [Hello] world!
" make that braces and add some space (use } instead of { for no space):
" -> cs]{ -> { Hello } world!
" wrap the entire line in parentheses with -> yssb or yss) -> ({ Hello } world!)
" revert to the original text -> ds{ds) -> Hello world!
" emphasize hello: -> ysiw<em> -> <em>Hello</em> world!
" visual mode: Press a capital V (for linewise visual mode)
" followed by -> S<p class="important"> gives
" <p class="important">
  " <em>Hello</em> world!
" </p>
" THE SAME APPLIES TO ANY SELECTED TEXT, NOT NECESSARILY FOR A LINE
"
" ctags quick access
" Ctrl+] -> go to method/class definition under cursor
" Ctrl+6 -> go to the previous cursor position after that

" toggle case
" ~ -> on visually selected toggles case or toggles current character
" U -> on visually selected makes it uppercase
" u -> lower case
" 3~ -> toggles case of the next 3 chars
" g~3w -> toggles next 3 words
" g~iw -> toggles current(inside) word
" gUU -> current line to uppercase, same as VU
" guu -> current line to lowercase, same as Vu
