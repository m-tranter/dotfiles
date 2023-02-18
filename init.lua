require("treesitter")
require("lsp")
require("other")
require("settings")
require("remap")

return require("packer").startup(
  function(use)
 use "norcalli/nvim-colorizer.lua"
    use "Yggdroot/indentLine"
    use "dense-analysis/ale"
    use "ethanholz/nvim-lastplace"
    use "jiangmiao/auto-pairs"
    use "mattn/emmet-vim"
    use "mfussenegger/nvim-lint"
    use "mhartington/formatter.nvim"
    use "nvim-lualine/lualine.nvim"
    use "preservim/nerdcommenter"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "windwp/nvim-ts-autotag"
    use "wbthomason/packer.nvim"
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
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
  end
)
