local cmp_ai = require("cmp_ai.config")

cmp_ai:setup({
	max_lines = 5,
	provider = "Ollama",
	provider_options = {
		model = "codellama:7b-code",
		auto_unload = false,
	},
	run_on_every_keystroke = false,
	ignored_file_types = {
		markdown = true,
	},
})
