local luasnip = require("luasnip")

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(a) return luasnip.lsp_expand(a.body) end,
	},
	window = {},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<S-Tab>"] = cmp.mapping(function()
			vim.lsp.buf.hover()
		end),
		["<C-Space>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
	capabilities = capabilities,
})

-- ASM
lspconfig.asm_lsp.setup({
	capabilities = capabilities,
})

-- C/C++
lspconfig.clangd.setup({
	capabilities = capabilities,
})

-- C#
lspconfig.csharp_ls.setup({
	cmd = { "/home/twig/.dotnet/tools/csharp-ls" }, -- fix this later

	capabilities = capabilities,
})

-- Go (Please)
lspconfig.gopls.setup({
	capabilities = capabilities,
})

-- Python
lspconfig.pylsp.setup({
	capabilities = capabilities,

	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {
						-- Ignore conventions that are stupid.
						"E302",
						"E305",
						"W391",
						"W191",
					}
				}
			}
		}
	}
})

-- Rust
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	diagnostics = {
		enable = true,
		experimental = {
			enable = true,
		},
	},
})

-- TypeScript
lspconfig.tsserver.setup({
	capabilities = capabilities,
})

