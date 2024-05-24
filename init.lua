-- goals for nvim
--x 1. fuzzy finder
--x 2. command pallet (fzf + fzf-lua) mapped to Shift+P
--x 3. line numbers
--x 4. use mouse
--x 5. color scheme
--x 6. better syntax highliting (treesitter)
-- 7. lsp
-- 8. copilot
-- 9. better indenting
-- 10. git integration(?)
-- 11. debugger
-- 12. folding
-- 13. pair parens, brackets etc
-- 14. code formatter
-- 15. lint on save
-- 16. surround text with quotes
-- 17. order text
-- 18. org mode(?)
-- 19. make all quotes single quotes (part of linting)
-- 20. split one line into multi lines
-- 21. auto number lists
-- 22. search for symbol 
require "paq" {
	"savq/paq-nvim", -- Let Paq manage itself
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
    	"ibhagwan/fzf-lua",
    	"rebelot/kanagawa.nvim",
    	{"nvim-treesitter/nvim-treesitter", build = ':TSUpdate'},
    	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'};
    	{'williamboman/mason.nvim'};
    	{'williamboman/mason-lspconfig.nvim'};
	{'neovim/nvim-lspconfig'};
	{'hrsh7th/nvim-cmp'};
	{'hrsh7th/cmp-nvim-lsp'};
	{'L3MON4D3/LuaSnip'};
}
-- remaps
vim.cmd [[set mouse=a]]

vim.g.mapleader = " "
	
vim.wo.number = true

-- dir view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- 'command pallet'
local fzf = require('fzf-lua')
vim.keymap.set('n', '<S-p>', fzf.commands,{})


-- kanagawa color scheme
require('kanagawa').setup({
	--transparent = true
	theme = "wave"
})

vim.cmd("colorscheme kanagawa")

-- treesitter languages
require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'c', 'lua', 'typescript', 'javascript', 'python', 'go', 'sql', 'terraform', 'hcl', 'json'}
	})

-- lsp setup
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
lsp_zero.default_keymaps({buffer = bufnr}) end)
lsp_zero.setup_nvim_cmp({
	select_behavior = 'insert'
})


-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'terraformls', 'clangd', 'lua_ls'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})


--completions
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
