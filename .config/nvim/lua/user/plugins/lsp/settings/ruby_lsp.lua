return {
	init_options = {
		formatter = "auto",
		linters = { "rubocop" },
		addonSettings = {
			["Ruby LSP Rails"] = {
				enablePendingMigrationsPrompt = false,
			},
		},
	},
	settings = {
		rubyLsp = {
			codeLens = true,
			inlayHints = true,
		},
	},
	root_dir = require("lspconfig").util.root_pattern("Gemfile", ".git", "config", "test", "spec"),
}
