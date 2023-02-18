
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

require("lint").linters_by_ft = {
  css = {"stylelint"},
  javascript = {"eslint"}
}

local util = require "formatter.util"
require("formatter").setup(
  {
    logging = false,
    filetype = {
      css = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      javascript = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
            stdin = true
          }
        end
      },
      json = {
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
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
    }
    }
  }
)

