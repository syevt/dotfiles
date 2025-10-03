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
