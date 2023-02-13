-- Plugins
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local install_plugins = false

require("packer").startup(
  function(use)
    use "mattn/emmet-vim"
    use "windwp/nvim-ts-autotag"
    use "Yggdroot/indentLine"
    use "preservim/nerdcommenter"
    use "ethanholz/nvim-lastplace"
    use "dense-analysis/ale"
    use "nvim-lualine/lualine.nvim"
    use "jiangmiao/auto-pairs"
    use "tpope/vim-surround"
    use "mhartington/formatter.nvim"
    use "wbthomason/packer.nvim"
    use "tpope/vim-fugitive"
    use "mfussenegger/nvim-lint"
    use "nvim-treesitter/nvim-treesitter"
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.1",
      requires = {{"nvim-lua/plenary.nvim"}}
    }
    use {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v1.x",
      requires = {
        {"neovim/nvim-lspconfig"}, -- Required
        {"williamboman/mason.nvim"}, -- Optional
        {"williamboman/mason-lspconfig.nvim"}, -- Optional
        {"hrsh7th/nvim-cmp"}, -- Required
        {"hrsh7th/cmp-nvim-lsp"}, -- Required
        {"hrsh7th/cmp-buffer"}, -- Optional
        {"hrsh7th/cmp-path"}, -- Optional
        {"saadparwaiz1/cmp_luasnip"}, -- Optional
        {"hrsh7th/cmp-nvim-lua"}, -- Optional
        {"L3MON4D3/LuaSnip"}, -- Required
        {"rafamadriz/friendly-snippets"} -- Optional
      }
    }
    if install_plugins then
      require("packer").sync()
    end
  end
)

if install_plugins then
  return
end

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed(
  {
    "tsserver",
    "eslint"
  }
)

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings =
  lsp.defaults.cmp_mappings(
  {
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({select = true}),
    ["<C-Space>"] = cmp.mapping.complete()
  }
)

lsp.set_preferences(
  {
    sign_icons = {}
  }
)

lsp.setup_nvim_cmp(
  {
    mapping = cmp_mappings
  }
)

lsp.on_attach(
  function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set(
      "n",
      "gd",
      function()
        vim.lsp.buf.definition()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "K",
      function()
        vim.lsp.buf.hover()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "<leader>vws",
      function()
        vim.lsp.buf.workspace_symbol()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "<leader>vd",
      function()
        vim.diagnostic.open_float()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "[d",
      function()
        vim.diagnostic.goto_next()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "]d",
      function()
        vim.diagnostic.goto_prev()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "<leader>vca",
      function()
        vim.lsp.buf.code_action()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "<leader>vrr",
      function()
        vim.lsp.buf.references()
      end,
      opts
    )
    vim.keymap.set(
      "n",
      "<leader>vrn",
      function()
        vim.lsp.buf.rename()
      end,
      opts
    )
    vim.keymap.set(
      "i",
      "<C-h>",
      function()
        vim.lsp.buf.signature_help()
      end,
      opts
    )
  end
)

lsp.setup()

require "nvim-lastplace".setup {}
require("lualine").setup(
  {
    options = {
      icons_enabled = false,
      section_separators = "",
      component_separators = ""
    }
  }
)

local builtin = require("telescope.builtin")

require "nvim-treesitter.configs".setup {
  ensure_installed = {"lua", "css", "html", "javascript"},
  sync_install = false,
  auto_install = true,
  autotag = {
    enable = true
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}

require("lint").linters_by_ft = {
  css = {"stylelint"},
  javascript = {"eslint"}
}
require("formatter").setup(
  {
    logging = false,
    filetype = {
      css = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      json = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      html = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_create_autocmd(
  {"BufWritePost"},
  {
    callback = function()
      require("lint").try_lint()
    end
  }
)

-- Settings
vim.cmd("colorscheme gruvbox")
vim.cmd [[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.js,*.css,*.html,*.lua FormatWrite
augroup END
]]

vim.g.mapleader = ","
vim.g.user_emmet_leader_key = ","
vim.o.breakindent = true
vim.o.updatetime = 50
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.expandtab = true
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
vim.opt.termguicolors = true
vim.opt.ttyfast = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.colorcolumn = "80"

-- Mappings

vim.cmd("map <ScrollWheelUp> <Nop>")
vim.cmd("map <ScrollWheelDown> <Nop>")

vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<space>w", "<cmd>write<cr>", {desc = "Save"})
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set({"v", "n", "i", "o"}, "<left>", "<Nop>")
vim.keymap.set({"v", "n", "i", "o"}, "<right>", "<Nop>")
vim.keymap.set({"v", "i", "o"}, "<down>", "<Nop>")
vim.keymap.set({"v", "i", "o"}, "<down>", "<Nop>")
vim.keymap.set("n", "<up>", "ddkP")
vim.keymap.set("n", "<down>", "ddp")
vim.keymap.set("n", "<leader>w", "<C-w>v<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>l")
vim.keymap.set("n", "<Leader>a", "ggVG<CR>")
vim.keymap.set({"n", "v", "o"}, "Q", "<Nop>")
