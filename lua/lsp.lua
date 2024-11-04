-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

local function autoformat(client, bufnr)
	if not client.supports_method('textDocument/formatting') then
		return
	end
	if client.name == 'typescript-tools' then
		return
	end
	require('lsp-zero').buffer_autoformat()
end

local function toggle_diagnostic()
	local enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not enabled)
end

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end
		autoformat(client, event.buf)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<leader>fm', '<cmd>lua vim.lsp.buf.format({async = false})<cr>', opts)
		vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('n', '<leader>d', toggle_diagnostic, { desc = "toggle diagnostic" })
	end,
})
