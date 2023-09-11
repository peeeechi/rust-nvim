local keymap = vim.keymap

-- Remap space as leader key
keymap.set('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Do not yank with x or s
keymap.set('n', 'x', '"_x')
keymap.set('n', 's', '"_s')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })

-- Split window
keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })

-- Split term
keymap.set('n', '<leader>h', ':split<Return>:term<Return><S-a>', { silent = true })
keymap.set('n', '<leader>v', ':vsplit<Return>:term<Return><S-a>', { silent = true })

-- Term to normal mode
keymap.set('n', '<leader>x', ':q<Return>', { silent = true })

-- Quit window
keymap.set('t', '<C-x>', '<C-\\><C-n>', { silent = true })

-- Move window
keymap.set('', 'mh', '<C-w>h')
keymap.set('', 'mj', '<C-w>j')
keymap.set('', 'mk', '<C-w>k')
keymap.set('', 'ml', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><C-h>', '<C-w><')
keymap.set('n', '<C-w><C-j>', '<C-w>-')
keymap.set('n', '<C-w><C-k>', '<C-w>+')
keymap.set('n', '<C-w><C-l>', '<C-w>>')

keymap.set('i', 'jj', '<ESC>', {silent = true})

