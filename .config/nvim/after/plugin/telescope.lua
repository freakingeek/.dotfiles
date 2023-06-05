local status, telescope = pcall(require, 'telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

if (not status) then
  print("telescope is not installed.")
  return
end

telescope.setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      flex = {
        flip_columns = 120,
      },
    },
    sorting_strategy = 'ascending',
    file_ignore_patterns = {'node_modules/', '.git/'},
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}


vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
