function SetupAbbreviations()
  local file_extension = vim.fn.expand('%:e')
    if file_extension == 'java' then
      vim.api.nvim_set_keymap('i', 'inic<CR>', string.format("public class %s {<CR>}<Esc>O", vim.fn.expand("%:t:r")), { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'cons<CR>', string.format("public %s () {<CR>}<Esc>O", vim.fn.expand("%:t:r")), { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'psvm<CR>', 'public static void main(String[] args) {<CR>}<Esc>O', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'sout<CR>', 'System.out.println("");<Left><Left><Left>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'tost<CR>', '@Override<CR>public String toString(){<CR>return ;<CR>}<Up><Esc>A<Left>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'fori<CR>', ' for (int i = 0; i < ; i++) {<CR>}<Esc>O', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'ifi<CR>', 'if () {<CR>}<Esc>O', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'elif<CR>', 'else if () {<CR>}<Esc>O', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', 'else<CR>', 'else {<CR>}<Esc>O', { noremap = true, silent = true })
    elseif file_extension == 'py' then
      vim.api.nvim_set_keymap('i', 'print<CR>', 'print("");<Left><Left><Left>', { noremap = true, silent = true })
    elseif file_extension == 'html' then
      vim.api.nvim_set_keymap('i', '!<CR>', '<!DOCTYPE html><CR><html lang="es"><CR><head><CR><meta charset="UTF-8"><CR><title></title><CR></head><CR><body><CR><space><CR></body><CR></html><Esc>5<Up>4<Right>a', { noremap = true, silent = true })
  end
end

vim.api.nvim_exec([[autocmd BufEnter * lua SetupAbbreviations()]], false)
