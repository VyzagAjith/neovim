vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end)
-- Horizontal terminal
vim.keymap.set("n", "<leader>th", ":belowright split | terminal<CR>", { desc = "Terminal horizontal" })
-- Vertical terminal
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal vertical" })
-- Exit terminal mode back to normal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
-- Close terminal with <leader>q (in terminal mode)
vim.keymap.set("t", "<leader>q", [[<C-\><C-n>:close<CR>]], { noremap = true, silent = true, desc = "Close terminal" })
-- Close terminal with <leader>q (in normal mode, too)
vim.keymap.set("n", "<leader>q", ":close<CR>", { noremap = true, silent = true, desc = "Close window" })

--To compile and run the code (currently c, cpp and py)
vim.keymap.set("n", "<leader>r", function()
  local filetype = vim.bo.filetype
  local file = vim.fn.expand("%:t")
  local filepath = vim.fn.expand("%:p")
  local output = vim.fn.expand("%:t:r")
  local dir = vim.fn.expand("%:p:h")

  vim.cmd("w") -- Save file

  -- Open terminal only if not already open (reuses existing one)
  local term_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      term_win = win
      break
    end
  end

  if not term_win then
    vim.cmd("botright split | resize 15 | terminal")
  end

  local cmd
  if filetype == "c" then
    cmd = string.format("cd %s && gcc -g %s -o %s && ./%s\n", dir, file, output, output)
  elseif filetype == "cpp" then
    cmd = string.format("cd %s && g++ -g %s -o %s && ./%s\n", dir, file, output, output)
  elseif filetype == "python" then
    cmd = string.format("cd %s && python3 %s\n", dir, file)
  else
    print("Unsupported filetype: " .. filetype)
    return
  end

  -- Send to terminal
  vim.fn.chansend(vim.b.terminal_job_id or 0, cmd)
end, { desc = "Run C/C++/Python", silent = true })

--To switch between windows 
vim.keymap.set("n", "<leader>t<Up>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<leader>t<Down>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<leader>t<Left>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<leader>t<Right>", "<C-w>l", { desc = "Move to window right" })

