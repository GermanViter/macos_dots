return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fh", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>e", function()
				local current_win = vim.api.nvim_get_current_win()
				local neo_tree_win = vim.api.nvim_get_autocmds({
					event = "User",
					pattern = "NeoTreeWindowOpen",
				})[1] and vim.api.nvim_get_current_win() or nil

				-- Simple toggle: switch to Neo-tree if not focused, else go back
				if vim.bo.filetype == "neo-tree" then
					vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr("#")))
				else
					vim.cmd("Neotree focus")
				end
			end, { desc = "Toggle Neo-tree focus" })
		end,
	},
}
