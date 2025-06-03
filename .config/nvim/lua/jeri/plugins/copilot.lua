-- File: lua/jeri/plugins/copilot.lua
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				auto_trigger = true,
			},
			panel = {
				enabled = true,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom",
					ratio = 0.4,
				},
			},
			filetypes = {
				["*"] = true,
				-- Example: disable for yaml
				-- yaml = false,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},

	-- OPTIONAL BUT HIGHLY RECOMMENDED: For nvim-cmp integration
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {}, -- Use default configuration
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)

			-- If you manually configure nvim-cmp, ensure 'copilot' is in your sources.
			-- Example (if nvim-cmp is also managed by you and not an external suite):
			-- local cmp = require("cmp")
			-- if cmp then
			--   cmp.setup({
			--     sources = cmp.config.sources({
			--       { name = "copilot" },
			--       { name = "nvim_lsp" },
			--       -- other sources
			--     }),
			--     -- other cmp settings
			--   })
			-- end
			-- Often, if nvim-cmp is part of your setup (e.g. from another import
			-- in jeri.plugins or jeri.plugins.lsp), and copilot-cmp is present,
			-- it might be automatically picked up or require minimal setup in your
			-- nvim-cmp configuration file itself to add 'copilot' to its sources list.
		end,
	},
}
