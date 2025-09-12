set nocompatible
set encoding=utf-8
set clipboard=unnamed
set mouse=a

call plug#begin('~/.vim/plugged')
"/ File browsing
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'qpkorr/vim-bufkill'

"/ Faster editing tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'phaazon/hop.nvim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/loremipsum'
Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/coc-tailwindcss'

"/ ale - asynchronous lint engine for show errors/warnings in the gutter
Plug 'w0rp/ale'

"/ Syntax support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hiphish/rainbow-delimiters.nvim'
Plug 'Yggdroot/indentLine'
Plug 'elzr/vim-json'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'digitaltoad/vim-pug'
Plug 'wavded/vim-stylus'

Plug 'purescript-contrib/purescript-vim'
Plug 'nwolverson/purescript-language-server'
Plug 'natefaubion/purescript-tidy'

"/ Git
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'APZelos/blamer.nvim'

"/ Test
Plug 'vim-test/vim-test'
" Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

"/ Vim status line with git branch support through vim-fugitive
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"/ Quick comment
Plug 'preservim/nerdcommenter'

"/ Seamless moving between vim and tmux panels
Plug 'christoomey/vim-tmux-navigator'

" Plug 'morhetz/gruvbox'
" Plug 'ellisonleao/gruvbox.nvim'
Plug 'luisiacc/gruvbox-baby'
Plug 'oxfist/night-owl.nvim'
Plug 'karoliskoncevicius/sacredforest-vim'
Plug 'sainnhe/everforest'
Plug 'andersevenrud/nordic.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rebelot/kanagawa.nvim'

"/ File icons
Plug 'ryanoasis/vim-devicons'

"/ Copy lines to buffer with file name and line number
Plug 'ujihisa/nclipper.vim'

"/ Vim obsession to work with tmux-resurrect
Plug 'tpope/vim-obsession'

"/ Vim md editing live preview in Chrome
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'chazy/dirsettings'

call plug#end()
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
let mapleader = ',' "Swaps default backspace leader with comma
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

" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_contrast_light='soft'

" let g:gruvbox_bold=0
" let g:gruvbox_sign_column='bg0'
" let g:gruvbox_invert_selection=0

" let g:gruvbox_baby_use_original_palette = 1
" colorscheme gruvbox-baby
" colorscheme sacredforest

" Everforest scheme
" let g:everforest_better_performance = 1
" let g:everforest_enable_italic = 1
" 0 is default
" let g:everforest_transparent_background = 0
" let g:everforest_transparent_background = 'soft'
" colorscheme everforest

" Nordic
" let g:nord_underline_option = 'none'
" let g:nord_italic = v:true
" let g:nord_italic_comments = v:false
" let g:nord_minimal_mode = v:false
" let g:nord_alternate_backgrounds = v:true
" colorscheme nordic

" Nord
" let g:nord_contrast = v:true
" let g:nord_borders = v:true
" let g:nord_disable_background = v:false
" let g:nord_italic = v:true
" let g:nord_uniform_diff_background = v:true
" let g:nord_bold = v:false
" colorscheme nord

" colorscheme gruvbox
" colorscheme night-owl
colorscheme tokyonight-moon

" colorscheme catppuccin-frappe
" colorscheme kanagawa-wave

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
let NERDTreeWinSize=150

"---------Plugins--------------"
"/
"/ fzf
"/
" hello macos :( without the next line it just doesn't work
" set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
" nmap ; :call fzf#vim#buffers()<CR>
nmap ; :FzfPreviewAllBuffersRpc<CR>

let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_use_dev_icons = 1
" nmap <Leader>p :Files!<CR>
nmap <Leader>p :FzfPreviewProjectFilesRpc<CR>
nmap <Leader>pr :FzfPreviewProjectMruFilesRpc<CR>
nmap <Leader>prw :FzfPreviewProjectMrwFilesRpc<CR>
" nmap <Leader>fh :History:<CR>
nmap <Leader>fh :FzfPreviewCommandPaletteRpc<CR>
nmap <Leader>rg :Rg<space>
" copy current buffer file path to the clipboard
nnoremap <Leader>cfp :let @+=expand('%:p')<CR>

"/
"/ NERDTree
"/
"▶▼契     洛
let g:NERDTreeWinSize=35
let NERDTreeHijackNetrw = 0
"Change +/~ toggle dir content to arrows
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
nmap <Leader>nf :NERDTreeFind<cr>

"/
"/ Coc
"/
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
" else
  " set signcolumn=yes
" endif
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"/
"/ Vim-fugitive
"/
" noremap <Leader>gs :Gstatus<cr>
" noremap <Leader>gs :Git<cr>
noremap <Leader>gs :FzfPreviewGitStatusRpc<cr>
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

nmap <silent> [l <Plug>(ale_previous_wrap)
nmap <silent> ]l <Plug>(ale_next_wrap)
" let g:ale_linters = {
" \  'javascript': ['xo'],
" \}
nmap <Leader>afp :ALEFix prettier<cr>
nmap <Leader>afb :ALEFix brittany<cr>
nmap <Leader>afh :ALEFix hindent<cr>
nmap <Leader>afe :ALEFix eslint<cr>
let b:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'purescript': ['purs-tidy', 'purescript-language-server'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'haskell': ['hindent', 'brittany'],
\}
let b:ale_linters = {
\   'purescript': ['purescript-language-server'],
\}
let g:ale_fix_on_save=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_enter=1

" let g:ale_fix_on_save_ignore=1
" let g:ale_javascript_eslint_options='-c ~/.eslintrc.json'
"
let g:ale_cursor_detail=1
let g:ale_close_preview_on_insert=1
let g:ale_floating_preview=1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

" for neovim > 0.9 this should explicitly set to "0" to show customized icons
let g:ale_use_neovim_diagnostics_api=0
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format=[' %d', ' %d', 'ok']

" this is for suppressing error messages at the end of the line
let g:ale_virtualtext_cursor = 'disabled'
" this one for suppressing error messages at the bottom
let g:ale_echo_cursor = 0


"/
" Vim-Airline
"/
" this disables the native vim's show mode ('-- INSERT --' etc.)
set noshowmode
"       ⏽
" let g:airline_theme='badwolf'
let g:airline_theme='deus'
" let g:airline_theme='gruvbox'
" let g:airline_theme='onedark'
" let g:airline_theme='base16'
" let g:airline_theme='night_owl'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_alt_sep = ''
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
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['haml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jade'] = ''

"/
" Indent lines
"/

" let g:indentLine_char_list = ['', '', '﫦', '⏽', '│', '|', '¦', '┆', '┊', '', '†', '‡', '', '', '', '', '', '', '', '', '', '']
let g:indentLine_char_list = ['₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉', '₀']
" not to let vim-json hide quotes in the current line
let g:indentLine_concealcursor=""

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

"---------Auto-Commands---------"
" Automatically source the Vimrc file on save.
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

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
