return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Configuratie voor telescope met aangepaste find_command
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!.git/",
					},
					prompt_prefix = "> ",
					selection_caret = "> ",
					path_display = { "smart" },
				},
			})

			vim.keymap.set("n", "<C-p>", function()
				builtin.find_files({ search_dirs = { vim.fn.getcwd() } })
			end, { desc = "Find files" })

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
