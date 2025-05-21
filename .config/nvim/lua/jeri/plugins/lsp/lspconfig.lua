-- lua/plugins/lspconfig.lua  (Lazy.nvim style)
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		-- LSP helper plugins
		{ "williamboman/mason.nvim", config = true }, -- <-- MISSING
		{ "williamboman/mason-lspconfig.nvim", config = true },
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		--------------------------------------------------------------------------
		-- 0. Basic requires -----------------------------------------------------
		--------------------------------------------------------------------------
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_cap = require("cmp_nvim_lsp").default_capabilities() -- :contentReference[oaicite:3]{index=3}
		local keymap = vim.keymap

		--------------------------------------------------------------------------
		-- 1. Modern diagnostic setup -------------------------------------------
		--------------------------------------------------------------------------
		-- Icons (Nerd Font); keys are vim.diagnostic.severity indexes
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		}) -- :contentReference[oaicite:4]{index=4}
		vim.o.signcolumn = "yes" -- avoid jitter

		--------------------------------------------------------------------------
		-- 2. Keymaps on LspAttach ----------------------------------------------
		--------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", { -- :contentReference[oaicite:5]{index=5}
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", opts, { desc = "Show LSP references" })
				)
				keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" })
				)
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Show definitions" })
				)
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", opts, { desc = "Show implementations" })
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Show type definitions" })
				)
				keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code actions" })
				)
				keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Smart rename" })
				)
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					vim.tbl_extend("force", opts, { desc = "Buffer diagnostics" })
				)
				keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
				)
				keymap.set(
					"n",
					"[d",
					vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Prev diagnostic" })
				)
				keymap.set(
					"n",
					"]d",
					vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
				)
				keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
				keymap.set(
					"n",
					"<leader>rs",
					":LspRestart<CR>",
					vim.tbl_extend("force", opts, { desc = "Restart LSP" })
				)
			end,
		})

		--------------------------------------------------------------------------
		-- 3. Mason-LSP handlers -------------------------------------------------
		--------------------------------------------------------------------------
		mason_lspconfig.setup_handlers({ -- :contentReference[oaicite:6]{index=6}
			-- Default handler for most servers -----------------------------------
			function(server_name)
				lspconfig[server_name].setup({ capabilities = cmp_cap })
			end,

			-- Svelte -------------------------------------------------------------
			["svelte"] = function()
				lspconfig.svelte.setup({
					capabilities = cmp_cap,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							buffer = bufnr,
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.file) })
							end,
						})
					end,
				})
			end,

			-- GraphQL ------------------------------------------------------------
			["graphql"] = function()
				lspconfig.graphql.setup({
					capabilities = cmp_cap,
					filetypes = {
						"graphql",
						"gql",
						"svelte",
						"typescriptreact",
						"javascriptreact",
					},
				})
			end,

			-- Emmet --------------------------------------------------------------
			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					capabilities = cmp_cap,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,

			-- Lua (Neovim) -------------------------------------------------------
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = cmp_cap,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					},
				})
			end,
		})
	end,
}
