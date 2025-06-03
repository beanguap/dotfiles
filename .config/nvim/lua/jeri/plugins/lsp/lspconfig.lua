-- lua/plugins/lspconfig.lua  (Lazy.nvim style)
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- LSP helper plugins
		{ "williamboman/mason.nvim", config = true },
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
		local cmp_cap = require("cmp_nvim_lsp").default_capabilities()
		local keymap = vim.keymap
		--------------------------------------------------------------------------
		-- 1. Initialize mason-lspconfig before handlers ------------------------
		--------------------------------------------------------------------------
		mason_lspconfig.setup({
			ensure_installed = { "rust_analyzer", "lua_ls", "svelte", "graphql", "emmet_ls" },
			automatic_installation = true,
		})
		--------------------------------------------------------------------------
		-- 2. Diagnostic setup --------------------------------------------------
		--------------------------------------------------------------------------
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}
		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})
		vim.o.signcolumn = "yes"
		--------------------------------------------------------------------------
		-- 3. LspAttach keymaps -------------------------------------------------
		--------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})
		--------------------------------------------------------------------------
		-- 4. Setup individual LSP servers -------------------------------------
		--------------------------------------------------------------------------
		-- Set up servers installed by mason-lspconfig
		local servers = {
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
						procMacro = { enable = true },
					},
				},
			},
			svelte = {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						buffer = bufnr,
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.file) })
						end,
					})
				end,
			},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
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
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
		}

		-- Setup each server with default capabilities
		for server_name, server_config in pairs(servers) do
			server_config.capabilities = cmp_cap
			lspconfig[server_name].setup(server_config)
		end
	end,
}
