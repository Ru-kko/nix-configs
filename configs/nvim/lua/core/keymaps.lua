local bind = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = "."

-- Save
bind({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", opts)

-- Close
bind("t", "<C-q>", "<cmd>q<cr>")
bind({ "n", "i", "v" }, "<C-q>", function ()
  -- Cuenta buffers listados que son archivos reales (con nombre)
  local file_buf_count = 0
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buf.name ~= "" then
      file_buf_count = file_buf_count + 1
    end
  end

  if file_buf_count <= 1 then
    vim.cmd("q")
  else
    vim.cmd("bd")
  end
end, opts)

-- Line moving
bind({ "n", "i" }, "<A-j>", "<cmd>MoveLine(1)<cr>", opts)
bind({ "n", "i" }, "<A-k>", "<cmd>MoveLine(-1)<cr>", opts)
bind("v", "<A-j>", "<cmd>MoveBlock(1)<cr>", opts)
bind("v", "<A-k>", "<cmd>MoveBlock(-1)<cr>", opts)

bind("n", "<leader>ll", ":Lazy<CR>")