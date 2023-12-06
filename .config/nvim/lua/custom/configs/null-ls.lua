local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local f = require("null-ls").builtins.formatting

return {
	debug = false,
	sources = {
		-- html, javascript, css, markdown
		f.prettier,

		-- lua
		f.stylua,

		-- Go
		f.goimports_reviser,
		f.gofumpt,
		f.golines,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ buffer = bufnr })
				end,
			})
		end
	end,
}
