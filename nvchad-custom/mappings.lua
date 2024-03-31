---@type MappingsTable
local M = {}

local function cmd(c)
	return "<cmd>" .. c .. "<CR>"
end

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-z>"] = { cmd("undo"), "undo" },
		["<C-y>"] = { cmd("redo"), "redo" },
		["\\"] = { "i", "enter insert mode" },
		["|"] = { "v", "enter visual mode" },
		["<leader><Tab>"] = { cmd("tabnext"), "Next window tab" },

		-- nvim-tree
		["<leader>ee"] = { cmd("NvimTreeToggle"), "Toggle nvim-tree view" },

		-- renamer.nvim
		["<F2>"] = { cmd("Renamer"), "Rename all references and symbols" },

		-- telescope
		["<leader>fg"] = { cmd("Telescope repo list"), "Find git repo" },

		-- toggleterm
		["<leader>tt"] = { cmd("ToggleTerm"), "Toggle terminal view" },
	},
	v = {
		[">"] = { ">gv", "indent" },
		["<C-z>"] = { cmd("undo"), "undo" },
		["<C-y>"] = { cmd("redo"), "redo" },

		-- renamer.nvim
		["<F2>"] = { cmd("Renamer"), "Rename all references and symbols" },
	},
	i = {
		["<C-z>"] = { cmd("undo"), "undo" },
		["<C-y>"] = { cmd("redo"), "redo" },

		-- renamer.nvim
		["<F2>"] = { cmd("Renamer"), "Rename all references and symbols" },
	},
	t = {
		["<Esc>"] = { "<C-\\><C-n><cmd>tabprevious<CR>", "Unfocus from terminal" },
	},
}

-- more keybinds!

return M
