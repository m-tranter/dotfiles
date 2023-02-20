vim.cmd("colorscheme gruvbox")
vim.g.user_emmet_leader_key = ","
vim.g.mapleader = ","
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
vim.api.nvim_create_autocmd(
  {"BufWritePre"},
  {
    pattern = "*.lua",
    group = mygroup,
    command = "Format"
  }
)

vim.cmd(
  [[let g:user_emmet_settings = {
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
      \}]]
)
