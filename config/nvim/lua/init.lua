require "config.settings"
require "config.lazy"
require "config.keymaps"
require "config.abbreviations"
require "config.executionPrograms"

-- Colorscheme
vim.o.termguicolors = true
require("bufferline").setup{}
require 'colorizer'.setup{}
