color gruvbox
let mapleader=","
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=80
set cursorline
set expandtab
set foldlevel=99
set foldmethod=indent
set gdefault
set hidden
set history=10
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set nobackup
set nocompatible
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler
set shiftwidth=2
set shortmess=atI
set showcmd
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set t_Co=256
set tabstop=2
set ttyfast
set updatetime=300
set modelines=0
set vb
filetype off
filetype plugin indent on

" plug
call plug#begin()
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'rust-lang/rust.vim'
call plug#end()

" Settings for integrated terminal. 
set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal()
  split term://bash
  resize 5
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" mappings
nnoremap <silent> <C-p> :Files<CR>

" use double-Esc to completely clear the search buffer
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" use space to retain the search buffer and toggle highlighting off/on
nnoremap <silent> <Space> :set hlsearch!<CR>

" paste in visual mode without overwriting register
vnoremap p "0p
vnoremap P "0P

ino <up> <Nop>
ino <down> <Nop> 
ino <left> <Nop>
ino <right> <Nop>

no <up> ddkP 
no <down> ddp
no <left> <Nop>
no <right> <Nop>

vno <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>

"This is if you want to move by visual lines.
"nnoremap j gj
"nnoremap k gk
"inoremap <F1> <ESC>
"nnoremap <F1> <ESC>
"vnoremap <F1> <ESC>
inoremap jj <ESC>

" Easier management of splits.
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" COC settings
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
autocmd BufWritePre   *.js call CocAction('format')
autocmd BufWritePre   *.html call CocAction('format')
autocmd BufWritePre   *.css call CocAction('format')
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"Emmett key
let g:user_emmet_leader_key=','
" Emmett snippet things
let g:user_emmet_settings = {
      \  'variables': {'lang': 'en'},
      \  'html': {
      \    'default_attributes': {
      \      'option': {'value': v:null},
      \      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
      \    },
      \    'snippets': {
      \      'html:5': "<!DOCTYPE html>\n"
      \              ."<html lang=\"${lang}\">\n"
      \              ."<head>\n"
      \              ."\t<meta charset=\"${charset}\"/>\n"
      \              ."\t<link rel=\"stylesheet\" href=\"\"/>\n"
      \              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n"
      \              ."\t<title></title>\n"
      \              ."</head>\n"
      \              ."<body>\n\t${child}|\n</body>\n"
      \              ."</html>",
      \    },
      \  },
      \}


" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!
  autocmd FileType text setlocal wrap
  autocmd FileType text setlocal nolist
  autocmd FileType text setlocal linebreak 
augroup END


let g:closetag_filenames = '*.html,*.js,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,js,phtml'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ 'typescriptreact': 'jsxRegion,tsxRegion',
      \ 'javascriptreact': 'jsxRegion',
      \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

set mouse-=a
