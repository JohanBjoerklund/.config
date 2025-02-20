-- Make sure this is loaded befor lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- GUI
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showmode = false
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.showbreak = "↳ "
vim.wo.breakindent = true
vim.wo.cursorline = true

-- Folding
vim.opt.foldenable = false
vim.opt.foldnestmax = 1
vim.opt.foldmethod = "indent"

-- Misc
vim.opt.autoread = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.copyindent = true
vim.opt.swapfile = false
vim.opt.expandtab = true

if vim.fn.executable("rg") then
  vim.opt.grepprg = "rg --no-heading --smart-case --color=never"
end

-- Naviagion
local winnr = 1
while(winnr <= 9)
do
  vim.api.nvim_set_keymap('n', '<leader>'..winnr, ':'..winnr..'wincmd w<CR>', { noremap = true, silent = true })
  winnr = winnr + 1
end
