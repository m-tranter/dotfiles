---@diagnostic disable: undefined-global
-- vim: ts=2 sts=2 sw=2 et
vim.cmd [[let g:user_emmet_settings = {
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
      \              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n"
      \              ."\t<title>Change me</title>\n"
      \              ."</head>\n"
      \              ."<body>\n\t${child}|\n</body>\n"
      \              ."</html>",
      \    },
      \  },
      \}]]

-- Add an autocmd for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'tex', 'gitcommit' },
  callback = function()
    vim.opt_local.spell = true
  end,
})
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.user_emmet_leader_key = ','
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.gdefault = true
vim.opt.guicursor = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shortmess:append 'I'
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = 2
-- vim.opt.spell = true
vim.opt.spelllang = 'en_gb'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.ttyfast = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = true

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('', '<up>', '<nop>', { noremap = true })
vim.keymap.set('', '<down>', '<nop>', { noremap = true })
vim.keymap.set('i', '<up>', '<nop>', { noremap = true })
vim.keymap.set('i', '<down>', '<nop>', { noremap = true })
vim.keymap.set('n', '<C-down>', 'ddp', { desc = 'Move line down' })
vim.keymap.set('n', '<C-up>', 'ddkP', { desc = 'Move line up' })
vim.opt.mouse = ''

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<Leader>w', '<C-w>v', { desc = 'Vertical split' })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', '<Leader>P', '"_dP')
vim.keymap.set('x', '<Leader>p', '"_dp')
vim.keymap.set({ 'n', 'v', 'o' }, 'Q', '<Nop>')
vim.keymap.set('n', '<C-n>', '<Cmd>Neotree toggle<CR>')
vim.keymap.set('n', '<space>a', 'ggVG$', { desc = 'Select entire buffer' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
  },
  'tpope/vim-sleuth',
  'BurntSushi/ripgrep',
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        filetypes = {
          ['*'] = true,
        },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup {
        event = { 'InsertEnter', 'LspAttach' },
        fix_pairs = true,
        method = 'getCompletionsCycling',
        formatters = {
          label = function(suggestion)
            local label = suggestion.displayText
            -- Truncate very long suggestions
            if #label > 60 then
              return label:sub(1, 57) .. '...'
            end
            return label
          end,
          insert_text = require('copilot_cmp.format').format_insert_text,
          preview = require('copilot_cmp.format').deindent,
        },
      }
    end,
  },
  'mattn/emmet-vim',
  { 'windwp/nvim-ts-autotag', opts = {} },
  'norcalli/nvim-colorizer.lua',
  'ethanholz/nvim-lastplace',
  'Yggdroot/indentLine',
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').setup {
        extensions = {
          undo = {},
          ['ui-select'] = require('telescope.themes').get_dropdown(),
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension, 'ui-select')
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = 'Undo Tree' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
  { 'rust-lang/rust.vim' },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          local client = event.data and vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = function()
                if vim.fn.mode() ~= 'i' then
                  vim.lsp.buf.clear_references()
                end
              end,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local servers = {
        ruff = { filetypes = { 'python' } },
        html = { filetypes = { 'html' } },
        ts_ls = { filetypes = { 'typescript', 'javascript' } },
        volar = {
          filetypes = { 'vue' },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },
        cssls = { filetypes = { 'css' } },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
      }
      require('colorizer').setup()
      require('mason').setup()
      require('nvim-lastplace').setup {}
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 900,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        vue = { 'prettierd' },
        json = { 'prettierd' },
        python = { 'ruff_format' },
        sh = { 'shfmt' },
        rust = { 'rustfmt' },
        css = { 'stylelint' },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'kdheepak/cmp-latex-symbols',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noselect' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },

        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'copilot', priority = 900 },
          { name = 'luasnip', priority = 750 },
          { name = 'path', priority = 500 },
          { name = 'latex_symbols', priority = 400 },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            function(entry1, entry2)
              local kinds = require('cmp.types').lsp.CompletionItemKind
              local entry1_kind = entry1:get_kind()
              local entry2_kind = entry2:get_kind()
              if entry1.source.name == 'copilot' and entry2.source.name ~= 'copilot' then
                return true
              elseif entry1.source.name ~= 'copilot' and entry2.source.name == 'copilot' then
                return false
              end
              return nil
            end,
            require('cmp.config.compare').offset,
            require('cmp.config.compare').exact,
            require('cmp.config.compare').score,
            require('cmp.config.compare').kind,
            require('cmp.config.compare').sort_text,
            require('cmp.config.compare').length,
            require('cmp.config.compare').order,
          },
        },
      }
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'gruvbox'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'html' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
