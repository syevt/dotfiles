" Format json document in the current buffer
nmap <Leader>fj :%!jq<cr>

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

set langmap=й',ц\\,,у.,кp,еy,нf,гg,шc,щr,зl,х=,ї=,ґ\\\,фa,іo,вe,аu,пi,рd,оh,лt,дn,жs,є-,я\\;,чq,сj,мk,иx,тb,ьm,бw,юv
