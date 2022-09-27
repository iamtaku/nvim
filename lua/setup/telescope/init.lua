local mappings = require("setup.telescope.mappings")

require("telescope").setup({
	defaults = {
		mappings = mappings,
		file_ignore_patterns = { "node_modules" },
	},
})
