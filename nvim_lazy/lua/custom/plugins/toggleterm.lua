return {
  {
    'akinsho/toggleterm.nvim',
    config = true,
    cmd = 'ToggleTerm',
    build = ':ToggleTerm',
    keys = { { '<leader>th', '<cmd>ToggleTerm<cr>', desc = 'Horizontal Terminal (cwd)' } },
    opts = {
      -- open_mapping = [[<leader>th]],
      direction = 'horizontal',
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
      size = 5,
      auto_scroll = true,
      winbar = {
        enabled = false,
      },
    },
  },
}
