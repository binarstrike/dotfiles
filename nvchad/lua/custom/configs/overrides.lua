local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"markdown",
		"markdown_inline",
		"go",
		"gomod",
		"dockerfile",
		"prisma",
		"bash",
		"tmux",
		"hyprlang",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		"lua-language-server",
		"stylua",
		"prettier",

		-- go language server and formatter
		"golines",
		"gopls",
		"goimports-reviser",
		"gofumpt",

		"dockerfile-language-server",
		"docker-compose-language-service",
		"html-lsp",
		"css-lsp",
		"typescript-language-server",
		"pyright",
		"clangd",
		"bash-language-server",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
		ignore = false,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.telescope = function()
	local opts = require("plugins.configs.telescope")

	opts.extensions = {
		repo = {
			list = {
				search_dirs = {
					vim.env.HOME .. "/Documents/REPO",
				},
			},
		},
	}

	table.insert(opts.extensions_list, "repo")
	return opts
end

return M
