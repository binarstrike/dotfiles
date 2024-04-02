local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require("lspconfig/util")
local lspconfig = require("lspconfig")

local lsp = {}

-- if you just want default config for the servers then put them in a table

local servers = {
	"html",
	"cssls",
	"tsserver",
	"clangd",
	"pyright",
	"bashls",
	"dockerls",
	"docker_compose_language_service",
}

for _, v in ipairs(servers) do
	lspconfig[v].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- lsp.gopls = {
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
			["ui.inlayhint.hints"] = {
				compositeLiteralFields = true,
				constantValues = true,
				parameterNames = true,
			},
		},
	},
})

return lsp
