local status, nvim_tree = pcall(require, 'nvim-tree')
if (not status) then return end
print("nvim-tree")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  local keymap = vim.keymap

  -- custom mappings
  keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
  keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  keymap.set('n', '<leader>e', ':NvimTreeToggle<Return>', { silent = true })
end

-- empty setup using defaults
nvim_tree.setup({
  sort_by = "case_sensitive",
  on_attach = on_attach,
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
