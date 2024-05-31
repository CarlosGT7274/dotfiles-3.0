return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- add nord
  { "gbprod/nord.nvim" },
  -- add dracula
  { "Mofiqul/dracula.nvim" },
  -- add and set pywalTheme
  {
    "AlphaTechnolog/pywal.nvim",
  	lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() -- load the colorscheme here
		vim.cmd([[colorscheme pywal]])
	end,
  },
}
