-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({})
			end,
			keys = { "cs", "ds", "ys" }
		},
		{
			'nvim-telescope/telescope.nvim',
			tag = "0.1.8",
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				local builtin = require('telescope.builtin')
				vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
				vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
				vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
				vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
				vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescop find references" })
				require('telescope').setup({
					defaults = {
						layout_strategy = "vertical",
					}
				})
			end
		},
		{
			'smoka7/hop.nvim',
			version = '*',
			config = function()
				local hop = require('hop')
				vim.keymap.set('', '<leader>fw', hop.hint_words, { desc = 'Hop find word', remap = true })
				hop.setup({})
			end
		},
		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
			},
			config = function()
				local cmp = require('cmp')
				cmp.setup({
					preselect = cmp.PreselectMode.None,
					performance = {
						debounce = 0,
						throttle = 0,
					},
					mapping = cmp.mapping.preset.insert({
						['<C-Space>'] = cmp.mapping.complete(),
						['<CR>'] = cmp.mapping.confirm({ select = false }),
					}),
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end
					},
					sources = {
						{ name = 'nvim_lsp' }
					}
				})
			end,
			event = { "InsertEnter" }
		},
		{ 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
		{
			'neovim/nvim-lspconfig',
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{
					"j-hui/fidget.nvim",
					tag = "legacy",
					opts = {}
				}
			}
		},
		{
			'williamboman/mason.nvim',
			config = function()
				require('mason').setup({})
			end
		},
		{
			'williamboman/mason-lspconfig.nvim',
			config = function()
				require('mason-lspconfig').setup({
					handlers = {
						function(server_name)
							require('lspconfig')[server_name].setup({})
						end
					}
				})
			end
		},
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		{
			"nvimtools/none-ls.nvim",
			ft = { "javascript", "typescript", "json" },
			config = function()
				local null_ls = require('null-ls')
				null_ls.setup {
					sources = {
						null_ls.builtins.formatting.prettier,
					}
				}
			end

		},
		{
			"otavioschwanck/arrow.nvim",
			opts = {
				show_icons = false,
				leader_key = ',', -- Recommended to be a single key
				buffer_leader_key = 'm', -- Per Buffer Mappings
			}
		},
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require('gitsigns').setup({})
			end,
			event = { "BufReadPre", "BufNewFile" },
		},
		{
			"FabijanZulj/blame.nvim",
			lazy = false,
			config = function()
				require('blame').setup {}
				vim.keymap.set('n', '<leader>gb', '<CMD>BlameToggle<CR>',
					{ desc = 'Telescope find files' })
			end,
		},
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = {
						"c", "lua", "vim", "vimdoc", "javascript", "sql", "perl", "rust",
						"haskell", "go", "bash"
					},
					sysnc_install = false,
					highlight = { enable = true },
					indent = { enable = true }

				})
			end
		},
		{
			'stevearc/oil.nvim',
			opts = {}
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "default" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
