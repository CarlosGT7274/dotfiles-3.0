vim.g.mapleader = " "
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.showmode = false
vim.o.ruler = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.scrolloff = 999
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.opt.formatoptions = vim.opt.formatoptions
  - "t" -- No autoformatting based on `textwidth`
  - "a" -- No autoformatting, AGAIN.
  - "o" -- o / O do not continue comments if launched from within them.
  - "2" -- Not in gradeschool ;)
  + "r" -- But Enter in Insertmode does.
  + "n" -- Do recognize numbered lists.
  + "c" -- But I do like when comments respect textwidth :D
  + "j" -- Autoremove comments if possible.
