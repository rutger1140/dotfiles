return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,

				null_ls.builtins.diagnostics.rubocop.with({
					command = "fish",
					args = {
						"-c",
						[[mise activate fish --shims | source; bundle exec rubocop --format json --force-exclusion --stdin $FILENAME]],
					},
					to_stdin = true,
				}),

				null_ls.builtins.formatting.rubocop.with({
					command = "fish",
					args = {
						"-c",
						[[mise activate fish --shims | source; bundle exec rubocop --auto-correct --stdin $FILENAME --stdout]],
					},
					to_stdin = true,
				}),

				require("none-ls.diagnostics.eslint_d"),
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
	end,
}
