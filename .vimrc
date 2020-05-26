set nocompatible
set encoding=utf-8
set clipboard=unnamed
if &term =~ '256color'
  set t_ut=
endif
set mouse=a

call plug#begin('~/.vim/plugged')
"/ File browsing
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'qpkorr/vim-bufkill'

"/ Search and replace
Plug 'dyng/ctrlsf.vim'

"/ Faster editing tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/loremipsum'

"/ Typescript
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
" Plug 'ryanolsonx/vim-lsp-typescript'

"/ Autocompletion
" Plug 'Valloric/YouCompleteMe'
" Plug 'zxqfl/tabnine-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"/ ale - asynchronous lint engine for show errors/warnings in the gutter
Plug 'w0rp/ale'

"/ Syntax support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Yggdroot/indentLine'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'heavenshell/vim-jsdoc'

"/ Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"/ Vim status line with git branch support through vim-fugitive
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"/ Quick comment
Plug 'scrooloose/nerdcommenter'

"/ Seamless moving between vim and tmux panels
Plug 'christoomey/vim-tmux-navigator'

Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

"/ File icons
Plug 'ryanoasis/vim-devicons'

"/ Copy lines to buffer with file name and line number
Plug 'ujihisa/nclipper.vim'

"/ Vim obsession to work with tmux-resurrect
Plug 'tpope/vim-obsession'

"/ Vim md editing live preview in Chrome
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

"/ Evernote with vim-geeknote
Plug 'neilagabriel/vim-geeknote'

call plug#end()

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

syntax enable
"set listchars+=space:␣
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set list
set lcs+=space:·
let mapleader = ',' "Swaps default backspace leader with comma
set number      "Let's activate line numbers
set complete=.,w,b,u  "Set desired autocompletion options

"---------Switching between modes-----------"
" Switch to normal mode by double ;;
imap << <esc>
vmap << <esc>
"
"---------Inserting new line without entering the insert mode-----------"
" nmap <S-Enter> O<esc> " Shift-, Ctrl- and just Enter seem to work as the
" mere Enter
" nmap <cr> o<esc> "removed as it interferes opening files in quickfix by
" Enter

"---------Ignored files and folders---------"
set wildignore+=*\\tmp\\*,*\\node_modules\\*,*.swp,*.log,*.zip,*.exe  " Windows
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.log,*.zip     " MacOSX/Linux

"---------Visuals-------"

let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='medium'
set background=dark
let gruvbox_sign_column='bg0'
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1

" Set bindings for switching dark/light modes
nmap <Leader>bgl :set background=light<cr>
nmap <Leader>bgd :set background=dark<cr>
colorscheme gruvbox

"---------Enable italics-----------"
set t_ZH=[3m
set t_ZR=[23m
hi htmlArg cterm=italic
hi Statement cterm=italic
hi Special cterm=italic

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
set foldlevelstart=1

"---------Search---------"
set hlsearch
set incsearch
set ignorecase smartcase                "For case-insensitive search

"---------Split Management---------"
set splitbelow
set splitright

nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-l> <C-w><C-l>

"---------Mappings---------"

" Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Format json document in the current buffer
nmap <Leader>fj :%!jq<cr>

"Add simple highlight remover"
nmap <Leader><space> :nohlsearch<cr>

"Map NERDTree easier to toggle"
nmap <S-tab> :NERDTreeToggle<cr>
nmap <Leader>nf :NERDTreeFind<cr>

"Map CtrlPMRUFiles"
nmap <c-E> :CtrlPMRUFiles<cr>

" Show hidden files
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=0

"---------Plugins--------------"
"/
"/ CtrlP
"/
let g:ctrlp_custom_ignore = '\tmp\node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:30'
" the next is used to autoreload newly added files
" i.e. with the help of Rails generators
" no need to press F5
let g:ctrlp_use_caching=0
let g:ctrlp_user_command = 'ag --nogroup --nobreak --noheading --nocolor -g "" %s '

"/
"/ fzf
"/
" hello macos :( without the next line it just doesn't work
set rtp+=/usr/local/opt/fzf
nmap ; :call fzf#vim#buffers()<CR>
nmap <Leader>p :Files!<CR>
nmap <Leader>fh :History:<CR>
" copy current buffer file path to the clipboard
nnoremap <Leader>cfp :let @+=expand('%:p')<CR>

"/
"/ NERDTree
"/
"▶▼契
let g:NERDTreeWinSize=35
let NERDTreeHijackNetrw = 0
"Change +/~ toggle dir content to arrows
" let g:NERDTreeDirArrowExpandable = '契'
let g:NERDTreeDirArrowCollapsible = ''
nmap <Leader>nf :NERDTreeFind<cr>

"/
"/ CtrlSF
"/
nmap <Leader>vg :CtrlSF<space>
nmap <Leader>vt :CtrlSFToggle<cr>
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_preview = 1

"/
"/ Lsp
"/
nmap gd :LspDefinition<cr>
nmap <Leader>lnd :LspNextDiagnostic<cr>
nmap <Leader>lpd :LspPreviousDiagnostic<cr>
nmap <Leader>lh :LspHover<cr>
nmap <Leader>la :LspCodeAction<cr>
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''}
let g:lsp_signs_hint = {'text': ''}
let g:lsp_diagnostics_echo_cursor = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

"/
"/ Vim-fugitive
"/
noremap <Leader>gs :Gstatus<cr>
noremap <Leader>gb :Gblame<cr>
noremap <Leader>gd :Gvdiff<cr>
noremap <Leader>ge :Gedit<cr>
noremap <Leader>gw :Gwrite<cr>
noremap <Leader>gwf :Gwrite!<cr>
noremap <Leader>gr :Gread<cr>
noremap <Leader>ge :Gedit<cr>
noremap <Leader>gu :Gdiffupdate<cr>
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

"/
"/ Vim-repeat
"/
silent! call repeat#set("\<Plug>Dsurround", v:count)
silent! call repeat#set("\<Plug>Csurround", v:count)
silent! call repeat#set("\<Plug>Yssurround", v:count)

"/
"/ EasyMotion
"/
nmap <Leader>s <Plug>(easymotion-s)
nmap <Leader>z <Plug>(easymotion-s2)
hi link EasyMotionTarget ErrorMsg

"/
" Multiple cursors
"/
let g:multi_cursor_prev_key='<C-z>'
let g:multi_cursor_quit_key='<C-e>'

"/
" TypeScript syntax
"/
let g:typescript_ignore_browserwords=0

"/
" Vue syntax
"/
let g:vue_pre_processors = 'detect_on_enter'

"/
" JSDoc
"/
nmap <silent> <Leader>jd <Plug>(jsdoc)
let g:jsdoc_allow_input_prompt=1
let g:jsdoc_enable_es6=1

"/
" Ale
"/
hi clear SignColumn
"Symbols for showing errors/warning are typed like
"<Ctrl-Q>u<4 unicode symbols>, these are 2326, 25cf, 25b6
"⌦ ● ▶ ⚠ ⨉      ⌧ ⌦ ╳          

nmap <silent> <A-k> <Plug>(ale_previous_wrap)
nmap <silent> <A-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format=[' %d', ' %d', 'ok']
nmap <Leader>afp :ALEFix prettier<cr>
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\}
let g:ale_fix_on_save = 1

