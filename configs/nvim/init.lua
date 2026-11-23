if vim.loader then
  vim.loader.enable()
end

local cache_dir = vim.fn.stdpath("cache") .. "/nvim"

if vim.fn.isdirectory(cache_dir) ~= 1 then
  vim.fn.mkdir(cache_dir, "p")
end

-- Configs
require("core.base")
require("core.keymaps")
require("plug.lazy")