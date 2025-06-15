return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim', -- file browser extension
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    -- Setup telescope
    telescope.setup({
      defaults = {
        file_ignore_patterns = {},
      },
      pickers = {
        find_files = {
          hidden = true, -- show dotfiles
        },
      },
      extensions = {
        file_browser = {
          hidden = true, -- show dotfiles
          respect_gitignore = false, -- ignore .gitignore, show everything
          hijack_netrw = true,
        },
      },
    })

    -- Load file_browser extension
    telescope.load_extension("file_browser")

    -- Keybindings
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fe', "<cmd>Telescope file_browser<CR>", { desc = "File Browser" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end,
}

