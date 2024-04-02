-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local custom_filetype = require("custom.configs.custom-filetype")

vim.filetype.add(custom_filetype)
