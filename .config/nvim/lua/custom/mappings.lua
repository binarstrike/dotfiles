---@type MappingsTable
local M = {}

local cmd = function(c)
  return "<cmd>" .. c .."<cr>"
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-z>"] = { cmd("undo"), "undo change" },
    ["<C-y>"] = { cmd("redo"), "redo change" },
    ["\\"] = { cmd("call feedkeys('i')"), "enter insert mode" },
    ["|"] = { cmd("call feedkeys('v')"), "enter visual mode" },
    ["<leader>ee"] = { cmd("NvimTreeToggle"), "toggle file explorer" },
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["<C-z>"] = { cmd("undo"), "undo change" },
    ["<C-y>"] = { cmd("redo"), "redo change" },
  },
}

-- more keybinds!

return M
