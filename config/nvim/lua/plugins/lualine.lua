return {
  "nvim-lualine/lualine.nvim",
  lazy = false, -- make sure we load this during startup if it is your main lualine
  priority = 1000, -- make sure to load this before all the other start plugins
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      globalstatus = true,
      theme = 'pywal',
    },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}
