local overrides = require("custom.configs.overrides")
local createCommand = vim.api.nvim_create_user_command

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"cljoly/telescope-repo.nvim",
		},
		opts = overrides.telescope,
	},

	{
		"neovim/nvim-lspconfig",
		opts = require("custom.configs.lspconfig"),
		config = function(_, opts)
			for k, v in pairs(opts) do
				require("lspconfig")[k].setup(v)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- tabout.nvim
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("tabout").setup()
		end,
	},

	-- renamer.nvim
	{
		"filipdutescu/renamer.nvim",
		event = "VeryLazy",
		config = function()
			require("custom.configs.renamer")
			createCommand("Renamer", "lua require('renamer').rename()", {})
		end,
	},

	-- toggleterm.nvim
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		opts = require("custom.configs.toggleterm"),
		config = true,
		-- config = function(_, opts)
		-- 	require("toggleterm").setup(opts)
		-- end,
	},
	--
	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
