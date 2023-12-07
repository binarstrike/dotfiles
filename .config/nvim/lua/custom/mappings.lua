---@type MappingsTable
local M = {}

local function cmd(c)
	return "<cmd>" .. c .. "<cr>"
end

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-z>"] = { cmd("undo"), "undo" },
		["<C-y>"] = { cmd("redo"), "redo" },
		["\\"] = { cmd("call feedkeys('i')"), "enter insert mode" },
		["|"] = { cmd("call feedkeys('v')"), "enter visual mode" },
		["<leader>ee"] = { cmd("NvimTreeToggle"), "toggle nvim-tree view" },
		["<F2>"] = { cmd("Rename"), "rename all references" },
	},
	v = {
		[">"] = { ">gv", "indent" },
		["<C-z>"] = { cmd("undo"), "undo" },
		["<C-y>"] = { cmd("redo"), "redo" },
		["<F2>"] = { cmd("Rename"), "rename all references" },
	},
	i = {
		["<F2>"] = { cmd("Rename"), "rename all references" },
	},
}

-- more keybinds!

return M
