function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end

function omap(shortcut, command)
  map('o', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

nmap('<BS>', '<C-^>')
nmap('<ESC>', ':noh<CR>')
nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')

-- TODO: moved to telescope.lua
nmap('Q', ':Telescope cmdline<CR>')
nmap('<leader>ff', ':lua require("telescope.builtin").find_files()<CR>')
nmap('<leader>fg', ':lua require("telescope.builtin").live_grep()<CR>')
nmap('<leader>fs', ':lua require("telescope.builtin").grep_string()<CR>')
nmap('<leader>fb', ':lua require("telescope.builtin").buffers()<CR>')
nmap('<leader>fh', ':lua require("telescope.builtin").help_tags()<CR>')
nmap('<leader>fm', ':lua require("telescope.builtin").marks()<CR>')

-- Colemak-DH

-- Up/Down/Left/Right
nmap('m', 'h')
xmap('m', 'h')
omap('m', 'h')

nmap('n', 'j')
xmap('n', 'j')
omap('n', 'j')

nmap('e', 'k')
xmap('e', 'k')
omap('e', 'k')

nmap('i', 'l')
xmap('i', 'l')
omap('i', 'l')

-- Words
-- l/L back word/WORD
-- u/U end of word/WORD
-- y/Y forward of word/WORD
nmap('l', 'b')
xmap('l', 'b')
omap('l', 'b')

nmap('L', 'B')
xmap('L', 'B')
omap('L', 'B')

nmap('u', 'e')
xmap('u', 'e')
omap('u', 'e')

nmap('U', 'E')
xmap('U', 'E')
omap('U', 'E')

nmap('y', 'w')
xmap('y', 'w')
omap('y', 'w')

nmap('Y', 'W')
xmap('Y', 'W')
omap('Y', 'W')

cmap('<C-L>', '<C-Left>')
cmap('<C-R>', '<C-Right>')

-- inSert/Replace/Append (T)
nmap('s', 'i')
nmap('S', 'I')
nmap('t', 'a')
nmap('T', 'A')

-- Change
nmap('w', 'c')
xmap('w', 'c')

nmap('W', 'C')
xmap('W', 'C')

nmap('ww', 'cc')

-- Cut/Copy/Paste
nmap('x', 'x')
xmap('x', 'd') -- TODO

nmap('c', 'y')
xmap('c', 'y')

nmap('v', 'p')
xmap('v', 'p')

nmap('X', 'dd')
xmap('X', 'd')

nmap('C', 'yy')
xmap('C', 'y') -- TODO

nmap('V', 'P')
xmap('V', 'P')

nmap('gv', 'gp')
xmap('gv', 'gp')

nmap('gV', 'gP')
xmap('gV', 'gP')

-- Undo/Redo
nmap('z', 'u')
xmap('z', ':<C-U>undo<CR>')

nmap('gz', 'U')
xmap('gz', ':<C-U>undo<CR>')

nmap('Z', '<C-R>')
xmap('Z', ':<C-U>redo<CR>')

-- Visual
nmap('a', 'v')
xmap('a', 'v')

nmap('A', 'V')
xmap('A', 'V')

vim.keymap.set('x', 's',
  function()
    if vim.api.nvim_get_mode().mode == 'v' then
      vim.cmd('normal! <C-V>0o$I')
    else
      vim.cmd('normal! I')
    end
  end,
  { noremap = true, silent = true, expr = true })

vim.keymap.set('x', 'S',
  function()
    if vim.api.nvim_get_mode().mode == 'v' then
      vim.cmd('normal! <C-V>0o$I')
    else
      vim.cmd('normal! I')
    end
  end,
  { noremap = true, silent = true, expr = true })
vim.keymap.set('x', 't',
  function()
    if vim.api.nvim_get_mode().mode == 'v' then
      vim.cmd('normal! <C-V>0o$A')
    else
      vim.cmd('normal! A')
    end
  end,
  { noremap = true, silent = true, expr = true })
vim.keymap.set('x', 'T',
  function()
    if vim.api.nvim_get_mode().mode == 'v' then
      vim.cmd('normal! <C-V>0o$A')
    else
      vim.cmd('normal! A')
    end
  end,
  { noremap = true, silent = true, expr = true })

-- Search
-- f/F are unchanged
nmap('p', 't')
xmap('p', 't')
omap('p', 't')

nmap('P', 'T')
xmap('P', 'T')
omap('P', 'T')

nmap('b', ';')
xmap('b', ';')
omap('b', ';')

nmap('B', ',')
xmap('B', ',')
omap('B', ',')

nmap('k', 'n')
xmap('k', 'n')
omap('k', 'n')

nmap('K', 'N')
xmap('K', 'N')
omap('K', 'N')

-- inneR text object 
omap('r', 'i') -- TODO
-- Folds
nmap('j', 'z')
xmap('j', 'z')

nmap('jn', 'zj')
xmap('jn', 'zj')

nmap('je', 'zk')
xmap('je', 'zk')

-- Overidden keys must be prefixed with g
nmap('gX', 'X')
xmap('gX', 'X')

nmap('gK', 'K')
xmap('gK', 'K')

nmap('gL', 'L')
xmap('gL', 'L')

-- Window
nmap('<C-W>m', '<C-W>h')
xmap('<C-W>m', '<C-W>h')
nmap('<C-W>n', '<C-W>j')
xmap('<C-W>n', '<C-W>j')
nmap('<C-W>e', '<C-W>k')
xmap('<C-W>e', '<C-W>k')
nmap('<C-W>i', '<C-W>l')
xmap('<C-W>i', '<C-W>l')

