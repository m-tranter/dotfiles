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
let g:ale_disable_lsp = 1

" plug
call plug#begin()
Plug 'ethanholz/nvim-lastplace'
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

lua require'nvim-lastplace'.setup{}

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

nnoremap x "_x
xnoremap x "_x
nnoremap <silent> <C-p> :Files<CR>
nnoremap <Space>w :write<CR>
nnoremap <Leader>a :keepjumps normal! ggVG<CR>
" use double-Esc to completely clear the search buffer
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" use space to retain the search buffer and toggle highlighting off/on
nnoremap <silent> <Space> :set hlsearch!<CR>

" paste in visual mode without overwriting register
vnoremap p "0p
vnoremap P "0P
nnoremap p "0p
nnoremap P "0P

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
let g:coc_global_extensions = ['coc-prettier',  'coc-eslint', 'coc-htmlhint', 'coc-html', 'coc-tsserver']
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
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd BufWritePre   *.js call CocAction('format')
autocmd BufWritePre   *.html call CocAction('format')
autocmd BufWritePre   *.css call CocAction('format')
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
