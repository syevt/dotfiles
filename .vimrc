" This needs to be the very first line to make
" menu items in gvim to be in the correct encoding
"set langmenu=uk_UA.cp1251
"lan mes uk_UA.cp1251
set nocompatible
set encoding=utf-8
" set termguicolors
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

set clipboard=unnamed

if &term =~ '256color'
	" disable background color erase
	set t_ut=
endif

set mouse=a

call plug#begin('~/.vim/plugged')
"/ File browsing
"Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'ronakg/quickr-preview.vim'

"/ Search and replace
Plug 'rking/ag.vim'
Plug 'dkprice/vim-easygrep'

"/ Faster editing tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/loremipsum'

"/ Autocompletion
" Plug 'Valloric/YouCompleteMe'
Plug 'zxqfl/tabnine-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"/ ale - asynchronous lint engine for show errors/warnings in the gutter
Plug 'w0rp/ale'
Plug 'ngmy/vim-rubocop'

"/ Syntax support
Plug 'kchmck/vim-coffee-script'
Plug 'noc7c9/vim-iced-coffee-script'
Plug 'digitaltoad/vim-pug'
Plug 'wavded/vim-stylus'
Plug 'slim-template/vim-slim'
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Yggdroot/indentLine'
Plug 'elzr/vim-json'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'

"/ Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"/ Rspec
Plug 'thoughtbot/vim-rspec'

"/ Trying to run specs with Tslime
Plug 'jgdavey/tslime.vim'

"/ Vim status line with git branch support through vim-fugitive
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"/ Quick comment
Plug 'scrooloose/nerdcommenter'

"/ Seamless moving between vim and tmux panels
Plug 'christoomey/vim-tmux-navigator'

"/ Dispatch for starting tests in another window
" Plug 'tpope/vim-dispatch'

"/ Themes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'

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
imap ;; <esc>
vmap ;; <esc>
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
" set t_Co=256
" colorscheme Tomorrow-Night-Eighties
" let g:onedark_termcolors=256
" let g:onedark_termcolors=16
" colorscheme onedark

" let g:gruvbox_termcolors=256
let g:gruvbox_contrast_light='hard'
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_contrast_dark='soft'
set background=dark
" set background=light
let gruvbox_sign_column='bg0'
let g:gruvbox_invert_selection=0
"let g:gruvbox_italicize_comments=0
let g:gruvbox_italic=1
" let g:gruvbox_improved_strings=1
" let g:gruvbox_improved_warnings=1

" Set bindings for switching dark/light modes
nmap <Leader>bgl :set background=light<cr>
nmap <Leader>bgd :set background=dark<cr>
colorscheme gruvbox
" colorscheme wal

