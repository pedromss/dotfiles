vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorcolumn = 80

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.cursorline = true
vim.o.cursorcolumn = false

vim.o.textwidth = 100

vim.o.list = true
vim.o.listchars = 'tab:▸·,trail:·,eol:↵'

-- vim.g.mapleader = ','
-- vim.g.maplocalleader = '\\'

vim.opt.wildignore = { '**/node_modules/**', '**/_build/**', '**/target/**' }

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "https://github.com/folke/lazy.nvim.git",
--         "--branch=stable", -- latest stable release
--         lazypath,
--     })
-- end
-- vim.opt.rtp:prepend(lazypath)
-- require("lazy").setup({
--     {
--         'folke/tokyonight.nvim',
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.cmd([[colorscheme tokyonight-moon]])
--         end
--     },
--     { 'tpope/vim-fugitive' },
--     {
--         'nvim-telescope/telescope.nvim',
--         tag = '0.1.4',
--         dependencies = { 'nvim-lua/plenary.nvim' },
--         config = function()
--             local builtin = require('telescope.builtin')
--             vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--             vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--             vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--             vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--         end
--     },
--     {
--         "nvim-neo-tree/neo-tree.nvim",
--         branch = "v3.x",
--         dependencies = {
--             "nvim-lua/plenary.nvim",
--             "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--             "MunifTanjim/nui.nvim",
--         },
--         config = function()
--             vim.keymap.set('n', '<localleader>t', 'Neotree', {})
--         end
--     }
-- }, {})