"/
" Vim-test
"/
nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>ts :TestSuite<CR>
nmap <Leader>tl :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>
let test#strategy = "tslime"

"/
" Vim-Airline
"/
"       ⏽
" let g:airline_theme='badwolf'
let g:airline_theme='deus'
" let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#fnamemod = ':p:~'
let g:airline#extensions#tabline#fnamecollapse = 0
call airline#parts#define_minwidth('branch', 50)
call airline#parts#define_minwidth('filetype', 100)
call airline#parts#define_minwidth('ffenc', 100)

function! AirlineInit()
  let g:airline_skip_empty_sections = 1
  let g:airline_section_b = airline#section#create(['branch', ' ', 'hunks'])
  let g:airline_symbols.branch = ''
  " let g:airline_section_z = airline#section#create(['%3p%% ', ' %l', 'maxlinenr', ' : %c', ' '])
  let g:airline_section_z = airline#section#create(['%3p%% ', ' %l', 'maxlinenr', ' : %c', ' ', '%{ObsessionStatus('' '', '''')}'])
endfunction

autocmd User AirlineAfterInit call AirlineInit()
" autocmd VimEnter * call AirlineInit()

"/
" NerdCommenter
"/
" Add one space after comment symbol
let g:NERDSpaceDelims = 1

"/
" Vim-devicons
"/
"
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
"
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:DevIconsDefaultFolderOpenSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['gemfile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['gemfile.lock'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['config.ru'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['rakefile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['haml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jade'] = ''

"/
" Indent lines
"/

" let g:indentLine_char='▏'
let g:indentLine_char='│'
" not to let vim-json hide quotes in the current line
let g:indentLine_concealcursor=""

"/
" Nclipper
"/
let g:nclipper_nomap = 1
vmap <c-Y> <Plug>(nclipper-with-filename)

"/
" Markdown
"/
nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>ms <Plug>StopMarkdownPreview
let g:mkdp_path_to_chrome = "palemoon"
let g:mkdp_auto_close = 0

"/
" Evernote / Geeknote
"/
noremap <Leader>nt :Geeknote<cr>
let g:GeeknoteMaxExplorerWidth=60
noremap <Leader>ncb :GeeknoteCreateNotebook<space>
noremap <Leader>ncn :GeeknoteCreateNote<space>
noremap <Leader>nr :GeeknoteSync<cr>
noremap <Leader>ns :GeeknoteSearch<space>

"--------- Macros---------"
"Add macro for adding capitalized key to json (for angular-translate)
"making this
"some_key
"to this
"SOME_KEY": \"", (slash is for escaping inside .vimrc)
" let @k = 'gUiwi";;Ea": "",;;h'
" without upper case
let @k = 'Bi";;Ea": "",;;h'

"Macro for adding a corresponding translation key in a view
"making this
"some_key
"to this
"{{ 'SOME_KEY' | translate }}
" let @t = \"gUiwi{{ ';;Ea' | translate }};;"
" without upper case
let @t = "Bi{{';;Ea' | translate}};;"

"Macro for adding i18n translation for a key making
"soMe_KEy
"to
"= t('.some_key')
let @n = "guiwBXi= t('.;;A');;"


"---------Auto-Commands---------"
" Automatically source the Vimrc file on save.
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

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