"---------Enable italics-----------"
set t_ZH=[3m
set t_ZR=[23m
"highlight Comment cterm=italic
hi htmlArg cterm=italic
" hi Type cterm=italic
" hi Identifier cterm=italic
hi Statement cterm=italic
" hi PreProc cterm=italic
" hi Constant cterm=italic
hi Special cterm=italic
" hi Underlined cterm=italic
" hi Ignore cterm=italic
" hi Error cterm=italic
" hi Todo cterm=italic
" hi Error cterm=italic

"/higlight line length more than 80 chars
set cc=80
"set guifont=Fira_Mono_for_Powerline:h11
set guioptions-=e
"set macligatures

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

" for rb files, 2 spaces
" autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/ts/html/css/scss files, 4 spaces
" autocmd Filetype javascript,typescript,html,css,scss setlocal ts=4 sw=4 sts=0 expandtab
" autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
" autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab

" Set folding
set foldmethod=indent
" set nofoldenable
set foldlevelstart=1

" Custom padding from the left
"hi LineNr guibg=bg
"hi LineNr ctermbg=bg
"set foldcolumn=2
"hi foldcolumn guibg=bg
"hi foldcolumn ctermbg=bg

"hi vertsplit ctermfg=white ctermbg=bg

"hi LineNr guibg=lightgrey

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

"Add simple highlight remover"
nmap <Leader><space> :nohlsearch<cr>

"Map NERDTree easier to toggle"
nmap <S-tab> :NERDTreeToggle<cr>

"Map CtrlPBufTag to open"
" nmap <c-R> :CtrlPBufTag<cr>

"Map CtrlPMRUFiles"
nmap <c-E> :CtrlPMRUFiles<cr>

"Map ,f to show ctags search"
nmap <Leader>f :tag<space>

" Show hidden files
let NERDTreeShowHidden=1

let NERDTreeRespectWildIgnore=0

" Bind ctags -R with meaningful excludings
" nmap <Leader>ct :!ctags -R --exclude=.git --exclude=log --exclude=public --exclude=tmp --exclude=node_modules<cr>
nmap <Leader>ct :!ctags -R --exclude={.git,log,public,tmp,node_modules}<cr>
" it could be worth to also have the above started on comitting using git hook

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
nmap ; :Buffers<CR>
" nmap <Leader>p :Files<CR>
" nmap ; :call fzf#vim#buffers('', fzf#vim#with_preview('right'))<CR>
nmap <Leader>p :call fzf#vim#files('', fzf#vim#with_preview('right'))<CR>

"/
"/ NERDTree
"/
"▶▼契
let g:NERDTreeWinSize=35
let NERDTreeHijackNetrw = 0
"Change +/~ toggle dir content to arrows
" let g:NERDTreeDirArrowExpandable = '契'
let g:NERDTreeDirArrowCollapsible = ''

"/
"/ Ag.vim
"/
let g:ag_working_path_mode="r"

"/
"/ Vim-Easygrep
"/
let g:EasyGrepCommand="ag"
" let g:EasyGrepFilesToExclude='*.swp,*.log,*~'
" set grepprg=ag\ --nocolor\ --nogroup\ --column
nmap <Leader>vg :Grep<space>

"/
"/ QuickFix Preview
"/
let g:quickr_preview_keymaps = 0
let g:quickr_preview_line_hl = "Underlined"
let g:quickr_preview_on_cursor = 1
let g:quickr_preview_exit_on_enter = 1
let g:quickr_preview_position = 'below'

"/
"/ YouCompleteMe
"/
let g:ycm_min_num_of_chars_for_completion = 2
let g:UltiSnipsExpandTrigger           = '<c-z>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
" Typescript
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" this one is still needed
" let g:ycm_filetype_specific_completion_to_disable = {'typescript':1}

" disable showing quickfix window on completion
set completeopt-=preview

"disable ycm errors in the gutter
let g:ycm_show_diagnostics_ui = 0

" let g:ycm_enable_diagnostic_highlighting = 0
" let g:ycm_echo_current_diagnostic = 0
"
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
"
"
"/
"/ Vim-repeat
"/
silent! call repeat#set("\<Plug>Dsurround", v:count)
silent! call repeat#set("\<Plug>Csurround", v:count)
silent! call repeat#set("\<Plug>Yssurround", v:count)

"/
"/ EasyMotion
"/
"nmap <c-;> <Plug>(easymotion-s)
nmap <Leader>s <Plug>(easymotion-s)
nmap <Leader>z <Plug>(easymotion-s2)
" hi EasyMotionTarget ctermbg=yellow ctermfg=black
" hi EasyMotionTarget guibg=yellow guifg=black
hi link EasyMotionTarget ErrorMsg

"/
" Multiple cursors
"/
"let g:multi_cursor_next_kye='<C-d>'
let g:multi_cursor_prev_key='<C-z>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<C-;>'
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
" Ale
"/
hi clear SignColumn
"Symbols for showing errors/warning are typed like
"<Ctrl-Q>u<4 unicode symbols>, these are 2326, 25cf, 25b6
"⌦ ● ▶ ⚠ ⨉      ⌧ ⌦ ╳          

"let g:ale_sign_column_always=1
"let g:ale_set_loclist=1
"let g:ale_set_quickfix=1
"let g:ale_open_list=1
nmap <silent> <A-k> <Plug>(ale_previous_wrap)
nmap <silent> <A-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format=[' %d', ' %d', 'ok']
nmap <Leader>afp :ALEFix prettier<cr>
" let g:ale_linters_ignore = {'typescript': ['eslint', 'tsilnt', 'typecheck']}
" let g:ale_linters_ignore = {'typescript': ['tslint', 'eslint']}
" let g:ale_typescript_tsserver_executable=".nodenv/shims/tsserver"
" let g:ale_typescript_tsserver_use_global=1
"/
" RuboCop
"/
nmap <Leader>r :RuboCop<cr>
"let g:vimrubocop_config = '%USERPROFILE%/rubocop.yml'

"/
" RSpec.vim mappings
"/
nmap <Leader>tt :call RunCurrentSpecFile()<cr>
nmap <Leader>ts :call RunNearestSpec()<cr>
nmap <Leader>tl :call RunLastSpec()<cr>
nmap <Leader>ta :call RunAllSpecs()<cr>

"/
" Dispatch mappings
"/
" let g:rspec_command = "Dispatch rspec {spec}"
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

"/
" Vim-Airline
"/
"       ⏽
let g:airline_theme='badwolf'
" let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
call airline#parts#define_minwidth('branch', 50)
" call airline#parts#define_minwidth('file', 90)
call airline#parts#define_minwidth('filetype', 100)
call airline#parts#define_minwidth('ffenc', 100)
" let g:airline#extensions#default#section_truncate_width = {
    " \ 'x': 90,
    " \ 'y': 90,
    " \ 'warning': 90,
    " \ 'error': 90,
    " \ }
" let g:airline#extensions#default#layout = [
    " \ [ 'a', 'b'],
    " \ [ 'z', 'error', 'warning' ]
    " \ ]

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
" let g:mkdp_path_to_chrome = "google-chrome-stable"
let g:mkdp_path_to_chrome = "palemoon"
" let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" let g:mkdp_auto_start = 0
" let g:mkdp_auto_open = 1
let g:mkdp_auto_close = 0
" let g:mkdp_refresh_slow = 0
"let g:mkdp_command_for_global = 0

"/
" Evernote / Geeknote
"/
noremap <Leader>nt :Geeknote<cr>
let g:GeeknoteMaxExplorerWidth=60
" autocmd FileType geeknote setlocal nonumber
noremap <Leader>ncb :GeeknoteCreateNotebook<space>
noremap <Leader>ncn :GeeknoteCreateNote<space>
noremap <Leader>nr :GeeknoteSync<cr>
noremap <Leader>ns :GeeknoteSearch<space>

" do not use this!!! content may be lost
" by default geeknote uses plain text - that's the trade-off for
" using evernote with vim
" let g:GeeknoteFormat="markdown"
"
"--------- Macros---------"
"/
" Ruby macros (all in normal mode)
"/
"
"Method stub with @f
let @f = '^idef ;;oend;;k$'

"Constructor stub with @i
let @i = 'odef initialize;;oend;;k$'

"Class stub with @c
let @c = '^iclass ;;oend;;k$'

"Module stub with @m
let @m = '^imodule ;;oend;;k$'

"Wrap with module macro with @w
"to make
"module Some ...  end
"to
"module Another
" module Some ... end
"end
let @w = 'Imodule ;;jVG>Goend;;'

"Add parens macro with @p
"to make method arg1, arg2 to method(arg1, arg2)
let @p = 'r(A);;'

"Add do...end block with @b
"cursor in the beginning of the new line inside block
let @b = 'a do end;;O'

"Add parameterized do...end block with @o
"cursor inside the pipes
let @o = 'a do end;;kA ||;;i'

"Add parameterized {...} block with @l
"cursor inside the pipes
let @l = 'a { || };;hhi'

"Add string array creator, for instance, to make
" $some
" $another
" $one_more
" $and_something
" TO
"'$some', '$another', '$one_more', '$and_something',
"WITH 4@a , where 4 means for 4 next lines
let @a = "I';;Ea',;;k;;"

"Add ruby hash string creator to make
" key_one value_one
" key_two value_two
" key_three value_three
" TO with 3@h (3 - for three next lines)
" 'key_one' => 'value_one', 'key_two' => 'value_two', 'key_three' => 'value_three',
let @h = "I';;Ea' =>;;wi';;Ea',;;k;;"

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
