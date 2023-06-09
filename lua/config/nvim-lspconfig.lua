local luasnip = require("luasnip")

local cmp = require("cmp")
cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.confirm(),
	}),
	snippet = {
		expand = function(a) return luasnip.lsp_expand(a.body) end,
	},
})

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
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- C/C++
lspconfig.clangd.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- TypeScript
lspconfig.tsserver.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})



