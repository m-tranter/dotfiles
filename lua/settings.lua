vim.cmd("colorscheme gruvbox")
vim.g.mapleader = ","
vim.g.user_emmet_leader_key = ","
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.gdefault = true
vim.opt.guicursor = ""
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({I = true})
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.ttyfast = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = true

local mygroup = vim.api.nvim_create_augroup("mark", {clear = true})
vim.api.nvim_create_autocmd(
  {"BufWritePre"},
  {
    pattern = "*.html",
    group = mygroup,
    command = "Format"
  }
)
vim.api.nvim_create_autocmd(
  {"BufWritePre"},
  {
    pattern = "*.css",
    group = mygroup,
    command = "Format"
  }
)
vim.api.nvim_create_autocmd(
  {"BufWritePre"},
  {
    pattern = "*.js",
    group = mygroup,
    command = "Format"
  }
)


