local function executeCommand()
  local file_extension = vim.fn.expand("%:e")

  if file_extension == "java" then
    vim.api.nvim_set_keymap("n", "<F5>", ":vsplit<CR> :lua vim.cmd('wincmd l')<CR> :write <bar> terminal java %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "go" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal go run %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "sql" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal mysql -u username -p password -h localhost dbname < %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "cpp" or file_extension == "h" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal g++ -o %:r % && ./%:r<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "js" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal node %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "html" then
    vim.api.nvim_set_keymap("n", "<F5>", ':write <bar> !firefox % &<CR> :startinsert<CR><Right>', { noremap = true })
  elseif file_extension == "py" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal python3 %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "cs" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal mcs % && mono %:r.exe<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "php" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal php %<CR>:startinsert<CR>", { noremap = true })
  elseif file_extension == "lua" then
    vim.api.nvim_set_keymap("n", "<F5>", ":write <bar> terminal lua %<CR>:startinsert<CR>", { noremap = true })
  end
end
vim.keymap.set("n", "<F5>", executeCommand, { noremap = true })

local function compileExecuteCommand()
  local file_extension = vim.fn.expand("%:e")

  if file_extension == "java" then
    vim.api.nvim_set_keymap("n", "<F6>", ':vsplit<CR> :lua vim.cmd("wincmd l")<CR> :terminal rm -rf bin/* && find . -type f -name "*.class" -delete && find . -name "*.java" -exec javac -d bin {} + && java -cp bin $(find . | grep -i %:t | sed "s|\\.\\/src\\/||g" | sed "s|\\.java||g")<CR> :startinsert<CR>', {noremap = true})
  elseif file_extension == "html" then
    vim.keymap.set("n", "<F6>", function() require("live-server-nvim").start() end)
  end
end
vim.keymap.set("n", "<F6>", compileExecuteCommand, { noremap = true })
