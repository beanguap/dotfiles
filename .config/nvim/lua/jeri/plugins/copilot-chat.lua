-- File: lua/jeri/plugins/copilot-chat.lua
return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua", -- Explicitly list base copilot if not already loaded
			"nvim-lua/plenary.nvim",
		},
		opts = {
			auto_insert_mode = true,
			question_header = " You",
			answer_header = " Copilot",
			window = {
				layout = "vertical",
				width = 0.4,
			},
		},
		keys = {
			{
				"<leader>ac",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "Toggle Copilot Chat",
				mode = { "n", "v" },
			},
			{
				"<leader>aq",
				function()
					vim.ui.input({ prompt = "Quick Chat: " }, function(input)
						if input and input ~= "" then
							require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
						end
					end)
				end,
				desc = "Copilot Quick Chat",
				mode = { "n", "v" },
			},
			-- Add other keymaps as desired
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})
			chat.setup(opts)
		end,
	},
}
