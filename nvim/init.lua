vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.splitright = true

-- Keybinds (General)
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>')
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)

-- Keybinds (LSP)
vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- Keybinds (plugins)
vim.keymap.set('n', '<leader>sf', ":Pick files<CR>")
vim.keymap.set('n', '<leader>sg', ":Pick grep<CR><CR>")
vim.keymap.set('n', '<leader>sh', ":Pick help<CR>")
vim.keymap.set('n', '<leader><leader>', ":Pick buffers<CR>")
vim.keymap.set('n', '-', ":Oil<CR>")

-- Plugins
vim.pack.add({
	{ src = "https://github.com/aktersnurra/no-clown-fiesta.nvim" },
	{ src = "https://github.com/bettervim/yugen.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/echasnovski/mini.cursorword" },
	{ src = "https://github.com/echasnovski/mini.jump" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require "mini.pick".setup()
require "mini.surround".setup()
require "mini.jump".setup()
require "mini.cursorword".setup()
require "oil".setup()

require "nvim-treesitter.configs".setup {
	auto_install = true,
	ensure_installed = { "go", "lua" },
	highlight = { enable = true },
}

vim.lsp.enable({ "lua_ls", "gopls" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.cmd("colorscheme yugen")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})


-- Accept capital W for write
vim.api.nvim_create_user_command('W', function(opts)
	local cmd = string.format('write %s', opts.args)
	vim.cmd(cmd)
end, {
	nargs = '*',
	complete = 'file',
	range = '%',
	bar = true,
})

vim.api.nvim_create_user_command('Wa', function(opts)
	local cmd = string.format('wall %s', opts.args)
	vim.cmd(cmd)
end, {
	nargs = '*',
	complete = 'file',
	range = '%',
	bar = true,
})
