return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "Telescope" }, -- Load when the `Telescope` command is used
		config = function()
			-- Setup Telescope with the specified commands
			require("telescope").setup({
				defaults = {
					-- Display path without leading './'
					path_display = function(_, path)
						return path:gsub("^%./", "")
					end,
				},
			})
		end,
		keys = { -- Load on these key mappings
			{
				"<C-p>",
				function()
					require("telescope.builtin").find_files({
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob=!.git/**",
							"--glob=!node_modules/**",
							"--glob=!tmp/**",
						},
					})
				end,
				{ noremap = true, silent = true },
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({
						additional_args = function()
							return { "--hidden" }
						end,
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--glob=!.git/**",
							"--glob=!node_modules/**",
							"--glob=!tmp/**",
						},
					})
				end,
				{ noremap = true, silent = true },
			},
		},
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
